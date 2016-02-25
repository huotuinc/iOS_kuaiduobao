//
//  RedPacketController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RedPacketController.h"
#import "RedPacketCell.h"
#import "RedPacketsModel.h"

@interface RedPacketController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) NSInteger selectMark;
@property (nonatomic, strong) NSMutableArray *redList;

//@property (nonatomic, strong) NSNumber *unused;
//@property (nonatomic, strong) NSNumber *usedOrExpire;

@end

@implementation RedPacketController

static NSString *redPacketIdentify = @"redPactetIdentify";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.redList = [NSMutableArray array];
    self.selectMark = 0;
    
    self.slider = [[UIView alloc] initWithFrame:CGRectMake(0, 33, KScreenWidth / 2, 2)];
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth / 8, 0, KScreenWidth / 4, 2)];
    redView.backgroundColor = [UIColor redColor];
    [self.slider addSubview:redView];
    self.slider.tag = 1001;
    [self.possess setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.selectBgView addSubview:self.slider];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.953 alpha:1.000];
    
    self.snatch.layer.cornerRadius = 5;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RedPacketCell" bundle:nil] forCellReuseIdentifier:redPacketIdentify];
    [self.tableView removeSpaces];
    [self setupRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    
    [self getNewList];
}


- (void)hiddenNoneImageAndLabels {
    self.noneImage.hidden = YES;
    self.noneLabel.hidden = YES;
    self.snatch.hidden = YES;
    self.tableView.hidden = NO;
}

- (void)showNoneImageAndLabels {
    self.noneImage.hidden = NO;
    self.noneLabel.hidden = NO;
    self.snatch.hidden = NO;
    self.tableView.hidden = YES;
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

#pragma mark 



#pragma mark 按钮点击事件

- (IBAction)possessAction:(id)sender {
    
    if (self.slider.tag == 1000) {
        [UIView animateWithDuration:0.15 animations:^{
            self.slider.frame = CGRectMake(0, _slider.frame.origin.y, KScreenWidth / 2, 2);
            self.slider.tag = 1001;
            [self.possess setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.used setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.selectMark = 0;
            [self getNewList];
        }];
    }
    
}

- (IBAction)usedAction:(id)sender {
    
    if (self.slider.tag == 1001) {
        [UIView animateWithDuration:0.15 animations:^{
            self.slider.frame = CGRectMake(KScreenWidth / 2, _slider.frame.origin.y, KScreenWidth / 2, 2);
            self.slider.tag = 1000;
            [self.used setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.possess setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.selectMark = 1;
            [self getNewList];
        }];
    }
    
    
}
- (IBAction)snatchAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CannelLoginFailure object:nil];
    
}

#pragma mark -tableView 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.redList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 114;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RedPacketCell *cell = [tableView dequeueReusableCellWithIdentifier:redPacketIdentify forIndexPath:indexPath];
    cell.selectMark = self.selectMark;
    cell.model = self.redList[indexPath.row];
    return  cell;
}


#pragma mark 网络请求

- (void)getNewList {
    
    [self.redList removeAllObjects];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @(self.selectMark);
    dic[@"lastId"] = @0;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyRedPacketsList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_header endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [RedPacketsModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.redList addObjectsFromArray:temp];
            [self.tableView reloadData];
        }
        if (self.redList.count == 0) {
            [self showNoneImageAndLabels];
        }else {
            [self.possess setTitle:[NSString stringWithFormat:@"可使用(%@)", json[@"resultData"][@"unused"]] forState:UIControlStateNormal];
            [self.used setTitle:[NSString stringWithFormat:@"已使用/过期(%@)", json[@"resultData"][@"usedOrExpire"]] forState:UIControlStateNormal];
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
    dic[@"type"] = @(self.selectMark);
    RedPacketsModel *model = [self.redList lastObject];
    dic[@"lastId"] = model.pid;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyRedPacketsList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_footer endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [RedPacketsModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.redList addObjectsFromArray:temp];
            [self.tableView reloadData];
            
            [self.possess setTitle:[NSString stringWithFormat:@"可使用(%@)", json[@"resultData"][@"unused"]] forState:UIControlStateNormal];
            [self.used setTitle:[NSString stringWithFormat:@"已使用/过期(%@)", json[@"resultData"][@"usedOrExpire"]] forState:UIControlStateNormal];
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
