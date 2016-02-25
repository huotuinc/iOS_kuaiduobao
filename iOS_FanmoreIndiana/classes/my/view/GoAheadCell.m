//
//  GoAheadCell.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "GoAheadCell.h"

@implementation GoAheadCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(RaiderModel *)model {
    _model = model;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl] completed:nil];
    self.name.text = model.title;
    self.issueLabel.text = [NSString stringWithFormat:@"期号：%@", model.issueId];
    self.toAmountLabel.text = [NSString stringWithFormat:@"总需：%@人次", model.toAmount];
    self.attendLabel.text = [NSString stringWithFormat:@"%@", model.attendAmount];
}

@end
