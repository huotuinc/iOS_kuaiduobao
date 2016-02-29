//
//  PayViewController.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppBalanceModel.h"
#import "RedChooseViewController.h"

@interface PayViewController : UIViewController<redVDelegate>

@property (nonatomic,strong) AppBalanceModel *payModel;
@property (nonatomic,strong) NSNumber *selectedRedId;

@property (nonatomic,copy) NSString *selectedRedTitle;


@end
