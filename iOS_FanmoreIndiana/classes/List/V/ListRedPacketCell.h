//
//  RedPacketCell.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/2.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedPacketsModel.h"

@interface ListRedPacketCell : UITableViewCell

@property (nonatomic, assign) NSInteger selectMark;
@property (nonatomic, strong) RedPacketsModel *model;
@property (weak, nonatomic) IBOutlet UILabel *minus;
@property (weak, nonatomic) IBOutlet UILabel *full;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *start;
@property (weak, nonatomic) IBOutlet UILabel *end;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UIImageView *redPacket;
@property (weak, nonatomic) IBOutlet UIButton *buttonSelect;

@end
