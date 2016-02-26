//
//  AppGoodsDetailModel.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "AppGoodsDetailModel.h"

@implementation AppGoodsDetailModel

+ (instancetype)timeModelWithtime:(int)time {
    
    AppGoodsDetailModel *model = [self new];
    
    return model;
}

- (void)countDown {
    
    
    _remainSecond -= 1;
}


- (NSString*)currentTimeString{
    
    if (_remainSecond  <= 0) {
        
        return @"00:00:00";
        
    } else {
        //        NSUInteger day  = (NSUInteger)_m_countNum/(24*3600);
        //        NSUInteger hour = (NSUInteger)(_m_countNum%(24*3600))/3600;
        //        NSUInteger min  = (NSUInteger)(_m_countNum%(3600))/60;
        NSUInteger min  = (NSUInteger)(_remainSecond/100/60);
        NSUInteger second = (NSUInteger)(_remainSecond /100%60);
        NSUInteger msecond =
        (NSUInteger)(_remainSecond %100);
        NSString *minString=[NSString string];
        NSString *secondString=[NSString string];
        NSString *msecondString=[NSString string];
        
        if (min < 10) {
            minString =[NSString stringWithFormat:@"0%lu",min];
        }else{
            minString=[NSString stringWithFormat:@"%lu",min];
        }
        if (second < 10) {
            secondString =[NSString stringWithFormat:@"0%lu",second];
        }else{
            secondString=[NSString stringWithFormat:@"%lu",second];
        }
        if (msecond < 10) {
            msecondString =[NSString stringWithFormat:@"0%lu",msecond];
        }else{
            msecondString=[NSString stringWithFormat:@"%lu",msecond];
        }
        
        NSString *time = [NSString stringWithFormat:@"%@:%@:%@",minString,secondString,msecondString];
        return time;
    }
}

@end
