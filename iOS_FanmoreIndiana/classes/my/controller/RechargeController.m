//
//  RechargeController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//
#import "RechargeCell.h"
#import "RechargeController.h"

@interface RechargeController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RechargeController

static NSString *rechargeIdentify = @"rechargeIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
//    [table registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:rechargeIdentify];
    [self.view addSubview:table];
    self.tableView = table;
    [self.tableView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:rechargeIdentify];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableVIew 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:rechargeIdentify forIndexPath:indexPath];
    
    return cell;
}

@end
