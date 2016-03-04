//
//  RedViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/2.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RedViewController.h"

@interface RedViewController ()

@property (nonatomic, strong) UIImageView * backImageV;

@end

@implementation RedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBackImage];
}

- (void)createBackImage{
    _backImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    _backImageV.image = [UIImage imageNamed:]
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

@end
