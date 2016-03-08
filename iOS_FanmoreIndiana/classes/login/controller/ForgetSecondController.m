//
//  ForgetSecondController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ForgetSecondController.h"
#import <UIBarButtonItem+BlocksKit.h>
#import "ForgetThirdController.h"

@interface ForgetSecondController ()

@end

@implementation ForgetSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"返回登陆" style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    self.countCode.layer.cornerRadius = 5;
    self.countCode.layer.masksToBounds = YES;
    
    self.phone.text = self.userName;
    
    self.next.layer.cornerRadius = 5;
//    self.countCode.userInteractionEnabled = YES;≥
    [self.countCode bk_whenTapped:^{
        [self getSecurtityCode];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getSecurtityCode {
    
    NSString *phoneNumber = self.phone.text;
    if ([phoneNumber isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
    }else if (![self checkTel:phoneNumber]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
    }else {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"phone"] = phoneNumber;
        dic[@"type"] = @2;
        dic[@"codeType"] = @0;
        dic[@"userName"] = self.userName;
        
        [UserLoginTool loginRequestGet:@"sendSMS" parame:dic success:^(id json) {
            LWLog(@"%@",json);
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
                [self settime];
            }else {
                [SVProgressHUD showErrorWithStatus:json[@"resultDescription"]];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
}


- (IBAction)doNext:(id)sender {
    
    
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
        dic[@"type"] = @2;
        [UserLoginTool loginRequestPostWithFile:@"checkAuthCode" parame:dic success:^(id json) {
            
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] ==  53007) {
                
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", json[@"resultDescription"]]];
                return ;
            }
            
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ForgetThirdController *next = [story instantiateViewControllerWithIdentifier:@"ForgetThirdController"];
                next.userName = self.userName;
                [self.navigationController pushViewController:next animated:YES];
            }
            
        } failure:^(NSError *error) {
            
        } withFileKey:nil];
    }
    
    
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


- (void)settime{
    
    /*************倒计时************/
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.countCode setText:@"验证码"];
                //                [captchaBtn setTitle:@"" forState:UIControlStateNormal];
                //                [captchaBtn setBackgroundImage:[UIImage imageNamed:@"resent_icon"] forState:UIControlStateNormal];
                self.countCode.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [self.countCode setText:[NSString stringWithFormat:@"%@s",strTime]];
                self.countCode.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



@end
