//
//  HomeSearchCView
//  MeiTou
//
//  Created by che on 15/12/10.
//  Copyright © 2015年 车. All rights reserved.
//

#import "HomeSearchCView.h"

@implementation HomeSearchCView


-(void)awakeFromNib{
//    _searchBar.backgroundImage=[UIImage imageNamed:@"aaa"];
    _searchBar.barTintColor = [UIColor whiteColor];
    [_searchBar setBackgroundImage:[UIImage imageNamed:@""]];
    for (UIView* subview in [[_searchBar.subviews lastObject] subviews]) {
        
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subview;
            
//            textField.textColor = [UIColor redColor];                         //修改输入字体的颜色
            [textField setBackgroundColor:COLOR_BACK_MAIN];      //修改输入框的颜色
        }
//            [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];   //修改placeholder的颜色
//        } else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
//        {
//            [subview removeFromSuperview];
//        }
    }}
@end
