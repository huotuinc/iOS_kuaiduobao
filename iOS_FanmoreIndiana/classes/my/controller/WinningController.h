//
//  WinningController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/31.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WinningController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *winImage;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIButton *snatch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)goHomeController:(id)sender;

@end
