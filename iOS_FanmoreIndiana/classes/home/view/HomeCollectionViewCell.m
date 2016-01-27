//
//  HomeCollectionViewCell.m
//  home
//
//  Created by 刘琛 on 16/1/15.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [UILabel changeLabel:_labelName AndFont:28 AndColor:COLOR_TEXT_TITILE];
    [UILabel changeLabel:_labelProgress AndFont:24 AndColor:COLOR_TEXT_CONTENT];
    [UIButton changeButton:_joinList AndFont:24 AndTitleColor:COLOR_SHINE_RED AndBackgroundColor:[UIColor whiteColor] AndBorderColor:COLOR_SHINE_RED AndCornerRadius:3 AndBorderWidth:1];
    
    _viewProgress.transform=CGAffineTransformMakeScale(1.0f, 1.0f);
    _viewProgress.layer.cornerRadius=5;
    _viewProgress.clipsToBounds=YES;
    //设置进度条颜色
    _viewProgress.trackTintColor=COLOR_PROGRESS_B;
    //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
    _viewProgress.progress=0.7;
    //设置进度条上进度的颜色
    _viewProgress.progressTintColor=COLOR_PROGRESS_A;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.joinList.layer.borderColor = [UIColor redColor].CGColor;
    self.joinList.layer.borderWidth = 1;
    self.joinList.tintColor = [UIColor redColor];
    self.joinList.layer.cornerRadius = 5;
    
    
    
}

@end
