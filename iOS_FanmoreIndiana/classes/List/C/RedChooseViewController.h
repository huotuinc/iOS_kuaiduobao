//
//  RedChooseViewController.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
//红包选择
@protocol redVDelegate <NSObject>

-(void)sendRedId:(NSNumber *)redId andTitle: (NSString *)title andDiscountMoney: (NSNumber *)discountMoeny;

@end


@interface RedChooseViewController : UIViewController
@property (nonatomic, strong) NSNumber *money;
@property (nonatomic,weak)id<redVDelegate>delegate;

@end
