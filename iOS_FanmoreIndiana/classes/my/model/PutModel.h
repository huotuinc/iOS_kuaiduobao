//
//  PutModel.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PutModel : NSObject

@property (nonatomic, strong) NSNumber *money;
@property (nonatomic, assign) NSInteger moneyFlowType;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSNumber *time;

@end
