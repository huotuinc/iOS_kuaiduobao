//
//  AppShareListModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/17.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppShareListModel : NSObject

@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, copy) NSString *shareOrderTitle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *characters;
@property (nonatomic, copy) NSString *issueNo;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSMutableArray *pictureUrls;

@end
