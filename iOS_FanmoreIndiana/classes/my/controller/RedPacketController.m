//
//  RedPacketController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RedPacketController.h"

@interface RedPacketController ()

@end

@implementation RedPacketController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.slider = [[UIView alloc] initWithFrame:CGRectMake(0, 33, KScreenWidth / 2, 2)];
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth / 8, 0, KScreenWidth / 4, 2)];
    redView.backgroundColor = [UIColor redColor];
    [self.slider addSubview:redView];
    self.slider.tag = 1001;
    [self.possess setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.selectBgView addSubview:self.slider];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.953 alpha:1.000];
    
    self.snatch.layer.cornerRadius = 5;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)hiddenNoneImageAndLabels {
    self.noneImage.hidden = YES;
    self.noneLabel.hidden = YES;
    self.snatch.hidden = YES;
}

- (void)showNoneImageAndLabels {
    self.noneImage.hidden = NO;
    self.noneLabel.hidden = NO;
    self.snatch.hidden = NO;
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

- (IBAction)possessAction:(id)sender {
    
    if (self.slider.tag == 1000) {
        [UIView animateWithDuration:0.15 animations:^{
            self.slider.frame = CGRectMake(0, _slider.frame.origin.y, KScreenWidth / 2, 2);
            self.slider.tag = 1001;
            [self.possess setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.used setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
        }];
    }
    
    
}
- (IBAction)snatchAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CannelLoginFailure object:nil];
    
}
@end
