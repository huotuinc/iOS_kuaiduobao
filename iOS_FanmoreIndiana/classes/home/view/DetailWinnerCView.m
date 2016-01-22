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
    _imageVHead.image=[UIImage imageNamed:@"tou"];
    _viewMain.backgroundColor=[UIColor cyanColor];
    _viewBase.layer.borderWidth=1;
    _viewBase.layer.borderColor=[UIColor grayColor].CGColor;
    _viewBase.layer.masksToBounds=YES;
    for ( int i= 0; i<8; i++) {
        UILabel *label=[self viewWithTag:100+i];
        label.font=[UIFont systemFontOfSize:10];
        label.backgroundColor=[UIColor clearColor];
    }
    [UIButton changeButton:_buttonContent AndFont:16 AndTitleColor:[UIColor whiteColor] AndBackgroundColor:[UIColor clearColor] AndBorderColor:[UIColor whiteColor] AndCornerRadius:3 AndBorderWidth:1];
    _labelNumber.textColor=[UIColor whiteColor];
    _labelNumberA.textColor=[UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
