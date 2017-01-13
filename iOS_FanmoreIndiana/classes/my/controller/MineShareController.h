//  我的晒单
//  MineShareController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/22.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineShareController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *noneImage;
@property (weak, nonatomic) IBOutlet UILabel *noneLabel;
@property (weak, nonatomic) IBOutlet UIButton *snatch;
- (IBAction)snatchAction:(id)sender;

@end
