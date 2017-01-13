//
//  WinningConfirmController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinningDeliveryModel.h"
#import "WinningModel.h"

@interface WinningConfirmController : UITableViewController

@property (nonatomic, strong) WinningModel *winningModel;

/**
 *  获得奖品
 */
@property (weak, nonatomic) IBOutlet UIImageView *getGoodImage;
@property (weak, nonatomic) IBOutlet UILabel *getGoodLabel;
@property (weak, nonatomic) IBOutlet UILabel *getTimeLabel;

/**
 *  确认收货地址
 */
@property (weak, nonatomic) IBOutlet UIImageView *confirmImage;
@property (weak, nonatomic) IBOutlet UILabel *confirmLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmTime;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

/**
 *  奖品派发
 */
@property (weak, nonatomic) IBOutlet UIImageView *sendImage;
@property (weak, nonatomic) IBOutlet UILabel *sendLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendTime;

/**
 *  确认收货
 */
@property (weak, nonatomic) IBOutlet UIImageView *confirmGoodImage;
@property (weak, nonatomic) IBOutlet UILabel *confirmGoodLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmGoodTime;
@property (weak, nonatomic) IBOutlet UIButton *confirmGoodButton;

/**
 *  已签收
 */
@property (weak, nonatomic) IBOutlet UIImageView *endImage;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UIButton *endButton;

/**
 *  收件人信息
 */
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;

/**
 *  商品详情
 */

@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *joinId;
@property (weak, nonatomic) IBOutlet UILabel *person;
@property (weak, nonatomic) IBOutlet UILabel *luckyNum;
@property (weak, nonatomic) IBOutlet UILabel *joinCount;
@property (weak, nonatomic) IBOutlet UILabel *time;



@end
