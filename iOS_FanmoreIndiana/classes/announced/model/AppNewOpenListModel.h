//
//  AppNewOpenListModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/2.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>
//最新揭晓
@interface AppNewOpenListModel : NSObject

@property (nonatomic, strong) NSNumber *attendAmount;
@property (nonatomic, strong) NSNumber *issueId;
@property (nonatomic, strong) NSNumber *luckyNumber;
@property (nonatomic, copy) NSString *	nickName;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) int toAwardingTime;

/**
 *  便利构造器
 *
 *  @param title         标题
 *  @param countdownTime 倒计时
 *
 *  @return 实例对象
 */
+ (instancetype)timeModelWithtime:(int)time;/**
 *  计数减1(countdownTime - 1)
 */
- (void)countDown;

/**
 *  将当前的countdownTime信息转换成字符串
 */
- (NSString *)currentTimeString;
@end
