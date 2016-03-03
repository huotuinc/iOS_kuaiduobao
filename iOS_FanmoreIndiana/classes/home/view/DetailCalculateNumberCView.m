//
//  DetailCalculateNumberCView.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "DetailCalculateNumberCView.h"

@implementation DetailCalculateNumberCView

- (void)awakeFromNib {
    // Initialization code
    _imageVLineA.image = [UIImage imageNamed:@"line_huise"];
    _imageVLine.image = [UIImage imageNamed:@"alert_error_icon"];
    _imageVLineB.image = [UIImage imageNamed:@"line_huise"];
    _imageVLineC.image = [UIImage imageNamed:@"line_huise"];
    [UILabel changeLabel:_labelA AndFont:26 AndColor:COLOR_TEXT_CONTENT];
    [UILabel changeLabel:_labelB AndFont:26 AndColor:COLOR_TEXT_CONTENT];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end