//
//  DetailPastViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "DetailPastViewController.h"
#import "DetailPastTableViewCell.h"
#import "AppPastListModel.h"
#import "DetailPastingTableViewCell.h"
static NSString * cellDPast=@"cellDPast";
static NSString * cellDPasting=@"cellDPasting";

@interface DetailPastViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *pastList;
@property (nonatomic,strong) UIView *headView;


@end

@implementation DetailPastViewController{

}

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
    self.pastList=[NSMutableArray array];
    [self createNavgationBarTitle];
    [self createBarButtonItem];
    [self createHeadView];
    [self getAppPastList];
}

-(void)createNavgationBarTitle{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:FONT_SIZE(36)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"往期揭晓";
    self.navigationItem.titleView = titleLabel;
}
- (void)setupRefresh
{
    
    
    MJRefreshNormalHeader * headRe = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getAppPastList)];
    _tableView.mj_header = headRe;
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(getNewData)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    //    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    //    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    //    self.tableView.headerRefreshingText = @"正在刷新最新数据,请稍等";
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
        MJRefreshAutoNormalFooter * Footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMorePastList)];
        _tableView.mj_footer = Footer;
    
    //        [_tableView addFooterWithTarget:self action:@selector(getMoreGoodList)];
    
    
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
-(void)createHeadView{
    self.headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(20))];
    _headView.backgroundColor=[UIColor whiteColor];
}
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailPastTableViewCell" bundle:nil] forCellReuseIdentifier:cellDPast];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailPastingTableViewCell" bundle:nil] forCellReuseIdentifier:cellDPasting];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableHeaderView=self.headView;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self setupRefresh];
    
}
#pragma mark 网络请求往期揭晓列表
/**
 *  下拉刷新
 */
- (void)getAppPastList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"goodsId"] = self.goodsId;
    dic[@"lastId"] = self.lastId;
    [UserLoginTool loginRequestGet:@"getPastList" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [AppPastListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.pastList removeAllObjects];
            [self.pastList addObjectsFromArray:temp];
            if (_tableView) {
                [self createTableView];
            }else {
                [_tableView reloadData];
            }
        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
        [_tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    
}

/**
 *  上拉加载更多
 */
- (void)getMorePastList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"goodsId"] = self.goodsId;
    AppPastListModel *model=[_pastList lastObject];
    dic[@"lastId"] =model.issueId;
    [UserLoginTool loginRequestGet:@"getPastList" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            NSArray *temp = [AppPastListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.pastList addObjectsFromArray:temp];
            
            [_tableView reloadData];
        }
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog (@"%@",error);
    }];
    
}

#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AppPastListModel *model = _pastList[indexPath.row];
    if ([model.status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
        DetailPastingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellDPasting forIndexPath:indexPath];
        NSMutableAttributedString *attString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"期号 : %@ 请稍后,正在揭晓...",model.issueId]];
        [attString addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_CONTENT range:NSMakeRange(0, 6+[NSString stringWithFormat:@"%@",model.issueId].length)];
        cell.labelItem.attributedText=attString;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        DetailPastTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellDPast forIndexPath:indexPath];
        NSString *dateString = [self changeTheTimeStamps:model.date andTheDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        cell.labelItem.text=[NSString stringWithFormat:@"期号 : %@ ( 揭晓时间 : %@ )",model.issueId,dateString];
        
        NSMutableAttributedString *attString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"获奖者: %@",model.nickName]];
        [attString addAttribute:NSForegroundColorAttributeName value:COLOR_SHINE_BLUE range:NSMakeRange(5, [NSString stringWithFormat:@"%@",model.nickName].length)];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FONT_SIZE(28)] range:NSMakeRange(5, [NSString stringWithFormat:@"%@",model.nickName].length)];
        cell.labelWinner.attributedText=attString;
        
        cell.labelCity.text=[NSString stringWithFormat:@"( %@ IP%@ )",model.city,model.ip];
        cell.labelID.text=[NSString stringWithFormat:@"用户ID: %@(唯一不变标识符)",model.userId];
        
        NSMutableAttributedString *numberString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"幸运号: %@",model.luckyNumber]];
        [numberString addAttribute:NSForegroundColorAttributeName value:COLOR_BUTTON_ORANGE range:NSMakeRange(5, [NSString stringWithFormat:@"%@",model.luckyNumber].length)];
        cell.labelNumber.attributedText=numberString;
        
        NSMutableAttributedString *countString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"本期参与: %@人次",model.attendAmount]];
        [countString addAttribute:NSForegroundColorAttributeName value:COLOR_BUTTON_ORANGE range:NSMakeRange(6, [NSString stringWithFormat:@"%@",model.attendAmount].length)];
        cell.labelAttend.attributedText=countString;
        
        [cell.imageVHead sd_setImageWithURL:[NSURL URLWithString:model.userHeadUrl]];
        return cell;
    }
    return nil;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _pastList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppPastListModel *model = _pastList[indexPath.row];
    if ([model.status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
        return ADAPT_HEIGHT(90);
    }else{
        return ADAPT_HEIGHT(330);
    }
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
