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
    
    self.title = @"忘记密码";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"返回登陆" style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    self.next.layer.cornerRadius = 5;
    
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
    }else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"password"] = [MD5Encryption md5by32:passwordNumber];
        dic[@"phone"] = self.userName;
        
        [UserLoginTool loginRequestPostWithFile:@"forgetPassword" parame:dic success:^(id json) {
            LWLog(@"%@",json);
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                
                [SVProgressHUD showSuccessWithStatus:@"密码重设成功"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else {
                
            }
            
        } failure:^(NSError *error) {
            LWLog(@"%@",error);
        } withFileKey:nil];
    }
    
}
@end
