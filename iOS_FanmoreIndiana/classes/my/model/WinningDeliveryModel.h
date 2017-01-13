//
//  WinningDeliveryModel.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/29.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WinningDeliveryModel : NSObject

@property (nonatomic, strong) NSNumber *awardingDate;
@property (nonatomic, strong) NSNumber *confirmAddressTime;
@property (nonatomic, assign) NSInteger deliveryStatus;
@property (nonatomic, strong) NSNumber *deliveryTime;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSNumber *issueId;
@property (nonatomic, strong) NSNumber *mobile;
@property (nonatomic, strong) NSString *receiver;
@property (nonatomic, strong) NSNumber *recieveGoodsTime;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *username;

@end
