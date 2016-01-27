//
//  RegisterSecondController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/21.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RegisterSecondController.h"
#import <UIBarButtonItem+BlocksKit.h>
#import <SVProgressHUD.h>
#import "MD5Encryption.h"

@interface RegisterSecondController ()

@end

@implementation RegisterSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.registerButton.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (IBAction)registerUser:(id)sender {
    
    NSString *passwordNumber = self.password.text;
    if ([passwordNumber isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
    }else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"password"] = [MD5Encryption md5by32:passwordNumber];
        dic[@"phone"] = self.phone;
        
        [UserLoginTool loginRequestPostWithFile:@"reg" parame:dic success:^(id json) {
            LWLog(@"%@",json);
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSError *error) {
            LWLog(@"%@",error);
        } withFileKey:nil];
    }
    
}
@end
