//
//  RedCountCView.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/8.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RedCountCView.h"

@implementation RedCountCView

- (void)awakeFromNib {
    // Initialization code
    [UILabel changeLabel:_labelAA AndFont:30 AndColor:COLOR_PROGRESS_A];[UILabel changeLabel:_labelAA AndFont:30 AndColor:COLOR_PROGRESS_A];
    [UILabel changeLabel:_labelBB AndFont:30 AndColor:COLOR_PROGRESS_A];
    [UILabel changeLabel:_labelTime AndFont:30 AndColor:COLOR_PROGRESS_A];
    
    for (int i = 0 ; i<6; i++) {
        UILabel *label = [self viewWithTag:100 +i];
        [UILabel changeLabel:label AndFont:30 AndColor:COLOR_TEN_RED];
        label.layer.cornerRadius = 3;
        label.backgroundColor = COLOR_PROGRESS_A;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
    }
    
}
//ADAPT_HEIGHT(50) * 6 +5 * 5
- (void) drawRect:(CGRect)rect {
//    _viewCount.frame = CGRectMake(0, 0, ADAPT_HEIGHT(50) * 6 +5 * 5, ADAPT_HEIGHT(50));
//    _viewCount.center = CGPointMake(self.center.x - (ADAPT_HEIGHT(50) * 6 +5 * 5)/2, ADAPT_HEIGHT(75));
//    _viewCount.backgroundColor = COLOR_BUTTON_GREEN;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
