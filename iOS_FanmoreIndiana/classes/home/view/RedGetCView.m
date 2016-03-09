//
//  RedGetCView.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/9.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RedGetCView.h"

@implementation RedGetCView

- (void)awakeFromNib {
    // Initialization code
    [UILabel changeLabel:_labelCount AndFont:30 AndColor:COLOR_SHINE_RED];
    [UILabel changeLabel:_labelMoney AndFont:30 AndColor:COLOR_SHINE_RED];
    _labelCount.text = @"恭喜你获得了一个红包";
    _labelMoney.text = @"可免费获得一次1次0.5元购买";
    _imageVBack.image = [UIImage imageNamed:@"hbbb"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
