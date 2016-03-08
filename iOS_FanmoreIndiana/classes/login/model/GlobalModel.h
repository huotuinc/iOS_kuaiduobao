//
//  GlobalModel.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/28.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalModel : NSObject
@property (nonatomic, strong) NSString *customerServicePhone;
@property (nonatomic, strong) NSString *helpURL;
@property (nonatomic, strong) NSString *serverUrl;
@property (nonatomic, strong) NSString *redRules;
@property (nonatomic, assign) BOOL voiceSupported;
@end
