//
//  AddressModel.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/20.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, assign) BOOL defaultAddress;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *receiver;

@end
