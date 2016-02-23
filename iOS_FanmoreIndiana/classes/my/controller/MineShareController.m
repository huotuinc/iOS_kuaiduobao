//
//  MineShareController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/22.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "MineShareController.h"
#import "DetailShareTableViewCell.h"

@interface MineShareController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MineShareController

static NSString *shareCIdentifier = @"shareCIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailShareTableViewCell" bundle:nil] forCellReuseIdentifier:shareCIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}                                                                                                                                                                                                                                            

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ADAPT_HEIGHT(500);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shareCIdentifier forIndexPath:indexPath];
    return cell;
}

@end
