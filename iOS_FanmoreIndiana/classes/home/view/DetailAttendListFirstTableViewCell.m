//
//  DeatilAttendListFirstTableViewCell.m
//  粉猫xib
//
//  Created by che on 16/1/22.
//  Copyright © 2016年 车. All rights reserved.
//

#import "DetailAttendListFirstTableViewCell.h"

@implementation DetailAttendListFirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _imageVLine.image=[UIImage imageNamed:@"line_huise"];
}
-(void)drawRect:(CGRect)rect{
    _labelDate.layer.cornerRadius=_labelDate.frame.size.height/2;
    _labelDate.layer.borderColor=[UIColor grayColor].CGColor;
    _labelDate.layer.borderWidth=1;
    _labelDate.layer.masksToBounds=YES;


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
