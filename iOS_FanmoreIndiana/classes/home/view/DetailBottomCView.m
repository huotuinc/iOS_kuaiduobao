//
//  DetailBottomCView.m
//  粉猫xib
//
//  Created by che on 16/1/22.
//  Copyright © 2016年 车. All rights reserved.
//

#import "DetailBottomCView.h"
#import "UIButton+FMButtonStyle.h"
@implementation DetailBottomCView

- (void)awakeFromNib {
    // Initialization code
    [UIButton changeButton:_buttonGo AndFont:28 AndTitleColor:[UIColor whiteColor] AndBackgroundColor:[UIColor orangeColor] AndBorderColor:[UIColor orangeColor] AndCornerRadius:3 AndBorderWidth:1];
    
    [UIButton changeButton:_buttonAdd AndFont:28 AndTitleColor:[UIColor orangeColor] AndBackgroundColor:[UIColor whiteColor] AndBorderColor:[UIColor orangeColor] AndCornerRadius:3 AndBorderWidth:1];
    _imageVShop.image=[UIImage imageNamed:@"gouwuche"];
    _imageVLine.image=[UIImage imageNamed:@"line_huise"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
