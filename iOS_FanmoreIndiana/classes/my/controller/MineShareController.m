//
//  MineShareController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/22.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "MineShareController.h"
#import "DetailShareTableViewCell.h"
#import "AppShareListModel.h"
#import "DetailShareNextViewController.h"

@interface MineShareController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *shareList;

@end

@implementation MineShareController

static NSString *shareCIdentifier = @"shareCIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shareList = [NSMutableArray array];
    
    [self hiddenNoneImageAndLabels];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailShareTableViewCell" bundle:nil] forCellReuseIdentifier:shareCIdentifier];
    [self setupRefresh];
    [self.tableView removeSpaces];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}                                                                                                                                                                                                                                            

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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

- (IBAction)snatchAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CannelLoginFailure object:nil];
    
}

#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shareList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ADAPT_HEIGHT(500);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shareCIdentifier forIndexPath:indexPath];
    AppShareListModel *model = _shareList[indexPath.row];
    [cell.imageVHead sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl]];
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppShareListModel *model = _shareList[indexPath.row];
    DetailShareNextViewController *next =[[DetailShareNextViewController alloc] init];
    next.shareId = model.pid;
    [self.navigationController pushViewController:next animated:YES];
}


#pragma mark 网络请求

- (void)getNewList {
    
    [self.shareList removeAllObjects];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[@"type"] = @(self.selectMark);
    dic[@"lastId"] = @0;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyShareOrderList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_header endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [AppShareListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.shareList addObjectsFromArray:temp];
            [self.tableView reloadData];
        }
        if (self.shareList.count == 0) {
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
//    dic[@"type"] = @(self.selectMark);
    AppShareListModel *model = [self.shareList lastObject];
    dic[@"lastId"] = model.pid;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyShareOrderList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_footer endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [AppShareListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.shareList addObjectsFromArray:temp];
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
    NSString * str = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[time doubleValue] / 1000]];
    return str;
}

@end
