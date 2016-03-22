//
//  AppGoodsDetailModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppGoodsDetailModel : NSObject


@property (nonatomic, strong) NSNumber *awardingDate;
@property (nonatomic, strong) NSNumber *awardingUserBuyCount;
@property (nonatomic, strong) NSNumber *awardingUserId;
@property (nonatomic, copy) NSString *awardingUserName;
@property (nonatomic, copy) NSString *character;
@property (nonatomic, strong) NSNumber *issueId;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, strong) NSNumber *luckyNumber;
@property (nonatomic, strong) NSMutableArray *numbers;
@property (nonatomic, strong) NSMutableArray *pictureUrl;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSNumber *remainAmount;
@property (nonatomic) int remainSecond;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, strong) NSNumber *stepAmount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *toAmount;
@property (nonatomic, strong) NSNumber *firstBuyTime;
@property (nonatomic, copy) NSString *awardingUserCityName;
@property (nonatomic, strong) NSNumber *awardingUserIp;
@property (nonatomic, copy) NSString *awardingUserHead;
@property (nonatomic, strong) NSNumber *areaAmount;
@property (nonatomic, strong) NSNumber *defaultAmount;
@property (nonatomic, strong) NSNumber *pricePercentAmount;

+ (instancetype)timeModelWithtime:(int)time;

- (void)countDown;

- (NSString*)currentTimeString;


@end
