//
//  DetailPastTableViewCell.m
//  粉猫xib
//
//  Created by che on 16/1/31.
//  Copyright © 2016年 车. All rights reserved.
//

#import "DetailPastTableViewCell.h"
#import "UILabel+FMLableStyle.h"
@implementation DetailPastTableViewCell

- (void)awakeFromNib {
    // Initialization code
    for (int i= 0;i<5 ; i++) {
        UILabel *label=[self viewWithTag:100+i];
        [UILabel changeLabel:label AndFont:24 AndColor:[UIColor grayColor]];
    }
    [UILabel changeLabel:_labelItem AndFont:24 AndColor:[UIColor grayColor]];
    _viewItem.backgroundColor=[UIColor cyanColor];
    _viewMain.layer.borderColor=COLOR_BACK_MAIN.CGColor;
    _viewMain.layer.borderWidth=1;
    _viewMain.layer.masksToBounds=YES;
    _imageVHead.image=[UIImage imageNamed:@"home_content_shaidan"];
    _viewItem.backgroundColor=COLOR_BACK_MAIN;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
