//
//  AddAddressController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/18.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "AddAddressController.h"
#import <UIBarButtonItem+BlocksKit.h>
#import "UITableView+CJ.h"
@interface AddAddressController ()<UITableViewDelegate>

@end

@implementation AddAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"保存" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        [self addNewAddress];
        
    }];
    
    [self.tableView removeSpaces];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_temp == 0) {
        self.personName.text = _model.receiver;
        self.personIphone.text = _model.mobile;
        self.detailAddress.text = _model.details;
        self.defaultAddress.on = _model.defaultAddress;
    }
}




- (void)addNewAddress {
    if (_personName.text == nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
    }else if (_personIphone.text == nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
    }else if (_detailAddress.text == nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入详细地址"];
    }else {
        if ([self checkTel:_personIphone.text]) {
            
            if (_temp == 1) {
                //增加新地址
                [self postAddressToServer];
            }else if (_temp == 0) {
                //修改老地址
                [self updateAddressToServer];
            }
            
        }else {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        }
    }
}

- (void)postAddressToServer {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"receiver"] = self.personName.text;
    dic[@"mobile"] = self.personIphone.text;
    dic[@"details"] = self.detailAddress.text;
    dic[@"defaultAddress"] = @(self.defaultAddress.on);
    
    [UserLoginTool loginRequestPostWithFile:@"addMyAddress" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"地址增加成功"];

            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    } withFileKey:nil];
}


- (void)updateAddressToServer {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"receiver"] = self.personName.text;
    dic[@"mobile"] = self.personIphone.text;
    dic[@"details"] = self.detailAddress.text;
    dic[@"defaultAddress"] = @(self.defaultAddress.on);
    dic[@"addressId"] = self.model.addressId;
    
    [UserLoginTool loginRequestPostWithFile:@"updateAddress" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    } withFileKey:nil];
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

#pragma mark tableView selecet

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
