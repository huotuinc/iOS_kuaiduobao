//
//  ListNumberTopTableViewCell.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/3.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
//190
@interface ListNumberTopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewBase;
@property (weak, nonatomic) IBOutlet UILabel *labelA;
@property (weak, nonatomic) IBOutlet UIImageView *imageVLineA;
@property (weak, nonatomic) IBOutlet UIImageView *imageVLineB;
@property (weak, nonatomic) IBOutlet UIImageView *imageVLineC;
@property (weak, nonatomic) IBOutlet UILabel *labelGoods;
@property (weak, nonatomic) IBOutlet UILabel *labelIssued;
@property (weak, nonatomic) IBOutlet UILabel *labelCount;

@end
