//
//  RechargeController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//
#import "RechargeCell.h"
#import "RechargeController.h"
#import "PutModel.h"

@interface RechargeController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *rechargeList;

@end

@implementation RechargeController

static NSString *rechargeIdentify = @"rechargeIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.rechargeList = [NSMutableArray array];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];

    [self.view addSubview:table];
    self.tableView = table;
    [self.tableView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:rechargeIdentify];
    [self.tableView removeSpaces];
    [self setupRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self getNewList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableVIew 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rechargeList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:rechargeIdentify forIndexPath:indexPath];
    cell.model = self.rechargeList[indexPath.row];
    return cell;
}


#pragma mark 网络请求

- (void)getNewList {
    
    [self.rechargeList removeAllObjects];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"lastId"] = @0;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyPutList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_header endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [PutModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.rechargeList addObjectsFromArray:temp];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [_tableView.mj_header endRefreshing];
        LWLog(@"%@",error);
    }];
    
}

- (void)getMoreList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    PutModel *model = [self.rechargeList lastObject];
    dic[@"lastId"] = model.pid;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyPutList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_footer endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [PutModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.rechargeList addObjectsFromArray:temp];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [_tableView.mj_footer endRefreshing];
        LWLog(@"%@",error);
    }];
}


- (void)setupRefresh
{
    
    MJRefreshNormalHeader * headRe = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewList)];
    _tableView.mj_header = headRe;
    
    MJRefreshBackNormalFooter * Footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreList)];
//    Footer.refreshingTitleHidden = YES;
    _tableView.mj_footer = Footer;
    
}

@end
