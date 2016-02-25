//  中奖记录
//  RecordController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/23.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordController : UIViewController

@property (nonatomic, assign) NSInteger selectMark;

@property (weak, nonatomic) IBOutlet UIView *sliderBgView;
@property (weak, nonatomic) IBOutlet UIView *slider;
@property (weak, nonatomic) IBOutlet UILabel *all;
@property (weak, nonatomic) IBOutlet UILabel *doing;
@property (weak, nonatomic) IBOutlet UILabel *end;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderX;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *tableBgView;
@property (weak, nonatomic) IBOutlet UIImageView *noneBox;
@property (weak, nonatomic) IBOutlet UILabel *noneLabel;
@property (weak, nonatomic) IBOutlet UIButton *goHome;
- (IBAction)goHomeAction:(id)sender;

@end
