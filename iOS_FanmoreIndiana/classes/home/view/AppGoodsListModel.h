//
//  AppGoodsListModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>
//首页商品
@interface AppGoodsListModel : NSObject

@property (nonatomic, strong) NSNumber *areaAmount;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSNumber *remainAmount;
@property (nonatomic, strong) NSNumber *stepAmount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *toAmount;

@end
