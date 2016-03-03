//
//  PayModel.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/17.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayModel : NSObject

@property (nonatomic, strong) NSString *alipayCallbackUrl;
@property (nonatomic, strong) NSNumber *fee;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSNumber *orderNo;
@property (nonatomic, strong) NSString *remainPayUrl;
@property (nonatomic, strong) NSString *wxCallbackUrl;

@end
