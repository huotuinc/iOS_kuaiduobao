//
//  ChangePhoneController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/19.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ChangePhoneController.h"

@interface ChangePhoneController ()

@end

@implementation ChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改手机号码";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCaptchaAction {
    NSString *phoneNumber = self.phone.text;
    if ([phoneNumber isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
    }else if (![self checkTel:phoneNumber]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
    }else {
        
    }
}


- (void)changePhoneNumber {

}
    
/**
 *  验证手机号的正则表达式
 */
-(BOOL) checkTel:(NSString *) phoneNumber{
    NSString *regex = @"^(1)\\d{10}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
}

@end
