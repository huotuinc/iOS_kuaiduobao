//
//  DetailCalculateViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "DetailCalculateViewController.h"
#import "DetailCalculateMainCView.h"
#import "DetailCalculateNumberCView.h"
#import "DetailCalculateFormulaCView.h"
#import "DetailCalculateATableViewCell.h"
#import "AppCountResultModel.h"
#import "AppUserNumberModel.h"
static NSString *cellDCA = @"cellDCA";
@interface DetailCalculateViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DetailCalculateFormulaCView *sectionAView;
@property (nonatomic, strong) DetailCalculateMainCView *sectionBView;
@property (nonatomic, strong) DetailCalculateMainCView *sectionCView;
@property (nonatomic, strong) DetailCalculateNumberCView *sectionDView;
@property (nonatomic) BOOL isExpanded;//用于判断section是否展开 YES展开 NO未展开
@property (nonatomic, strong) NSMutableArray *numberList;
@property (nonatomic, strong) AppCountResultModel *resultModel;


@end

@implementation DetailCalculateViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationItem changeNavgationBarTitle:@"计算详情"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBarButtonItem];
    [self getNumberList];
}
- (void)createBarButtonItem{
//    UIButton *buttonL=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
//    [buttonL setBackgroundImage:[UIImage imageNamed:@"back_gray"] forState:UIControlStateNormal];
//    [buttonL bk_whenTapped:^{
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
//    UIBarButtonItem *bbiL=[[UIBarButtonItem alloc]initWithCustomView:buttonL];
//    self.navigationItem.leftBarButtonItem=bbiL;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:COLOR_NAV_BACK];
}
#pragma mark 网络请求计算详情
- (void)getNumberList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"issueId"] =self.issueId;
    
    [UserLoginTool loginRequestGet:@"getCountResultByIssueId" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            _resultModel = [AppCountResultModel mj_objectWithKeyValues:json[@"resultData"][@"data"]];
            _numberList = [AppUserNumberModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"data"][@"userNumbers"]];
            if (!_tableView) {
                [self createTableView];

            }else {
                [_tableView reloadData];
            }
        }
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog (@"%@",error);
    }];
    
}

- (void)createTableView{
    _isExpanded = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailCalculateATableViewCell" bundle:nil] forCellReuseIdentifier:cellDCA];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && _isExpanded == YES) {
        DetailCalculateATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDCA forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.labelA.text = @"夺宝时间";
            cell.labelB.text = @"用户账号";
            cell.labelDate.text = @"";
            cell.labelNumber.text = @"";
            cell.labelName.text = @"";

        }else {
            AppUserNumberModel *userModel = _numberList[indexPath.row - 1];
            cell.labelDate.text = userModel.buyTime;
            cell.labelNumber.text = [NSString stringWithFormat:@"→%@",userModel.number];
            cell.labelName.text = userModel.nickName;
            cell.labelA.text = @"";
            cell.labelB.text = @"";

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;


}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return ADAPT_HEIGHT(50);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1 && _isExpanded == YES) {
        return _numberList.count + 1;
    }else {
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCalculateFormulaCView" owner:nil options:nil];
        _sectionAView = [nib firstObject];
        _sectionAView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(170.f));
        return _sectionAView;
    }
    if (section == 1) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCalculateMainCView" owner:nil options:nil];
        _sectionBView = [nib firstObject];
        _sectionBView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(160.f));
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"= %@",_resultModel.numberA]];
        [attString addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_DATE range:NSMakeRange(0, 2)];
        _sectionBView.labelC.attributedText = attString;
        _sectionBView.labelShow.userInteractionEnabled = YES;
        _sectionBView.labelB.text = [NSString stringWithFormat:@"= 截止该商品开奖时间点前最后%ld条全站参与记录",_numberList.count];
//        __block DetailCalculateViewController *weakSelf = self;
        
        if (_isExpanded) {
            _sectionBView.labelShow.text = @"收起";
        }else {
            _sectionBView.labelShow.text = @"展开";
        }
        [_sectionBView bk_whenTapped:^{
            if (_isExpanded) {
                LWLog(@"改成展开");
                _sectionBView.labelShow.text = @"展开";
                _isExpanded = NO;
            }else {
                LWLog(@"改成收起");
                _sectionBView.labelShow.text = @"收起";
                _isExpanded = YES;
            }
            [tableView reloadData];
        }];
//        [_sectionBView.labelShow bk_whenTapped:^{
//            if (_isExpanded) {
//                LWLog(@"改成展开");
//                _sectionBView.labelShow.text = @"展开";
//                _isExpanded = NO;
//            }else {
//                LWLog(@"改成收起");
//                _sectionBView.labelShow.text = @"收起";
//                _isExpanded = YES;
//            }
//            [tableView reloadData];
////            _sectionBView.labelShow.userInteractionEnabled = YES;
////            _sectionBView.labelShow.text = @"11111";
//        }];
        return _sectionBView;
    }
    if (section == 2) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCalculateMainCView" owner:nil options:nil];
        _sectionCView = [nib firstObject];
        _sectionCView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(160.f));
        _sectionCView.labelA.text = @"数值B";
        _sectionCView.labelB.text = @"= 最近一起中国福利彩票\"老时时彩\"的开奖结果";
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"= %@",_resultModel.numberB]];
        [attString addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_DATE range:NSMakeRange(0, 2)];
        _sectionCView.labelC.attributedText = attString;
        _sectionCView.labelShow.hidden = YES;
        return _sectionCView;
    }
    if (section == 3) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCalculateNumberCView" owner:nil options:nil];
        _sectionDView = [nib firstObject];
        _sectionDView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(165.f));
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"幸运号码:  %@",_resultModel.luckNumber]];
        [attString addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_DATE range:NSMakeRange(0, 5)];
        _sectionDView.labelB.attributedText = attString;
        _sectionDView.backgroundColor = [UIColor clearColor];

        return _sectionDView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return  view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return ADAPT_HEIGHT(170.f);
    }
    if (section == 1 || section == 2) {
        return ADAPT_HEIGHT(160.f);
    }
    if (section == 3) {
        return ADAPT_HEIGHT(165.f);
    }
    return 0.f;
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
