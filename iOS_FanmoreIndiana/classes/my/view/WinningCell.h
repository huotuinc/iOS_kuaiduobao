//
//  WinningCell.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/29.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinningModel.h"

@interface WinningCell : UITableViewCell

@property (nonatomic, strong) WinningModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *joinId;
@property (weak, nonatomic) IBOutlet UILabel *person;
@property (weak, nonatomic) IBOutlet UILabel *luckyNum;
@property (weak, nonatomic) IBOutlet UILabel *joinCount;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *confirm;

@end
