//
//  DetailShareTableViewCell.h
//  粉猫xib
//
//  Created by che on 16/1/29.
//  Copyright © 2016年 车. All rights reserved.
//

#import <UIKit/UIKit.h>
//500
@interface DetailShareTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewBase;
@property (weak, nonatomic) IBOutlet UIImageView *imageVHead;
@property (weak, nonatomic) IBOutlet UIImageView *imageVPoint;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelGoods;
@property (weak, nonatomic) IBOutlet UILabel *labelItem;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UIImageView *imageVA;
@property (weak, nonatomic) IBOutlet UIImageView *imageVB;
@property (weak, nonatomic) IBOutlet UIImageView *imageVC;
@property (weak, nonatomic) IBOutlet UIImageView *imageVD;

@end
