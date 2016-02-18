//
//  DetailPastTableViewCell.h
//  粉猫xib
//
//  Created by che on 16/1/31.
//  Copyright © 2016年 车. All rights reserved.
//

#import <UIKit/UIKit.h>
//330 tag 100-104
@interface DetailPastTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UILabel *labelItem;
@property (weak, nonatomic) IBOutlet UIView *viewItem;
@property (weak, nonatomic) IBOutlet UIImageView *imageVHead;
@property (weak, nonatomic) IBOutlet UILabel *labelWinner;
@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelID;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelAttend;

@end
