//
//  ArchiveLocalData.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/16.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppGoodsListModel.h"
#import "CartModel.h"

@interface ArchiveLocalData : NSObject


/**
 *  归档
 *
 *  @param _joinModel 要归档的商品数据
 */
+ (void)archiveLocalDataArrayWithModel:(AppGoodsListModel *)_joinModel;
/**
 *  解归档
 *
 *  @return <#return value description#>
 */
+ (NSArray *)unarchiveLocalDataArray;

@end
