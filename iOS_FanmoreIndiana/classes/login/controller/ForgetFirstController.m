//
//  ForgetFirstController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ForgetFirstController.h"
#import "ForgetSecondController.h"


@interface ForgetFirstController ()

@end

@implementation ForgetFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.title = @"忘记密码";
    
    self.next.layer.cornerRadius = 5;
    
//    self.userName.text = self
    [self.userName becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.userName resignFirstResponder];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doNext:(UIButton *)sender {
    
    if (self.userName.text.length != 0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"userName"] = self.userName.text;
        
        [UserLoginTool loginRequestGet:@"checkPhone" parame:dic success:^(id json) {
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ForgetSecondController *second = [story instantiateViewControllerWithIdentifier:@"ForgetSecondController"];
                second.userName = self.userName.text;
                [self.navigationController pushViewController:second animated:YES];
            }else {
                [SVProgressHUD showErrorWithStatus:json[@"resultDescription"]];
                return ;
            }
        } failure:^(NSError *error) {
            
        }];
        
    }else {
        [SVProgressHUD showErrorWithStatus:@"请输入帐号"];
    }
    
    
}
@end
