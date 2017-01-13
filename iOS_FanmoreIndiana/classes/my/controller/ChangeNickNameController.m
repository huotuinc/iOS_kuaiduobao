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
//    self.textField.autocorrectionType=UITextAutocorrectionTypeNo;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (toBeString.length > 11 ) {
        return NO;
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 11) {
        textField.text = [textField.text substringToIndex:11];
    }
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


//- (void)textFieldDidChange:(UITextField *)textField {
//    NSString *toBeString = textField.text;
//    NSArray *currentar = [UITextInputMode activeInputModes];
//    UITextInputMode *current = [currentar firstObject];
//    
//    //下面的方法是iOS7被废弃的，注释
//    //    NSString *lang = [[UITextInputMode currentInputMode] PRimaryLanguage]; // 键盘输入模式
//    
//    if ([current.primaryLanguage isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
//        UITextRange *selectedRange = [textField markedTextRange];
//        //获取高亮部分
//        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
//        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//        if (!position) {
//            if (toBeString.length > 14) {
//                textField.text = [toBeString substringToIndex:14];
//            }
//        }
//        // 有高亮选择的字符串，则暂不对文字进行统计和限制
//        else{
//            if (toBeString.length > 14) {
//                textField.text = [toBeString substringToIndex:14];
//            }
//        }
//    }
//    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
//    else{
//        if (toBeString.length > 14) {
//            textField.text = [toBeString substringToIndex:14];
//        }
//    }
//    NSLog(@"%@",textField.text);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
