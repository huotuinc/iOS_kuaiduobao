//
//  AppPastListModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/16.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>
//往期揭晓
@interface AppPastListModel : NSObject

@property (nonatomic, strong) NSNumber *attendAmount;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, strong) NSNumber *date;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, strong) NSNumber *issueId;
@property (nonatomic, strong) NSNumber *luckyNumber;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *userHeadUrl;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *userId;

@end
