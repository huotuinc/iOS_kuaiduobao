//
//  TabBarController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/19.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "LoginController.h"

@interface TabBarController ()<UITabBarDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cannelLogin) name:CannelLoginFailure object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToList) name:GOTOLISTIMMEDIATELY object:nil];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cannelLogin {
    self.selectedIndex = 0;
}

- (void)goToList {
    self.selectedIndex = 2;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag == 3) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:GotoMallSecond object:nil];
        
    }
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
