//
//  DetailShareTableViewCell.m
//  粉猫xib
//
//  Created by che on 16/1/29.
//  Copyright © 2016年 车. All rights reserved.
//

#import "DetailShareTableViewCell.h"
#define COLOR_BACK_MAIN [UIColor colorWithRed:244/255.0f green:244/255.0f blue:244/255.0f alpha:1]

@implementation DetailShareTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _imageVPoint.image=[UIImage imageNamed:@"wuyu"];
    _imageVHead.image=[UIImage imageNamed:@"home_content_shaidan"];
    _imageVA.image=[UIImage imageNamed:@"weixin"];
    _imageVB.image=[UIImage imageNamed:@"weixin"];
    _imageVC.image=[UIImage imageNamed:@"weixin"];
    _imageVD.image=[UIImage imageNamed:@"weixin"];
    _viewMain.backgroundColor=COLOR_BACK_MAIN;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
