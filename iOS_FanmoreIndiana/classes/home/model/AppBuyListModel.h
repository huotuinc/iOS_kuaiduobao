//
//  AppBuyListModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/16.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>
//某期参与记录
@interface AppBuyListModel : NSObject

@property (nonatomic, strong) NSNumber *attendAmount;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, strong) NSNumber *date;
@property (nonatomic, strong) NSNumber *remainAmount;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, strong) NSNumber *pid ;
@property (nonatomic, copy) NSString *userHeadUrl;

@end
