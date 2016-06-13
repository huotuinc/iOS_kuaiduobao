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
    [super awakeFromNib];
    
    _labelTitle.numberOfLines=0;
    _labelTitle.text=@"网易云音乐都发生的发的说说的服务渐渐离开";
    
    _viewProgress.transform=CGAffineTransformMakeScale(1.0f, 1.0f);
    _viewProgress.clipsToBounds=YES;
    //设置进度条颜色
    _viewProgress.trackTintColor=COLOR_PROGRESS_B;
    //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
    _viewProgress.progress=0.7;
    //设置进度条上进度的颜色
    _viewProgress.progressTintColor=COLOR_PROGRESS_A;
    [UILabel changeLabel:_labelTotal AndFont:24 AndColor:COLOR_BUTTON_ORANGE]
    ;
    [UILabel changeLabel:_labelRest AndFont:24 AndColor:COLOR_SHINE_BLUE];
    [UILabel changeLabel:_labelTitle AndFont:28 AndColor:COLOR_TEXT_TITILE];
    [UIButton changeButton:_buttonAdd AndFont:24 AndTitleColor:[UIColor redColor] AndBackgroundColor:[UIColor whiteColor] AndBorderColor:[UIColor redColor] AndCornerRadius:3 AndBorderWidth:1];
    
    _labelTitle.numberOfLines=0;
    
}
-(void)drawRect:(CGRect)rect{
    _viewProgress.layer.cornerRadius=_viewProgress.frame.size.height/2;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
