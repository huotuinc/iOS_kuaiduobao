//  充值页面
//  PayController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/16.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *paySelectBgView;
@property (weak, nonatomic) IBOutlet UIButton *pay20;
@property (weak, nonatomic) IBOutlet UIButton *pay50;
@property (weak, nonatomic) IBOutlet UIButton *pay100;
@property (weak, nonatomic) IBOutlet UIButton *pay200;
@property (weak, nonatomic) IBOutlet UIButton *pay500;
@property (weak, nonatomic) IBOutlet UITextField *payOther;
@property (weak, nonatomic) IBOutlet UIButton *verifyPay;
@property (weak, nonatomic) IBOutlet UILabel *activity;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityLayout;
- (IBAction)verifyPayAction:(id)sender;

@end
