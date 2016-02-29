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
@property (nonatomic, strong) NSNumber *fee;
@property (nonatomic, copy) NSNumber *orderNo;
@property (nonatomic, copy) NSString *	remainPayUrl;
@property (nonatomic, copy) NSString *wxCallbackUrl;

@end
