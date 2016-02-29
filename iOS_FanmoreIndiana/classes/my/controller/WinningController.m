//
//  WinningController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/31.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "WinningController.h"
#import "WinningCell.h"
#import "WinningModel.h"
#import "AdressController.h"
#import "WinningConfirmController.h"

@interface WinningController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *winningArray;

@end

@implementation WinningController

static NSString *winningIdentify = @"winningIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"中奖记录";
    
    self.winningArray = [NSMutableArray array];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.snatch.layer.cornerRadius = 5;
    self.tabBarController.tabBar.hidden = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    [self.tableView registerNib:[UINib nibWithNibName:@"WinningCell" bundle:nil] forCellReuseIdentifier:winningIdentify];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

#pragma mark -tableView 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _winningArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 207;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WinningCell *cell = [tableView dequeueReusableCellWithIdentifier:winningIdentify forIndexPath:indexPath];
    cell.model = self.winningArray[indexPath.row];
    [cell.confirm bk_whenTapped:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AdressController *address = [story instantiateViewControllerWithIdentifier:@"AdressController"];
        address.tpye = 2;
        address.winningModel = self.winningArray[indexPath.row];
        [self.navigationController pushViewController:address animated:YES];
    }];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WinningConfirmController *confirm = [story instantiateViewControllerWithIdentifier:@"WinningConfirmController"];
    WinningModel *model = self.winningArray[indexPath.row];
    confirm.issueId = model.issueId;
    [self.navigationController pushViewController:confirm animated:YES];
}

- (void)hiddenNoneImageAndLabels {
    self.winImage.hidden = YES;
    self.showLabel.hidden = YES;
    self.snatch.hidden = YES;
    self.tableView.hidden = NO;
}

- (void)showNoneImageAndLabels {
    self.winImage.hidden = NO;
    self.showLabel.hidden = NO;
    self.snatch.hidden = NO;
    self.tableView.hidden = YES;
}

- (IBAction)goHomeController:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CannelLoginFailure object:nil];
    
}


#pragma mark 网络请求

- (void)getNewList {
    
    [self.winningArray removeAllObjects];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    dic[@"lastId"] = @0;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyLotteryList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_header endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [WinningModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.winningArray addObjectsFromArray:temp];
            [self.tableView reloadData];
        }
        if (self.winningArray.count == 0) {
            [self showNoneImageAndLabels];
        }else {
            [self hiddenNoneImageAndLabels];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [_tableView.mj_header endRefreshing];
        LWLog(@"%@",error);
    }];
    
}

- (void)getMoreList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    WinningModel *model = [self.winningArray lastObject];
    dic[@"lastId"] = model.pid;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyLotteryList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_footer endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [WinningModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.winningArray addObjectsFromArray:temp];
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
    
    MJRefreshAutoNormalFooter * Footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreList)];
    _tableView.mj_footer = Footer;
    
}




@end
