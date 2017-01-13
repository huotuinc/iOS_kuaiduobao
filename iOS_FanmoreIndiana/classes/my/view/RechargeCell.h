//
//  RechargeCell.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/31.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PutModel.h"

@interface RechargeCell : UITableViewCell

@property (nonatomic, strong) PutModel *model;
@property (weak, nonatomic) IBOutlet UILabel *payType;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *paySuccess;
@property (weak, nonatomic) IBOutlet UILabel *money;

@end
