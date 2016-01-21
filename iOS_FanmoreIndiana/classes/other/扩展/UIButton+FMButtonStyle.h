//
//  UIButton+FMButtonStyle.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/21.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FMButtonStyle)

+(UIButton *)changeButton:(UIButton *) button AndFont:(NSInteger) font AndTitleColor:(UIColor *) titleColor AndBackgroundColor:(UIColor *)backColor AndBorderColor:(UIColor *) borderColor AndCornerRadius:(NSInteger ) radius AndBorderWidth:(NSInteger) width;

@end
