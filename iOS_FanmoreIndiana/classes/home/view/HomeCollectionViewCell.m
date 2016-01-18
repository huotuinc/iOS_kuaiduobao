//
//  HomeCollectionViewCell.m
//  home
//
//  Created by 刘琛 on 16/1/15.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.joinList.layer.borderColor = [UIColor redColor].CGColor;
    self.joinList.layer.borderWidth = 1;
    self.joinList.tintColor = [UIColor redColor];
    self.joinList.layer.cornerRadius = 5;
    
    
}

@end
