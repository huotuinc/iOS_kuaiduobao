//
//  AppBalanceModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AppBalanceModel : NSObject

@property (nonatomic, strong) NSNumber * money;
@property (nonatomic, strong) NSNumber * redPacketsEndTime;
@property (nonatomic, strong) NSNumber * redPacketsFullMoney;
@property (nonatomic, strong) NSNumber * redPacketsId;
@property (nonatomic, strong) NSNumber * 	redPacketsMinusMoney;
@property (nonatomic, copy) NSString * redPacketsRemark;
@property (nonatomic, strong) NSNumber * 	redPacketsStartTime;
@property (nonatomic, copy) NSString * redPacketsTitle;
@property (nonatomic, strong) NSNumber * 	totalMoney;
@property (nonatomic, strong) NSNumber *redPacketsNumber;

@end
