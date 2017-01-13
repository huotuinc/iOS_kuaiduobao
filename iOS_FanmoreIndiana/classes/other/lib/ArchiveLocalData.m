//
//  ArchiveLocalData.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/16.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ArchiveLocalData.h"

@implementation ArchiveLocalData

+ (void)archiveLocalDataArrayWithGoodsModel:(AppGoodsListModel *)_joinModel {
    NSMutableArray *localArray = [NSMutableArray array];
    BOOL isExist = NO;
    if ([self unarchiveLocalDataArray] == nil) {
        CartModel *cModel = [[CartModel alloc] init];
        cModel.areaAmount = _joinModel.areaAmount;
        cModel.attendAmount = @0;
        cModel.userBuyAmount = _joinModel.defaultAmount;
        cModel.isSelect = _joinModel.isSelect;
        cModel.pictureUrl = _joinModel.pictureUrl;
        cModel.remainAmount = _joinModel.remainAmount;
        cModel.sid = @0;
        cModel.stepAmount = _joinModel.stepAmount;
        cModel.title = _joinModel.title;
        cModel.toAmount = _joinModel.toAmount;
        cModel.issueId = _joinModel.issueId;
        cModel.pricePercentAmount = _joinModel.pricePercentAmount;
        cModel.userBuyAmount = _joinModel.defaultAmount;
        cModel.isSelect = YES;

        [localArray addObject:cModel];

    }
    //已进行
    else{
        localArray =[NSMutableArray arrayWithArray:[self unarchiveLocalDataArray]];
        //查看本地是否已有这期商品
        for (int i =0; i<localArray.count; i++) {
            CartModel *cModel = localArray[i];
            //有
            if ([cModel.issueId isEqualToNumber:_joinModel.issueId ]) {
                
                CGFloat prcie;
                prcie = [_joinModel.defaultAmount floatValue] + [cModel.userBuyAmount floatValue];
                if (prcie > [cModel.toAmount floatValue]) {
                    cModel.userBuyAmount = cModel.toAmount;
                }else {
                    cModel.userBuyAmount = [NSNumber numberWithFloat:prcie];
                }
                isExist = YES;
            }
        }
        if (!isExist) {
            CartModel *cModel = [[CartModel alloc] init];
            cModel.areaAmount = _joinModel.areaAmount;
            cModel.attendAmount = @0;
            cModel.userBuyAmount = _joinModel.defaultAmount;
            cModel.isSelect = _joinModel.isSelect;
            cModel.pictureUrl = _joinModel.pictureUrl;
            cModel.remainAmount = _joinModel.remainAmount;
            cModel.sid = @0;
            cModel.stepAmount = _joinModel.stepAmount;
            cModel.title = _joinModel.title;
            cModel.toAmount = _joinModel.toAmount;
            cModel.issueId = _joinModel.issueId;
            cModel.pricePercentAmount = _joinModel.pricePercentAmount;
            cModel.userBuyAmount = _joinModel.defaultAmount;
            cModel.isSelect = YES;

//            NSInteger restAmount;
//            restAmount =[_joinModel.toAmount integerValue]-[_joinModel.buyAmount integerValue] - [_joinModel.userBuyAmount integerValue];
//            cModel.remainAmount = [NSNumber numberWithInteger:restAmount];
            [localArray addObject:cModel];
//            isExist = NO;
        }
    }
    NSMutableData *data = [[NSMutableData alloc] init];
    //创建归档辅助类
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //编码
    [archiver encodeObject:localArray forKey:LOCALCART];
    //结束编码
    [archiver finishEncoding];
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filename = [[array objectAtIndex:0] stringByAppendingPathComponent:LOCALCART];
    //写入
    [data writeToFile:filename atomically:YES];

}

