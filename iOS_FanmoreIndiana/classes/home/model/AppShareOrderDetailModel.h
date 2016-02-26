//
//  AppShareOrderDetailModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppShareOrderDetailModel : NSObject

@property (nonatomic, strong) NSNumber *attendAmount;
@property (nonatomic, copy) NSString *	characters;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *issueNo;
@property (nonatomic, strong) NSNumber *lotteryTime;
@property (nonatomic, strong) NSNumber *luckNumber;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, strong) NSMutableArray *pictureUrls;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, copy) NSString *shareOrderTitle;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, copy) NSString *title;


@end
