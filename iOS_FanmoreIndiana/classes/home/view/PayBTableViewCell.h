//
//  PayBTableViewCell.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
//90
@interface PayBTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *buttonSelect;
@property (weak, nonatomic) IBOutlet UIImageView *imageVLine;
@property (weak, nonatomic) IBOutlet UILabel *labelPay;
@property (weak, nonatomic) IBOutlet UIImageView *imageVBottom;

@end
