//
//  RedPacketsModel.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedPacketsModel : NSObject

@property (nonatomic, strong) NSNumber *endTime;
@property (nonatomic, strong) NSNumber *fullMoney;
@property (nonatomic, strong) NSNumber *minusMoney;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger redPacketType;

@end
