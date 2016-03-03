//
//  CartModel.h
//  FMCart
//
//  Created by che on 16/2/18.
//  Copyright © 2016年 车. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CartModel : NSObject

@property (nonatomic, strong) NSNumber *areaAmount;
@property (nonatomic, strong) NSNumber *attendAmount;
@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic, strong) NSNumber *issueId;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, strong) NSNumber *remainAmount;
@property (nonatomic, copy) NSNumber *stepAmount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *toAmount;
@property (nonatomic, strong) NSNumber *userBuyAmount;
@property (nonatomic, strong) NSNumber *pricePercentAmount;

@end