+ (void)archiveLocalDataArrayWithDetailModel:(AppGoodsDetailModel *)_detailModel {
    NSMutableArray *localArray = [NSMutableArray array];
    BOOL isExist = NO;
    if ([self unarchiveLocalDataArray] == nil) {
        CartModel *cModel = [[CartModel alloc] init];
        cModel.areaAmount = _detailModel.areaAmount;
        cModel.attendAmount = @0;
        cModel.userBuyAmount = _detailModel.defaultAmount;
        cModel.isSelect = YES;
        cModel.pictureUrl = _detailModel.pictureUrl[0];
        cModel.remainAmount = _detailModel.remainAmount;
        cModel.sid = @0;
        cModel.stepAmount = _detailModel.stepAmount;
        cModel.title = _detailModel.title;
        cModel.toAmount = _detailModel.toAmount;
        cModel.issueId = _detailModel.issueId;
        cModel.pricePercentAmount = _detailModel.pricePercentAmount;
        cModel.userBuyAmount = _detailModel.defaultAmount;
        cModel.isSelect = YES;
        
        [localArray addObject:cModel];
        
    }
    //已进行
    else{
        localArray =[NSMutableArray arrayWithArray:[self unarchiveLocalDataArray]];
        //查看本地是否已有这期商品
        for (int i =0; i<localArray.count; i++) {
            CartModel *cModel = localArray[i];
            //有
            if ([cModel.issueId isEqualToNumber:_detailModel.issueId ]) {
                
                CGFloat prcie;
                prcie = [_detailModel.defaultAmount floatValue] + [cModel.userBuyAmount floatValue];
                if (prcie > [cModel.toAmount floatValue]) {
                    cModel.userBuyAmount = cModel.toAmount;
                }else {
                    cModel.userBuyAmount = [NSNumber numberWithFloat:prcie];
                }
                isExist = YES;
            }
        }
        if (!isExist) {
            CartModel *cModel = [[CartModel alloc] init];
            cModel.areaAmount = _detailModel.areaAmount;
            cModel.attendAmount = @0;
            cModel.userBuyAmount = _detailModel.defaultAmount;
            cModel.pictureUrl = _detailModel.pictureUrl[0];
            cModel.remainAmount = _detailModel.remainAmount;
            cModel.sid = @0;
            cModel.stepAmount = _detailModel.stepAmount;
            cModel.title = _detailModel.title;
            cModel.toAmount = _detailModel.toAmount;
            cModel.issueId = _detailModel.issueId;
            cModel.pricePercentAmount = _detailModel.pricePercentAmount;
            cModel.userBuyAmount = _detailModel.defaultAmount;
            cModel.isSelect = YES;
            
            //            NSInteger restAmount;
            //            restAmount =[_joinModel.toAmount integerValue]-[_joinModel.buyAmount integerValue] - [_joinModel.userBuyAmount integerValue];
            //            cModel.remainAmount = [NSNumber numberWithInteger:restAmount];
            [localArray addObject:cModel];
            isExist = NO;
        }
    }
    NSMutableData *data = [[NSMutableData alloc] init];
    //创建归档辅助类
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //编码
    [archiver encodeObject:localArray forKey:LOCALCART];
    //结束编码
    [archiver finishEncoding];
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filename = [[array objectAtIndex:0] stringByAppendingPathComponent:LOCALCART];
    //写入
    [data writeToFile:filename atomically:YES];
    
}


+ (NSArray *)unarchiveLocalDataArray {
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filename = [[array objectAtIndex:0] stringByAppendingPathComponent:LOCALCART];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    // 2.创建反归档对象
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // 3.解码并存到数组中
    NSArray *namesArray = [unArchiver decodeObjectForKey:LOCALCART];
    return namesArray;

}

+ (void) emptyTheLocalDataArray {
    NSArray *localArray = [NSArray array];
    NSMutableData *data = [[NSMutableData alloc] init];
    //创建归档辅助类
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //编码
    [archiver encodeObject:localArray forKey:LOCALCART];
    //结束编码
    [archiver finishEncoding];
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filename = [[array objectAtIndex:0] stringByAppendingPathComponent:LOCALCART];
    //写入
    [data writeToFile:filename atomically:YES];

}

+ (void)archiveRedPastArrayWithArray:(NSMutableArray *)_redPastArray {
    NSMutableData *data = [[NSMutableData alloc] init];
    //创建归档辅助类
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //编码
    [archiver encodeObject:_redPastArray forKey:WINNINGRECORD];
    //结束编码
    [archiver finishEncoding];
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filename = [[array objectAtIndex:0] stringByAppendingPathComponent:WINNINGRECORD];
    //写入
    [data writeToFile:filename atomically:YES];
}
+ (NSArray *)unarchiveRedPastArray {
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filename = [[array objectAtIndex:0] stringByAppendingPathComponent:WINNINGRECORD];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    // 2.创建反归档对象
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // 3.解码并存到数组中
    NSArray *pastArray = [unArchiver decodeObjectForKey:WINNINGRECORD];
    return pastArray;
}
+ (void) emptyTheRedPastArray {
    NSArray *pastArray = [NSArray array];
    NSMutableData *data = [[NSMutableData alloc] init];
    //创建归档辅助类
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //编码
    [archiver encodeObject:pastArray forKey:WINNINGRECORD];
    //结束编码
    [archiver finishEncoding];
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filename = [[array objectAtIndex:0] stringByAppendingPathComponent:WINNINGRECORD];
    //写入
    [data writeToFile:filename atomically:YES];
}


@end
