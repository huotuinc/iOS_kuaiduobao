//
//  WinningModel.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/25.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WinningModel : NSObject

@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSNumber *awardingDate;
@property (nonatomic, strong) NSString *defaultPictureUrl;
@property (nonatomic, strong) NSNumber *issueId;
@property (nonatomic, strong) NSNumber *luckyNumber;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *toAmount;
@property (nonatomic, assign) NSInteger deliveryStatus;

@end
