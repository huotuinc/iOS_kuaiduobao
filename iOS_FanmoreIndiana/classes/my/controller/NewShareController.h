//
//  NewShareController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinningModel.h"
#import "WinningDeliveryModel.h"

@interface NewShareController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *shareTitle;
@property (weak, nonatomic) IBOutlet UITextView *shareDetail;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;
@property (weak, nonatomic) IBOutlet UIImageView *fourthImage;

@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodIssueNo;
@property (weak, nonatomic) IBOutlet UILabel *goodJoinCount;
@property (weak, nonatomic) IBOutlet UILabel *luckyNo;
@property (weak, nonatomic) IBOutlet UILabel *goodTime;

@property (nonatomic, strong) WinningModel *WinningModel;

@end
