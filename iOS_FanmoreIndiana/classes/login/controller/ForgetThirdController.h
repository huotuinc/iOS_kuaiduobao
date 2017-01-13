//
//  ForgetThirdController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FanmoreUserController.h"

@interface ForgetThirdController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passwrod;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (weak, nonatomic) IBOutlet UISwitch *hidePassword;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, strong) FanmoreUserController *fan;

@property (nonatomic, strong) NSString *userName;
- (IBAction)resetPassword:(id)sender;

/**
 *  1.忘记密码 2.重设密码 3.手机重设密码
 */
@property (nonatomic, assign) NSInteger type;

@end
