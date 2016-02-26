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

- (void)setModel:(AddressModel *)model {
    _model = model;
    self.nema.text = model.receiver;
    self.phone.text = model.mobile;
    if (model.defaultAddress) {
        self.address.text = [NSString stringWithFormat:@"[默认]%@",model.details];
    }else {
        self.address.text = model.details;
    }
}

@end
