//
//  ArchiveLocalData.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/16.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppGoodsListModel.h"
#import "AppGoodsDetailModel.h"
#import "CartModel.h"

@interface ArchiveLocalData : NSObject

@property (nonatomic, assign) BOOL bannerAttend;//从banner进入 pictureUrl是个数组
@property (nonatomic, assign) NSInteger arrayOrNot;

/**
 *  归档
 *
 *  @param _joinModel 要归档的商品数据
 */
+ (void)archiveLocalDataArrayWithGoodsModel:(AppGoodsListModel *)_joinModel;

/**
 *  归档
 *
 *  @param _joinModel 要归档的商品数据
 */
+ (void)archiveLocalDataArrayWithDetailModel:(AppGoodsDetailModel *)_detailModel;
/**
 *  解归档
 *
 *  @return <#return value description#>
 */
+ (NSArray *)unarchiveLocalDataArray;
/**
 *  清空归档
 */
+ (void) emptyTheLocalDataArray;

@end
