//
//  HT_FM_HomeFourBtnCView.m
//  FEN
//
//  Created by che on 16/1/18.
//  Copyright © 2016年 车. All rights reserved.
//

#import "HomeFourBtnCView.h"


@implementation HomeFourBtnCView

- (void)awakeFromNib {
    // Initialization code
    NSArray *arrTitle=@[@"分类",@"10元专区",@"晒单",@"常见问题"];
    for (int i=0; i<4; i++) {
        UILabel *label=[self viewWithTag:100+i];
        label.text=arrTitle[i];
        [UILabel changeLabel:label AndFont:17 AndColor:[UIColor blackColor]];
    }
    NSArray *arrImage=@[@"home_content_fenlei",@"home_content_zhuanqu",@"home_content_shaidan",@"home_content_wenti"];
    for (int i=0; i<4; i++) {
        UIImageView *imageV=[self viewWithTag:200+i];
        imageV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",arrImage[i]]];
    }
    _imageVLine.image=[UIImage imageNamed:@"xian_3"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
