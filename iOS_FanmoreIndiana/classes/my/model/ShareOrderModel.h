//
//  ShareOrderModel.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareOrderModel : NSObject

@property (nonatomic, strong) NSString *characters;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *issueNo;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *pictureUrl;
@property (nonatomic, strong) NSArray *pictureUrls;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSString *shareOrderTitle;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, strong) NSString *title;

@end
