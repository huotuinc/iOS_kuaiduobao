//
//  UILabel+FMLableStyle.m
//  FEN
//
//  Created by che on 16/1/19.
//  Copyright © 2016年 车. All rights reserved.
//

#import "UILabel+FMLableStyle.h"

@implementation UILabel (FMLableStyle)

+(UILabel *)changeLabel:(UILabel *) label AndFont:(NSInteger) font AndColor:(UIColor *) color{
    label.font=[UIFont systemFontOfSize:FONT_SIZE(font)];
    label.textColor=color;
    return label;
}


@end
