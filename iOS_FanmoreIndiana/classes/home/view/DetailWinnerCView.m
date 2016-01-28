//
//  DetailWinnerCView.m
//  粉猫xib
//
//  Created by che on 16/1/21.
//  Copyright © 2016年 车. All rights reserved.
//

#import "DetailWinnerCView.h"
#import "UIButton+FMButtonStyle.h"
@implementation DetailWinnerCView

- (void)awakeFromNib {
    // Initialization code
    _imageVState.image=[UIImage imageNamed:@"huojiang"];
    _imageVLuck.image=[UIImage imageNamed:@"di"];
    _imageVHead.image=[UIImage imageNamed:@"error"];
    _viewMain.backgroundColor=[UIColor cyanColor];
    _viewBase.layer.borderWidth=1;
    _viewBase.layer.borderColor=[UIColor grayColor].CGColor;
    _viewBase.layer.masksToBounds=YES;
    for ( int i= 0; i<8; i++) {
        UILabel *label=[self viewWithTag:100+i];
        label.backgroundColor=[UIColor clearColor];
        [UILabel changeLabel:label AndFont:24 AndColor:COLOR_TEXT_DATE];
    }
    [UILabel changeLabel:_labelWinner AndFont:28 AndColor:COLOR_TEXT_CONTENT];
    [UILabel changeLabel:_labelWinnerA AndFont:28 AndColor:COLOR_BUTTON_ORANGE];
    [UILabel changeLabel:_labelAttendA AndFont:24 AndColor:COLOR_BUTTON_ORANGE];
    [UILabel changeLabel:_labelNumber AndFont:24 AndColor:[UIColor whiteColor]];
    [UILabel changeLabel:_labelNumberA AndFont:28 AndColor:[UIColor whiteColor]];
    [UIButton changeButton:_buttonContent AndFont:28 AndTitleColor:[UIColor whiteColor] AndBackgroundColor:[UIColor clearColor] AndBorderColor:[UIColor whiteColor] AndCornerRadius:3 AndBorderWidth:1];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
