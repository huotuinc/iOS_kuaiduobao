//
//  AppCountResultModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/2.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUserNumberModel.h"
@interface AppCountResultModel : NSObject

@property (nonatomic, copy) NSString *issueNo;
@property (nonatomic, strong) NSNumber *luckNumber;
@property (nonatomic, strong) NSNumber *numberA;
@property (nonatomic, strong) NSNumber *numberB;
@property (nonatomic, strong) NSArray *userNumbers;


@end
