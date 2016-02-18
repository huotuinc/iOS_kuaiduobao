//
//  WinningController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/31.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "WinningController.h"
#import "WinningCell.h"
@interface WinningController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WinningController

static NSString *winningIdentify = @"winningIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.snatch.layer.cornerRadius = 5;
    self.tabBarController.tabBar.hidden = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    [self.tableView registerNib:[UINib nibWithNibName:@"WinningCell" bundle:nil] forCellReuseIdentifier:winningIdentify];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -tableView 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 207;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WinningCell *cell = [tableView dequeueReusableCellWithIdentifier:winningIdentify forIndexPath:indexPath];
    return  cell;
}


- (void)hiddenNoneImageAndLabels {
    self.winImage.hidden = YES;
    self.showLabel.hidden = YES;
    self.snatch.hidden = YES;
}

- (void)showNoneImageAndLabels {
    self.winImage.hidden = NO;
    self.showLabel.hidden = NO;
    self.snatch.hidden = NO;
}

- (IBAction)goHomeController:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CannelLoginFailure object:nil];
    
}
@end
