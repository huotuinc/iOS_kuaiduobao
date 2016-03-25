//
//  AppPayModel.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppPayModel : NSObject


@property (nonatomic, copy) NSString *alipayCallbackUrl;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *alipayFee;
@property (nonatomic, copy) NSString *wxFee;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *remainPayUrl;
@property (nonatomic, copy) NSString *wxCallbackUrl;

@end
