//
//  DetailTimeCView.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "DetailTimeCView.h"

@implementation DetailTimeCView

- (void)awakeFromNib {
    // Initialization code
    _viewBase.backgroundColor=[UIColor redColor];
    [UIButton changeButton:_buttonDetail AndFont:17 AndTitleColor:[UIColor whiteColor] AndBackgroundColor:[UIColor clearColor] AndBorderColor:[UIColor whiteColor] AndCornerRadius:3 AndBorderWidth:1];
    for (int i =0; i < 4; i++) {
        UILabel *label=[self viewWithTag:100 +i];
        [UILabel changeLabel:label AndFont:26 AndColor:[UIColor whiteColor]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
