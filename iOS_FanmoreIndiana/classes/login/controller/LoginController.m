//
//  LoginController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/19.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "LoginController.h"
#import <UIBarButtonItem+BlocksKit.h>
#import <ShareSDK/ShareSDK.h>
#import <SVProgressHUD.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import "MD5Encryption.h"
#import <MJExtension.h>
#import "TabBarController.h"
#import "AppDelegate.h"

@interface LoginController ()<UITextFieldDelegate>

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.title = @"登录";
    
    self.userName.delegate = self;
    self.password.delegate = self;

    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"取消" style:UIBarButtonItemStylePlain handler:^(id sender) {
//        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        TabBarController *login = app.tabbar;
//        login.tabBarController.selectedIndex = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:CannelLoginFailure object:nil];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    self.login.layer.cornerRadius = 5;
    
    self.phoneRegister.layer.borderWidth = 1;
    self.phoneRegister.layer.borderColor = [UIColor redColor].CGColor;
    self.phoneRegister.layer.cornerRadius = 5;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.userName resignFirstResponder];
    
    [self.password resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userNameAndPasswordLogin:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"username"] = self.userName.text;
    
    dic[@"password"] = [MD5Encryption md5by32:self.password.text];
    
    [UserLoginTool loginRequestGet:@"login" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            [self loginSuccessWith:json[@"resultData"]];
        }
        
    } failure:^(NSError *error) {
        
        LWLog(@"%@",error);
        
    }];
    
}

- (IBAction)loginWithWeixin:(id)sender {
    
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            LWLog(@"%@",user);
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"username"] = user.nickname;
            dic[@"unionId"] = user.uid;
            dic[@"head"] = user.icon;
            dic[@"type"] = @"1";
            
            [UserLoginTool loginRequestGet:@"authLogin" parame:dic success:^(id json) {
                LWLog(@"%@",json);
                if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                    [self loginSuccessWith:json[@"resultData"]];
                }
            } failure:^(NSError *error) {
                LWLog(@"%@",error);
            }];
            
        }else {
            LWLog(@"%@",error);
        }
    }];
    
    
}

- (IBAction)loginWithQQ:(id)sender {
    
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            LWLog(@"%@",user);
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"username"] = user.nickname;
            dic[@"unionId"] = user.uid;
            dic[@"head"] = user.icon;
            dic[@"type"] = @"2";
            
            [UserLoginTool loginRequestGet:@"authLogin" parame:dic success:^(id json) {
                LWLog(@"%@",json);
                if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                    [self loginSuccessWith:json[@"resultData"]];
                }
            } failure:^(NSError *error) {
                LWLog(@"%@",error);
            }];
        }else {

        }
    }];
    
}

- (void)loginSuccessWith:(NSDictionary *) dic {
    
    UserModel *user = [UserModel mj_objectWithKeyValues:dic[@"user"]];
    NSLog(@"userModel: %@",user);
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
    [NSKeyedArchiver archiveRootObject:user toFile:fileName];
    [[NSUserDefaults standardUserDefaults] setObject:Success forKey:LoginStatus];
    //保存新的token
    [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
    [self dismissViewControllerAnimated:YES completion:nil];
    /**
     *  //////
     */
    AdressModel *address = [AdressModel mj_objectWithKeyValues:dic[@"user"][@"addressModel"]];
    NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
    [NSKeyedArchiver archiveRootObject:address toFile:fileNameAdd];
}



@end
