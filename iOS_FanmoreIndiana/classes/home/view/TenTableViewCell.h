//
//  TenTableViewCell.h
//  粉猫xib
//
//  Created by che on 16/1/21.
//  Copyright © 2016年 车. All rights reserved.
//

#import <UIKit/UIKit.h>
//200
@interface TenTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewBase;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIImageView *imageVGoods;
@property (weak, nonatomic) IBOutlet UIImageView *imageVSign;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIProgressView *viewProgress;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UILabel *labelTotal;
@property (weak, nonatomic) IBOutlet UILabel *labelRest;

@end
