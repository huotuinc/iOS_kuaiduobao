//
//  RedWaitCView.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/10.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RedWaitCView.h"

@implementation RedWaitCView

- (void)awakeFromNib {
    // Initialization code
    _viewBase.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8];
    [UILabel changeLabel:_labelRest AndFont:30 AndColor:[UIColor whiteColor]];
    [UILabel changeLabel:_labelTime AndFont:30 AndColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
