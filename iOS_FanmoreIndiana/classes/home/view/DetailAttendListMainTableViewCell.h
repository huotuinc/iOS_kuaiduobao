//
//  DetailiAttendListTableViewCell.h
//  粉猫xib
//
//  Created by che on 16/1/22.
//  Copyright © 2016年 车. All rights reserved.
//

#import <UIKit/UIKit.h>
//120
@interface DetailAttendListMainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageVHead;
@property (weak, nonatomic) IBOutlet UIImageView *imageVLine;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UIView *viewBase;

@end
