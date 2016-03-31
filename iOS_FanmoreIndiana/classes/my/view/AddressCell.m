//
//  AddressCell.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/18.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(AdressModel *)model {
    _model = model;
    self.nema.text = model.receiver;
    self.phone.text = model.mobile;
    if (model.defaultAddress) {
        
        NSArray *array = [model.cityName componentsSeparatedByString:@"|"];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: @"[默认]%@%@%@%@",array[0],array[1],array[2],model.details]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 4)];
        self.address.attributedText = str;

    }else {
        NSArray *array = [model.cityName componentsSeparatedByString:@"|"];
        self.address.text = [NSString stringWithFormat:@"%@%@%@%@", array[0], array[1], array[2], model.details];
    }
}

@end
