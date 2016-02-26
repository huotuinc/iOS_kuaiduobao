//
//  PayATableViewCell.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "PayATableViewCell.h"

@implementation PayATableViewCell

- (void)awakeFromNib {
    // Initialization code
    _imageVLine.image = [UIImage imageNamed:@"line_huise"];
    _imageVTop.image = [UIImage imageNamed:@"line_huise"];
    [UILabel changeLabel:_labelA AndFont:26 AndColor:COLOR_TEXT_CONTENT];
    [UILabel changeLabel:_labelB AndFont:26 AndColor:COLOR_TEXT_DATE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
