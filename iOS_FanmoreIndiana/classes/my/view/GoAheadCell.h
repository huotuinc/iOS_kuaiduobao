//
//  GoAheadCell.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaiderModel.h"

@interface GoAheadCell : UITableViewCell

@property (nonatomic, strong) RaiderModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *issueLabel;
@property (weak, nonatomic) IBOutlet UILabel *toAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *attendLabel;

@end
