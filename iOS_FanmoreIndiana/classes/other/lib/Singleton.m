//
//  Singleton.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/28.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "Singleton.h"

static Singleton *single;

@implementation Singleton

+ (Singleton *)shareSingle{
    
    if (single == nil) {
        single = [[Singleton alloc] init];
        
    }
    
    //返回我的Static single对象
    return single;
}

@end
