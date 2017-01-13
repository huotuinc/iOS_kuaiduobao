//
//  Singleton.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/28.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
@property (nonatomic, strong) NSNumber * sourceId;


+ (Singleton *)shareSingle;

@end
