//
//  AppRedPactketsDistributeSourceModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/10.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NOTIFICATION_RED0_WAIT  @"NotificationRed0Wait"//活动开始倒计时为0时
#define NOTIFICATION_RED0_END  @"NotificationRed0End"//活动结束倒计时为0时

@interface AppRedPactketsDistributeSourceModel : NSObject

@property (nonatomic) int amount;
@property (nonatomic) int startTime;
@property (nonatomic) int endTime;


+ (instancetype)timeModelWithtime:(int)time;

- (void)countDownWait;
- (void)countDownEnd;

- (NSString *)currentTimeStringEnd;
- (NSAttributedString *)currentTimeStringWait;

- (void)defaultConfig;

@end
