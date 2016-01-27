//
//  TenTableViewCell.m
//  粉猫xib
//
//  Created by che on 16/1/21.
//  Copyright © 2016年 车. All rights reserved.
//

#import "TenTableViewCell.h"
@implementation TenTableViewCell

- (void)awakeFromNib {
    // Initialization code

    
    _labelTitle.numberOfLines=0;
    _labelTitle.text=@"网易云音乐都发生的发的说说的服务渐渐离开";
    
    _viewProgress.transform=CGAffineTransformMakeScale(1.0f, 1.0f);
    _viewProgress.layer.cornerRadius=5;
    _viewProgress.clipsToBounds=YES;
    //设置进度条颜色
    _viewProgress.trackTintColor=[UIColor grayColor];
    //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
    _viewProgress.progress=0.7;
    //设置进度条上进度的颜色
    _viewProgress.progressTintColor=[UIColor orangeColor];

    [UIButton changeButton:_buttonAdd AndFont:26 AndTitleColor:[UIColor redColor] AndBackgroundColor:[UIColor whiteColor] AndBorderColor:[UIColor redColor] AndCornerRadius:3 AndBorderWidth:1];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
