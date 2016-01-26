//
//  DetailAttendCountCView.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/25.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "DetailAttendCountCView.h"

@implementation DetailAttendCountCView

- (void)awakeFromNib {
    // Initialization code
    _viewBack.backgroundColor=[UIColor grayColor];
    _viewBack.layer.cornerRadius=3;
    _viewBack.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
