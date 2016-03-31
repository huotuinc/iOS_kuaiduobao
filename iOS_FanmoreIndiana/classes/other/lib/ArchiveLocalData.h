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
#import "AppWinningInfoModel.h"

/**
 *  数据存储工具
 */
@interface ArchiveLocalData : NSObject

@property (nonatomic, assign) BOOL bannerAttend;//从banner进入 pictureUrl是个数组
@property (nonatomic, assign) NSInteger arrayOrNot;

/*******************咻咻红包**********************/
//防止锁屏 中途退出咻咻界面 红包弹框错误   红包期号用单例存放
/**
 *  归档
 *
 *  @param _joinModel 要归档的商品数据
 */
+ (void)archiveRedPastArrayWithArray:(NSMutableArray *)_redPastArray;

/**
 *  解归档
 *
 *  @return
 */
+ (NSArray *)unarchiveRedPastArray;
/**
 *  清空归档
 */
+ (void) emptyTheRedPastArray;


/*******************加入清单**********************/
//由于商品模型不统一  所有两种归档方法 根据拿到的model类型调用不同的归档方法
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
