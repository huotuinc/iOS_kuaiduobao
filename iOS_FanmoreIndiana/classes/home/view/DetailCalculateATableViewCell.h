//
//  DetailCalculateATableViewCell.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
//50 label tag 100 - 104
@interface DetailCalculateATableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewBase;
@property (weak, nonatomic) IBOutlet UIImageView *imageVLine;
@property (weak, nonatomic) IBOutlet UILabel *labelA;
@property (weak, nonatomic) IBOutlet UILabel *labelB;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *imageVLineA;


@end
