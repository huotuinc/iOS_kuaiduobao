//
//  RechargeCell.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/31.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RechargeCell.h"

@implementation RechargeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(PutModel *)model {
    _model = model;
    _payType.text = model.moneyFlowTypeName;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.time doubleValue] / 1000];
    _time.text = [formatter stringFromDate:date];
    _paySuccess.text = model.remark;
    _money.text = [NSString stringWithFormat:@"%@元",model.money];
}


@end
