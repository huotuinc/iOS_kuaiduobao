//
//  DetailWinnerCView.h
//  粉猫xib
//
//  Created by che on 16/1/21.
//  Copyright © 2016年 车. All rights reserved.
//

#import <UIKit/UIKit.h>
//labeltag 100 -107
@interface DetailWinnerCView : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewBase;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIView *viewLuck;


@property (weak, nonatomic) IBOutlet UIImageView *imageVState;
@property (weak, nonatomic) IBOutlet UIImageView *imageVHead;

@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelNumberA;
@property (weak, nonatomic) IBOutlet UIButton *buttonContent;
@property (weak, nonatomic) IBOutlet UIImageView *imageVLuck;

@property (weak, nonatomic) IBOutlet UILabel *labelWinner;
@property (weak, nonatomic) IBOutlet UILabel *labelWinnerA;
@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelID;
@property (weak, nonatomic) IBOutlet UILabel *labelIDA;
@property (weak, nonatomic) IBOutlet UILabel *labelTerm;
@property (weak, nonatomic) IBOutlet UILabel *labelTermA;
@property (weak, nonatomic) IBOutlet UILabel *labelAttebd;
@property (weak, nonatomic) IBOutlet UILabel *labelAttendA;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeA;


@end
