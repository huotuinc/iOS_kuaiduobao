//
//  DetailShareViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "DetailShareViewController.h"
#import "DetailShareTableViewCell.h"
#import "AppShareListModel.h"
#import "DetailShareNextViewController.h"
static NSString *cellDShare=@"cellDShare";
@interface DetailShareViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *shareList;


@end

@implementation DetailShareViewController




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden=YES;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationItem changeNavgationBarTitle:@"晒单分享"];
    [self getShareList];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _shareList = [NSMutableArray array];
    [self createNavgationBarTitle];
    [self createBarButtonItem];
    [self createTableView];
}

-(void)createNavgationBarTitle{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:FONT_SIZE(36)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"晒单分享";
    self.navigationItem.titleView = titleLabel;
}

- (void)setupRefresh
{
    
    
    MJRefreshNormalHeader * headRe = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getShareList)];
    _tableView.mj_header = headRe;

    
    MJRefreshAutoFooter * Footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreShareList)];
    _tableView.mj_footer = Footer;
    
    
}
#pragma mark 网络请求往期分享列表
/**
 *  下拉刷新
 */
- (void)getShareList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"goodsId"] = self.goodsId;
    dic[@"lastId"] = @0;
    [UserLoginTool loginRequestGet:@"getShareOrderListByGoodsId" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [AppShareListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.shareList removeAllObjects];
            [self.shareList addObjectsFromArray:temp];
            [_tableView reloadData];
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
- (void)getMoreShareList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"goodsId"] = self.goodsId;
    AppShareListModel *model=[_shareList lastObject];
    dic[@"lastId"] =model.pid;
    [UserLoginTool loginRequestGet:@"getShareOrderListByGoodsId" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            NSArray *temp = [AppShareListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.shareList addObjectsFromArray:temp];
            
            [_tableView reloadData];
        }
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog (@"%@",error);
    }];
    
}
-(void)createBarButtonItem{

    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:COLOR_NAV_BACK];
}




-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailShareTableViewCell" bundle:nil] forCellReuseIdentifier:cellDShare];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self setupRefresh];
    
}

#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailShareTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellDShare forIndexPath:indexPath];
    AppShareListModel *model = _shareList[indexPath.row];
    [cell.imageVHead sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl] placeholderImage:[UIImage imageNamed:@"mrtx"]];
    cell.labelDate.text=[self changeTheTimeStamps:model.time andTheDateFormat:@"MM-dd HH:mm"];
    cell.labelName.text=model.nickName;
    cell.labelTitle.text=model.shareOrderTitle;
    cell.labelGoods.text=model.title;
    cell.labelItem.text=[NSString stringWithFormat:@"期号: %@",model.issueNo];
    cell.labelContent.text=model.content;
    for (int i = 0 ; i<model.pictureUrls.count; i++) {
        UIImageView *imageV=[cell viewWithTag:200+i];
        [imageV sd_setImageWithURL:[NSURL URLWithString:model.pictureUrls[i]]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _shareList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ADAPT_HEIGHT(500);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppShareListModel *model = _shareList[indexPath.row];
    DetailShareNextViewController *next =[[DetailShareNextViewController alloc] init];
    next.shareId = model.pid;
    [self.navigationController pushViewController:next animated:YES];
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
    NSString * str = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[time longLongValue] / 1000]];
    return str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
    
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
