//
//  DetailTimeCView.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
//110
@interface DetailTimeCView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelIssue;
@property (weak, nonatomic) IBOutlet UILabel *labelEndTime;
@property (weak, nonatomic) IBOutlet UILabel *labelIssueA;
@property (weak, nonatomic) IBOutlet UILabel *labelEndTimeA;
@property (weak, nonatomic) IBOutlet UIButton *buttonDetail;
@property (weak, nonatomic) IBOutlet UIView *viewBase;

@end
