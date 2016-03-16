//
//  TabBarController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/19.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"

@interface TabBarController ()<UITabBarDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cannelLogin) name:CannelLoginFailure object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cannelLogin {
    self.selectedIndex = 0;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag == 3) {
        

//        HomeViewController *home = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
//        home.homeUrl = @"http://www.baidu.com";
//        home.buttomUrl = @"http://www.baidu.com";
//        
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:home];
////
//        [self presentViewController:nav animated:YES completion:nil];
        [UserLoginTool loginRequestGet:@"getMallLoginUrl" parame:nil success:^(id json) {
            LWLog(@"%@", json);
        } failure:^(NSError *error) {
            LWLog(@"%@", error);
        }];
       
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
