//
//  AppCountResultModel.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/2.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "AppCountResultModel.h"

@implementation AppCountResultModel

- (NSDictionary *)objectClassInArray
{
    return @{@"userNumbers":[AppUserNumberModel class]};
}

@end
