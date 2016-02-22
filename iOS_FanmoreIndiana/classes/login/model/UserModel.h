//
//  UserModel.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/22.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) BOOL mobileBanded;
@property (nonatomic, strong) NSNumber *money;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *token;
//用户登陆模式 0手机（帐号） 1,2 微信或者QQ
@property (nonatomic, strong) NSNumber *userFormType;
@property (nonatomic, strong) NSString *userHead;
@property (nonatomic, strong) NSString *username;

@end
