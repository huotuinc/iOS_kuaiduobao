//
//  DetailShareNextHeadTableViewCell.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
//10.f+340 tag label 100-109 imageV 200-202
@interface DetailShareNextHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelGoods;
@property (weak, nonatomic) IBOutlet UILabel *labelIssued;
@property (weak, nonatomic) IBOutlet UILabel *labelAttend;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelAnncounedTime;
@property (weak, nonatomic) IBOutlet UIView *viewDetail;

@end
