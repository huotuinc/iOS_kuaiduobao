//
//  RedChooseViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RedChooseViewController.h"
#import "ListRedPacketCell.h"
#import "RedPacketsModel.h"
static NSString * cellLRed=@"cellLRed";
@interface RedChooseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *redList;

@end

@implementation RedChooseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden=YES;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.view.backgroundColor=[UIColor whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redList=[NSMutableArray array];
    [self createNavgationBarTitle];
    [self createBarButtonItem];
    [self getAppRedList];
}

-(void)createNavgationBarTitle{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:FONT_SIZE(36)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"红包选择";
    self.navigationItem.titleView = titleLabel;
}

-(void)createBarButtonItem{
    UIButton *buttonL=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [buttonL setBackgroundImage:[UIImage imageNamed:@"back_gray"] forState:UIControlStateNormal];
    [buttonL addTarget:self action:@selector(clickLightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiL=[[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem=bbiL;
}
-(void)clickLightButton{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"ListRedPacketCell" bundle:nil] forCellReuseIdentifier:cellLRed];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
}
#pragma mark 网络请求红包列表

- (void)getAppRedList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"money"] = self.money;
    [UserLoginTool loginRequestGet:@"getUseableRedRedPacketsList" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [RedPacketsModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.redList removeAllObjects];
            [self.redList addObjectsFromArray:temp];
            if (!_tableView) {
                [self createTableView];
            }else {
                [_tableView reloadData];
            }
        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
//        [_tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    
}



#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RedPacketsModel *model = _redList[indexPath.row];
    ListRedPacketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellLRed forIndexPath:indexPath];
    [cell setModel:model];
    cell.buttonSelect.tag = 200 +indexPath.row;
#pragma mark 红包选择
    [cell.buttonSelect bk_whenTapped:^{
//        for (int i =0; i<_redList.count; i++) {
//            UIButton *btn = [cell viewWithTag:200+i];
//            btn.selected =NO;
//        }
        cell.buttonSelect.selected =YES;
        NSInteger row = cell.buttonSelect.tag -200;
        RedPacketsModel *RedModel = _redList[row];
        //增加代码的安全性
        if ([self.delegate respondsToSelector:@selector(sendRedId:andTitle:andDiscountMoney:)]) {
            [self.delegate sendRedId:RedModel.pid andTitle:RedModel.title andDiscountMoney:RedModel.minusMoney];
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _redList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 114.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/**
 *  13位时间戳转为正常时间(可设置样式)
 *
 *  @param time 时间戳
 *
 *  @return
 */
-(NSString *)changeTheTimeStamps:(NSNumber *)time andTheDateFormat:(NSString *)dateFormat{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:dateFormat];
    //将13位时间戳转为正常时间格式
    NSString * str = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[time longLongValue]/1000]];
    return str;
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
