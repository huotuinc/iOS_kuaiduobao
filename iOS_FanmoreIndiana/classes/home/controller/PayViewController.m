//
//  PayViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "PayViewController.h"
#import "PayATableViewCell.h"
#import "PayBTableViewCell.h"
#import "PayButtonTableViewCell.h"
#import "AppPayModel.h"
#import "UserModel.h"
#import "TabBarController.h"
static NSString *cellPA=@"cellPA";
static NSString *cellPB=@"cellPB";
static NSInteger _whichPay = 0 ;  //0没有 1微信 2支付宝

@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) PayButtonTableViewCell *payView;

@property (nonatomic,strong) UserModel *userInfo;

@property (nonatomic,strong) AppPayModel *payBackModel;


@end

@implementation PayViewController{
    NSMutableArray *_titleArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden = YES;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.view.backgroundColor=[UIColor whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArray = [NSMutableArray arrayWithArray:@[@"红包折扣",@"余额支付",@"其他支付方式",@"微信支付",@"支付宝支付"]];
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
    self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    [self createBarButtonItem];
    [self createPayView];
    [self createTableView];
}
#pragma mark  网络支付

-(void)paySuccessOrFail {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"payType"] = @2;
    dic[@"redPacketsId"] = _payModel.redPacketsId;
//    dic[@"redPacketsId"] = nil;
    NSInteger payMoney = [_payModel.totalMoney integerValue] - [_payModel.redPacketsMinusMoney integerValue];
    dic[@"money"] = [NSNumber numberWithInteger:payMoney];
    [UserLoginTool loginRequestPostWithFile:@"pay" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            LWLog(@"%@",json[@"resultDescription"]);
            _payBackModel = [AppPayModel mj_objectWithKeyValues:json[@"resultData"][@"data"]];
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];

            [self remainPay];

        }else {
            LWLog(@"%@",json[@"resultDescription"]);
            [SVProgressHUD showErrorWithStatus:@"支付失败"];

        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [SVProgressHUD showSuccessWithStatus:@"支付失败"];
        
        
    } withFileKey:nil];
    
    
}
- (void)remainPay {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"orderNo"] = _payBackModel.orderNo;
    dic[@"money"] = _payBackModel.fee;
    [UserLoginTool loginRequestPostWithFile:@"remainPay" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            LWLog(@"%@",json[@"resultDescription"]);
//            _payBackModel = [AppPayModel mj_objectWithKeyValues:json[@"resultData"][@"data"]];
//            [SVProgressHUD showSuccessWithStatus:@"支付成功"];

            
        }else {
            LWLog(@"%@",json[@"resultDescription"]);

            
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
//        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        
        
    } withFileKey:nil];


}
-(void)createPayView{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"PayButtonTableViewCell" owner:nil options:nil];
    _payView=[nib firstObject];
    _payView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(130));
    [_payView.buttonPay bk_whenTapped:^{
        [self paySuccessOrFail];
    }];
}
-(void)createBarButtonItem{
    UIButton *buttonL=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [buttonL setBackgroundImage:[UIImage imageNamed:@"back_gray"] forState:UIControlStateNormal];
    [buttonL addTarget:self action:@selector(clickLightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiL=[[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem=bbiL;
    
    UIButton *buttonR=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [buttonR setBackgroundImage:[UIImage imageNamed:@"more_gray"]forState:UIControlStateNormal];
    [buttonR addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiR=[[UIBarButtonItem alloc]initWithCustomView:buttonR];
    self.navigationItem.rightBarButtonItem=bbiR;
}
-(void)clickLightButton{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickRightButton{
    
}

-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"PayATableViewCell" bundle:nil] forCellReuseIdentifier:cellPA];
    [_tableView registerNib:[UINib nibWithNibName:@"PayBTableViewCell" bundle:nil] forCellReuseIdentifier:cellPB];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView = _payView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
}


#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        PayATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellPA forIndexPath:indexPath];
        cell.labelA.text = @"奖品合计";
        cell.labelB.text = [NSString stringWithFormat:@"%@",_payModel.totalMoney];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        if (indexPath.row < 3) {
            PayATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellPA forIndexPath:indexPath];
            cell.labelA.text = _titleArray[indexPath.row];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (indexPath.row != 0) {
                cell.imageVTop.hidden = YES;
            }
            if (indexPath.row == 0) {
                cell.labelB.text = _payModel.redPacketsTitle;
                cell.labelCount.text = [NSString stringWithFormat:@" %@个红包可用 ",_payModel.redPacketsNumber];
            }
            if (indexPath.row == 1) {
                cell.labelMoney.text = [NSString stringWithFormat:@"(余额: %@元)",self.userInfo.money];
            }
            if (indexPath.row == 2) {
                CGFloat elsePay = [_payModel.totalMoney floatValue] - [_payModel.redPacketsMinusMoney floatValue];
                cell.labelB.text = [NSString stringWithFormat:@"%.1f元",elsePay];
            }
            return cell;
        }else{
            PayBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellPB forIndexPath:indexPath];
            cell.labelPay.text = _titleArray[indexPath.row];
            if (indexPath.row != _titleArray.count - 1) {
                cell.imageVBottom.hidden = YES;
            }else {
                cell.imageVLine.hidden = YES;

            }
            [cell.buttonSelect bk_whenTapped:^{
                
                _whichPay = indexPath.row - 2;
                
            }];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    return nil;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return _titleArray.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return ADAPT_HEIGHT(100);
    }else {
        if (indexPath.row<3) {
            return ADAPT_HEIGHT(100);
        }else{
            return ADAPT_HEIGHT(90);
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return ADAPT_HEIGHT(20);

    }else{
        return 0.0f;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(20))];
    view.backgroundColor = COLOR_BACK_MAIN;
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            RedChooseViewController *red = [[RedChooseViewController alloc] init];
            red.delegate = self;
            red.money = _payModel.totalMoney;
            [self.navigationController pushViewController:red animated:YES];
        }
    }
}
-(void)sendRedId:(NSNumber *)redId andTitle: (NSString *)title andDiscountMoney: (NSNumber *)discountMoeny{
    _payModel.redPacketsId = redId;
    _payModel.redPacketsTitle = title;
    _payModel.redPacketsMinusMoney = discountMoeny;
    [_tableView reloadData];
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
