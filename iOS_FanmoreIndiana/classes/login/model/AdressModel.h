//
//  AdressModel.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AdressModel : NSObject

@property (nonatomic, assign) BOOL defaultAddress;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSNumber *addressId;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *receiver;

@end
