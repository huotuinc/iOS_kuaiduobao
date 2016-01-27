//
//  RegisterFirstController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/21.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RegisterFirstController.h"
#import "RegisterSecondController.h"
#import "UIButton+CountDown.h"
#import <SVProgressHUD.h>

@interface RegisterFirstController ()<UIAlertViewDelegate,UITextFieldDelegate>

@end

@implementation RegisterFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.getSecurtity.layer.cornerRadius = 5;
    self.next.layer.cornerRadius = 5;
    
    self.title = @"快速注册";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)getSecurtityCode:(id)sender {
    
    NSString *phoneNumber = self.phone.text;
    if ([phoneNumber isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
    }else if (![self checkTel:phoneNumber]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
    }else {
    
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"phone"] = phoneNumber;
        dic[@"type"] = @1;
        dic[@"codeType"] = @0;
    
            [UserLoginTool loginRequestGet:@"sendSMS" parame:dic success:^(id json) {
        
                if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==53014) {
            
                    [SVProgressHUD showErrorWithStatus:json[@"resultDescription"]];
                    return ;
                }else if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==54001) {
            
                    [SVProgressHUD showErrorWithStatus:@"该账号已被注册"];
                    return ;
                }else if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==55001){
                    
                    if ([json[@"resultData"][@"voiceAble"] intValue]) {
                        UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"验证码提示" message:@"短信通到不稳定，是否尝试语言通道" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                        [a show];
                    }
            
            
                }else if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1){
                    [_getSecurtity startWithTime:60 title:@"重新获取" countDownTitle:@"s" mainColor:[UIColor colorWithRed:0.255 green:0.522 blue:1.000 alpha:1.000] countColor: [UIColor colorWithRed:0.255 green:0.522 blue:1.000 alpha:1.000]];
                }
        
            } failure:^(NSError *error) {
        
        }];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        //网络请求获取验证码
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"phone"] = self.phone.text;
        params[@"type"] = @1;
        params[@"codeType"] = @1;

        [UserLoginTool loginRequestGet:@"sendSMS" parame:params success:^(NSDictionary * json) {
            
            
            
        } failure:^(NSError *error) {
            

        }];
    }
}

- (IBAction)goNext:(id)sender {
    
    if (!self.security.text.length) {//验证码不能为空
        
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空"];
        return;
    }else if (!self.phone.text.length) {//手机号不能为空
        
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
        return;
    }else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"phone"] = self.phone.text;
        dic[@"authcode"] = self.security.text;
        
        [UserLoginTool loginRequestPostWithFile:@"checkAuthCode" parame:dic success:^(id json) {
            
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] ==  53007) {
                
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", json[@"resultDescription"]]];
                return ;
            }
            
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                RegisterSecondController *next = [story instantiateViewControllerWithIdentifier:@"RegisterSecondController"];
                
                next.phone = self.phone.text;
                
                [self.navigationController pushViewController:next animated:YES];
            }
            
        } failure:^(NSError *error) {
            
        } withFileKey:nil];
    }
    
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.security) {
        if (range.location>= 4){
            return NO;
        }
    }
    return YES;
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
