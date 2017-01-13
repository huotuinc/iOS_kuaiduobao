//
//  DetailProgressCView.h
//  粉猫xib
//
//  Created by che on 16/1/22.
//  Copyright © 2016年 车. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailProgressCView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTerm;
@property (weak, nonatomic) IBOutlet UIProgressView *viewProgress;
@property (weak, nonatomic) IBOutlet UILabel *labelTotal;
@property (weak, nonatomic) IBOutlet UILabel *labelRest;

@end
