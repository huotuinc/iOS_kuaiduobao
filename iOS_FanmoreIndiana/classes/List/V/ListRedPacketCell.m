//
//  RedPacketCell.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/2.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ListRedPacketCell.h"
@implementation ListRedPacketCell

- (void)awakeFromNib {
    // Initialization code
    [_buttonSelect setBackgroundImage:[UIImage imageNamed:@"recharge_icon_choose_none"] forState:UIControlStateNormal];
    
    [_buttonSelect setBackgroundImage:[UIImage imageNamed:@"recharge_icon_choose"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(RedPacketsModel *)model {
    _model = model;
    self.minus.text = [NSString stringWithFormat:@"%@",model.minusMoney];
    self.full.text = [NSString stringWithFormat:@"满%@元使用", model.fullMoney];
    self.titleName.text = model.title;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    NSDate *start = [NSDate dateWithTimeIntervalSince1970:[model.startTime doubleValue]];
    self.start.text =[NSString stringWithFormat:@"生效期：%@",[formatter stringFromDate:start]];
    
    NSDate *endTime = [NSDate dateWithTimeIntervalSince1970:[model.endTime doubleValue]];
    self.end.text = [NSString stringWithFormat:@"有效期：%@", [formatter stringFromDate:endTime]];
    
    self.remark.text = model.remark;
}

- (void)setSelectMark:(NSInteger)selectMark {
//    _selectMark = selectMark;
//    if (selectMark == 0) {
//        self.endImage.hidden = YES;
//    }else {
//        self.redPacket.image = [UIImage imageNamed:@"hb_gray"];
//        self.endImage.hidden = NO;
//    }
}

@end
