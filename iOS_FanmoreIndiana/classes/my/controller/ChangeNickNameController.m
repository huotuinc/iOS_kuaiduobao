//
//  ChangeNickNameController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/19.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ChangeNickNameController.h"
#import <UIBarButtonItem+BlocksKit.h>

@interface ChangeNickNameController ()<UITextFieldDelegate>

@end

@implementation ChangeNickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
    UserModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    self.title = @"修改昵称";
    
    self.textField.text = user.realName;
    [self.textField becomeFirstResponder];
    self.textField.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"保存" style:UIBarButtonItemStylePlain handler:^(id sender) {
        if (self.textField.text != user.realName) {
            [self changeUserNickName];
        }
    }];
}

- (void)changeUserNickName {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"profileType"] = @1;
    dic[@"profileData"] = self.textField.text;
    
    
    [SVProgressHUD showWithStatus:@"上传中"];
    [UserLoginTool loginRequestGet:@"updateProfile" parame:dic success:^(id json) {
        [SVProgressHUD dismiss];
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            [self loginSuccessWith:json[@"resultData"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        LWLog(@"%@",error);
    }];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length > 11) {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginSuccessWith:(NSDictionary *) dic {
    
    UserModel *user = [UserModel mj_objectWithKeyValues:dic[@"user"]];
//    NSLog(@"userModel: %@",user);
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
    [NSKeyedArchiver archiveRootObject:user toFile:fileName];
    //保存新的token
    [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
    [self.navigationController popViewControllerAnimated:YES];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
