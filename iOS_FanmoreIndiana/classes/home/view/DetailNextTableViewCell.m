//
//  DetailNextTableViewCell.m
//  粉猫xib
//
//  Created by che on 16/1/22.
//  Copyright © 2016年 车. All rights reserved.
//

#import "DetailNextTableViewCell.h"

@implementation DetailNextTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _imageVNext.image=[UIImage imageNamed:@"back_gray"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
