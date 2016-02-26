//
//  AddressCell.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/18.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface AddressCell : UITableViewCell

@property (nonatomic, strong) AddressModel *model;
@property (weak, nonatomic) IBOutlet UILabel *nema;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIImageView *exchanage;

@end
