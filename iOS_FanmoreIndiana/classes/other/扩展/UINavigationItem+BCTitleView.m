//
//  UINavigationItem+BCTitleView.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/11.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "UINavigationItem+BCTitleView.h"

@implementation UINavigationItem (BCTitleView)

-(UIView *)changeNavgationBarTitle:(NSString *)title{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:FONT_SIZE(36)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = self.titleView.center;
    titleLabel.text = title;
    self.titleView = titleLabel;
    return self.titleView;
}


@end
