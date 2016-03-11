//
//  ChangePasswordFromOldController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/3/11.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ChangePasswordFromOldController.h"
#import "MD5Encryption.h"

@interface ChangePasswordFromOldController ()

@end

@implementation ChangePasswordFromOldController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.oldBgView.layer.borderColor = [UIColor colorWithWhite:0.875 alpha:1.000].CGColor;
    self.oldBgView.layer.borderWidth = 1;
    self.oldBgView.layer.cornerRadius = 5;
    
    self.oldPassword.secureTextEntry = !self.oldSwich.on;
    
    [self.oldSwich addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.BgView.layer.borderColor = [UIColor colorWithWhite:0.875 alpha:1.000].CGColor;
    self.BgView.layer.borderWidth = 1;
    self.BgView.layer.cornerRadius = 5;
    
    self.Password.secureTextEntry = !self.Swich.on;
    
    [self.Swich addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.resetPasswordButton.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)switchChanged:(UISwitch *) sender {
    if (sender.tag == 101) {
        self.oldPassword.secureTextEntry = !sender.on;
    }else if (sender.tag == 102) {
        self.Password.secureTextEntry = !sender.on;
    }
}

- (void)resetPassword {
    if (self.oldPassword.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入旧密码"];
    }else if (self.Password.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
    }else if ([self.oldPassword.text isEqualToString:self.Password.text]) {
        [SVProgressHUD showErrorWithStatus:@"新密码和旧密码不能一样"];
    }else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"password"] = [MD5Encryption md5by32:self.oldPassword.text];
        dic[@"newPassword"] = [MD5Encryption md5by32:self.Password.text];
        
        [UserLoginTool loginRequestPostWithFile:@"modifyPassword" parame:dic success:^(id json) {
            LWLog(@"%@", json);
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                [self updateUserInfo];
                [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
            }else if ([json[@"resultCode"] intValue] != 500) {
                 [SVProgressHUD showErrorWithStatus:json[@"resultDescription"]];
            }
        } failure:^(NSError *error) {
            LWLog(@"%@", error);
        } withFileKey:nil];
    }
}

#pragma mark 支付成功刷新用户数据
- (void)updateUserInfo {
    
    [UserLoginTool loginRequestPostWithFile:@"updateUserInformation" parame:nil success:^(id json) {
        LWLog(@"%@", json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            [self loginSuccessWith:json[@"resultData"]];
        }else {
           
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
    
    AdressModel *address = [AdressModel mj_objectWithKeyValues:dic[@"user"][@"appMyAddressListModel"]];
    NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
    [NSKeyedArchiver archiveRootObject:address toFile:fileNameAdd];
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)resetPasswordAction:(id)sender {
    
    [self resetPassword];
}




@end
