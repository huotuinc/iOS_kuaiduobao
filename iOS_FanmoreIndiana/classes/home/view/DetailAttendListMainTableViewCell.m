//
//  DetailiAttendListTableViewCell.m
//  粉猫xib
//
//  Created by che on 16/1/22.
//  Copyright © 2016年 车. All rights reserved.
//

#import "DetailAttendListMainTableViewCell.h"

@implementation DetailAttendListMainTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _imageVHead.image=[UIImage imageNamed:@"tou"];
    _imageVLine.image=[UIImage imageNamed:@"line_huise"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
