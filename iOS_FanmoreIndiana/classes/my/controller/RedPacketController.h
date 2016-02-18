//
//  RedPacketController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedPacketController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *selectBgView;
@property (weak, nonatomic) IBOutlet UIButton *possess;
@property (weak, nonatomic) IBOutlet UIButton *used;
- (IBAction)possessAction:(id)sender;
- (IBAction)usedAction:(id)sender;

@property (nonatomic, strong) UIView *slider;
@property (weak, nonatomic) IBOutlet UIImageView *noneImage;
@property (weak, nonatomic) IBOutlet UILabel *noneLabel;
@property (weak, nonatomic) IBOutlet UIButton *snatch;
- (IBAction)snatchAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
