//
//  ForgetThirdController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ForgetThirdController.h"
#import <UIBarButtonItem+BlocksKit.h>
#import "MD5Encryption.h"

@interface ForgetThirdController ()

@end

@implementation ForgetThirdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.type == 1) {
        self.title = @"忘记密码";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"返回登陆" style:UIBarButtonItemStylePlain handler:^(id sender) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }else if (self.type == 2) {
        self.title = @"重置密码";
    }

    
    
    self.bgView.layer.borderColor = [UIColor colorWithWhite:0.875 alpha:1.000].CGColor;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.cornerRadius = 5;
    
    self.passwrod.secureTextEntry = !self.hidePassword.on;
    
    self.next.layer.cornerRadius = 5;
    
    [self.hidePassword addTarget:self action:@selector(swichChanged:) forControlEvents:UIControlEventValueChanged];
    
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

- (IBAction)resetPassword:(id)sender {
    
    
    
    NSString *passwordNumber = self.passwrod.text;
    if ([passwordNumber isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
    }else if (passwordNumber.length < 6 || passwordNumber.length > 16) {
        [SVProgressHUD showErrorWithStatus:@"密码长度6-16位"];
    }
    else {
        
        if (self.type == 1 || self.type == 3) {
            
            /**
             *  忘记密码
             */
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"password"] = [MD5Encryption md5by32:passwordNumber];
            dic[@"phone"] = self.userName;
            
            [UserLoginTool loginRequestPostWithFile:@"forgetPassword" parame:dic success:^(id json) {
                LWLog(@"%@",json);
                if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                    
                    [SVProgressHUD showSuccessWithStatus:@"密码重设成功"];
                    if (self.type == 1) {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else {
                        [self updateUserInfo];
                    }
                }else {
                    
                }
                
            } failure:^(NSError *error) {
                LWLog(@"%@",error);
            } withFileKey:nil];
        }else if (self.type == 2) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"password"] = [MD5Encryption md5by32:passwordNumber];
            
            [UserLoginTool loginRequestGet:@"setPassword" parame:dic success:^(id json) {
                LWLog(@"%@",json);
                if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                    [SVProgressHUD showSuccessWithStatus:@"密码设置成功"];
                    [self updateUserInfo];
                }
            } failure:^(NSError *error) {
                LWLog(@"%@",error);
            }];
        }
        
    }
    
}


- (void)swichChanged:(UISwitch *) sender {
    
    self.passwrod.secureTextEntry = !sender.on;
}


#pragma mark 支付成功刷新用户数据
- (void)updateUserInfo {
    
    [UserLoginTool loginRequestPostWithFile:@"updateUserInformation" parame:nil success:^(id json) {
        LWLog(@"%@", json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            [self loginSuccessWith:json[@"resultData"]];
        }else {
            [SVProgressHUD showErrorWithStatus:json[@"resultDescription"]];
        }
    } failure:^(NSError *error) {
        
    } withFileKey:nil];
    
    
    [SVProgressHUD showSuccessWithStatus:@"重设密码成功"]; 
    
}



//刷新用户数据
- (void)loginSuccessWith:(NSDictionary *) dic {
    
    UserModel *user = [UserModel mj_objectWithKeyValues:dic[@"user"]];
//    NSLog(@"userModel: %@",user);
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
    [NSKeyedArchiver archiveRootObject:user toFile:fileName];
    [[NSUserDefaults standardUserDefaults] setObject:Success forKey:LoginStatus];
    //保存新的token
    [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
    
    AdressModel *address = [AdressModel mj_objectWithKeyValues:dic[@"user"][@"appMyAddressListModel"]];
    NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
    [NSKeyedArchiver archiveRootObject:address toFile:fileNameAdd];
    
    if (self.type == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.type == 3) {
        [self.navigationController popToViewController:self.fan animated:YES];
    }
}

@end
