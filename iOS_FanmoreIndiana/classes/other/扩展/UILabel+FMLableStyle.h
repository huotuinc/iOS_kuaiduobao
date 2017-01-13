//
//  UILabel+FMLableStyle.h
//  FEN
//
//  Created by che on 16/1/19.
//  Copyright © 2016年 车. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FMLableStyle)
/**
 *  设置label的字体大小和颜色
 *
 *  @param label 更改的label
 *  @param font  整形(相对效果图的像素大小)
 *  @param color 颜色
 *  @param title 内容
 */
+(UILabel *)changeLabel:(UILabel *) label AndFont:(NSInteger) font AndColor:(UIColor *) color;


@end
