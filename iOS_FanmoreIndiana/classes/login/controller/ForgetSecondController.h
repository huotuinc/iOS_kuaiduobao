//
//  ForgetSecondController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FanmoreUserController.h"

@interface ForgetSecondController : UIViewController

@property (nonatomic, strong) NSString *userName;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *security;
@property (weak, nonatomic) IBOutlet UILabel *countCode;
@property (weak, nonatomic) IBOutlet UIButton *next;

@property (nonatomic, strong) FanmoreUserController *fan;

/**
 *  1.忘记密码 2.手机验证重置密码
 */
@property (nonatomic, assign) NSInteger type;

- (IBAction)doNext:(id)sender;

@end
