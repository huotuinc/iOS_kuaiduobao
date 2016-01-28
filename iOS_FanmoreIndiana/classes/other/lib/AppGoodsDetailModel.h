//
//  AppGoodsDetailModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppGoodsDetailModel : NSObject

@property (nonatomic, copy) NSString *character;
@property (nonatomic, strong) NSNumber *issueId;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSNumber *remainAmount;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, strong) NSNumber *stepAmount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *toAmount;
@property (nonatomic, strong) NSMutableArray *numbers;


@end
