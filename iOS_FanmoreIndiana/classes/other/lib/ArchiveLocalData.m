//
//  ArchiveLocalData.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/16.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ArchiveLocalData.h"

@implementation ArchiveLocalData

+ (void)archiveLocalDataArrayWithModel:(AppGoodsListModel *)_joinModel {
    NSMutableArray *localArray = [NSMutableArray array];
    BOOL isExist = NO;
    if ([self unarchiveLocalDataArray] == nil) {
        CartModel *cModel = [[CartModel alloc] init];
        cModel.areaAmount = _joinModel.areaAmount;
        cModel.attendAmount = _joinModel.attendAmount;
        cModel.userBuyAmount = _joinModel.defaultAmount;
        cModel.isSelect = _joinModel.isSelect;
        cModel.pictureUrl = _joinModel.pictureUrl;
        cModel.remainAmount = _joinModel.remainAmount;
        cModel.sid = _joinModel.sid;
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
            cModel.attendAmount = _joinModel.attendAmount;
            cModel.userBuyAmount = _joinModel.defaultAmount;
            cModel.isSelect = _joinModel.isSelect;
            cModel.pictureUrl = _joinModel.pictureUrl;
            cModel.remainAmount = _joinModel.remainAmount;
            cModel.sid = _joinModel.sid;
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

@end
