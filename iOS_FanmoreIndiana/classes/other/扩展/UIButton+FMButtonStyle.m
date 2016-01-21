//
//  UIButton+FMButtonStyle.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/21.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "UIButton+FMButtonStyle.h"

@implementation UIButton (FMButtonStyle)

+(UIButton *)changeButton:(UIButton *) button AndFont:(NSInteger) font AndTitleColor:(UIColor *) titleColor AndBackgroundColor:(UIColor *)backColor AndBorderColor:(UIColor *) borderColor AndCornerRadius:(NSInteger ) radius AndBorderWidth:(NSInteger) width{
    button.titleLabel.font=[UIFont systemFontOfSize:FONT_SIZE(font)];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor=backColor;
    button.layer.borderColor=borderColor.CGColor;
    button.layer.borderWidth=width;
    button.layer.cornerRadius=radius;
    button.layer.masksToBounds=YES;
    return button;
}

@end
