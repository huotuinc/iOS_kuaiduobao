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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.phone becomeFirstResponder];
    
    self.getCaptcha.clipsToBounds = YES;
    self.getCaptcha.layer.cornerRadius = 5;
    [self.getCaptcha  bk_whenTapped:^{
        [self getCaptchaAction];
    }];
    
    self.bindPhone.layer.cornerRadius = 5;
    [self.bindPhone bk_whenTapped:^{
        [self verifySMSIsTure];
    }];
}

- (void)getCaptchaAction {
    NSString *phoneNumber = self.phone.text;
    if ([phoneNumber isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
    }else if (![self checkTel:phoneNumber]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
    }else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"phone"] = self.phone.text;
        dic[@"type"] = @3;
        [UserLoginTool loginRequestGet:@"checkPhone" parame:dic success:^(id json) {
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                
                [self sendSMSConnect];
                
            }else {
                [SVProgressHUD showErrorWithStatus:json[@"resultDescription"]];
            }
        } failure:^(NSError *error) {
            LWLog(@"%@", error);
        }];
    }
}


- (void)sendSMSConnect {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phone"] = self.phone.text;
    dic[@"type"] = @3;
    dic[@"codeType"] = @0;
    [UserLoginTool loginRequestGet:@"sendSMS" parame:dic success:^(id json) {
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            [SVProgressHUD showSuccessWithStatus:@"短信已发送请查收"];
            [self settime];
            
            [self.captcha becomeFirstResponder];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
    }];
    
    
}


- (void)verifySMSIsTure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phone"] = self.phone.text;
    dic[@"authcode"] = self.captcha.text;
    dic[@"type"] = @3;
    [UserLoginTool loginRequestPostWithFile:@"checkAuthCode" parame:dic success:^(id json) {
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            [self changePhoneNumber];
        }else {
            [SVProgressHUD showErrorWithStatus:json[@"resultDescription"]];
        }
    } failure:^(NSError *error) {
        
    } withFileKey:nil];
}

- (void)changePhoneNumber {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phone"] = self.phone.text;
    
    [UserLoginTool loginRequestGet:@"bindMobile" parame:dic success:^(id json) {
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
            
            [self updateUserInfo];
        }else {
            [SVProgressHUD showErrorWithStatus:json[@"resultDescription"]];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
    }];
    
    
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
                [self.getCaptcha setText:@"验证码"];
                //                [captchaBtn setTitle:@"" forState:UIControlStateNormal];
                //                [captchaBtn setBackgroundImage:[UIImage imageNamed:@"resent_icon"] forState:UIControlStateNormal];
                self.getCaptcha.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [self.getCaptcha setText:[NSString stringWithFormat:@"%@s",strTime]];
                self.getCaptcha.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


#pragma mark 支付成功刷新用户数据
- (void)updateUserInfo {
    
    [UserLoginTool loginRequestPostWithFile:@"updateUserInformation" parame:nil success:^(id json) {
        LWLog(@"%@", json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            [self loginSuccessWith:json[@"resultData"]];
        }else {
//            [SVProgressHUD showErrorWithStatus:json[@"resultDescription"]];
        }
    } failure:^(NSError *error) {
        
    } withFileKey:nil];
    
}



//刷新用户数据
- (void)loginSuccessWith:(NSDictionary *) dic {
    
    UserModel *user = [UserModel mj_objectWithKeyValues:dic[@"user"]];
    NSLog(@"userModel: %@",user);
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
    [NSKeyedArchiver archiveRootObject:user toFile:fileName];
    [[NSUserDefaults standardUserDefaults] setObject:Success forKey:LoginStatus];
    //保存新的token
    [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
    //购物车结算登陆时 需要提交数据
    
    AdressModel *address = [AdressModel mj_objectWithKeyValues:dic[@"user"][@"appMyAddressListModel"]];
    NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
    [NSKeyedArchiver archiveRootObject:address toFile:fileNameAdd];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
