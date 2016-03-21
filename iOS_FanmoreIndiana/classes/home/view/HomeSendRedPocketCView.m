//
//  HomeSendRedPocketCView.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/14.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "HomeSendRedPocketCView.h"

@implementation HomeSendRedPocketCView

- (void)awakeFromNib {
    // Initialization code
    _imageVBack.image = [UIImage imageNamed:@"fahongbao"];
    _imageVClose.image = [UIImage imageNamed:@"close"];
    _imageVMoney.image = [UIImage imageNamed:@"jingbi"];
    //    [_imageVLine.image ]
    [UIButton changeButton:_buttonSend AndFont:44 AndTitleColor:COLOR_TEXT_TITILE AndBackgroundColor:COLOR_BUTTON_ORANGE AndBorderColor:COLOR_BUTTON_ORANGE AndCornerRadius:3 AndBorderWidth:1];
    [UILabel changeLabel:_labelA AndFont:50 AndColor:COLOR_BUTTON_ORANGE];
    [UILabel changeLabel:_labelNumber AndFont:108 AndColor:COLOR_BUTTON_ORANGE];
    [UILabel changeLabel:_labelYou AndFont:40 AndColor:[UIColor whiteColor]];
    [UILabel changeLabel:_labelYao AndFont:36 AndColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
