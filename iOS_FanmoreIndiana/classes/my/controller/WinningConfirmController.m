//
//  WinningConfirmController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "WinningConfirmController.h"
#import "AdressController.h"
#import "NewShareController.h"

@interface WinningConfirmController ()

@property (nonatomic, strong) WinningDeliveryModel *model;

@end

@implementation WinningConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.confirmButton.layer.cornerRadius = 5;
    self.confirmGoodButton.layer.cornerRadius = 5;
    self.endButton.layer.cornerRadius = 5;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getWinningDeliveryModel];
    
    [self _initWinningModel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    }
    if (indexPath.section == 1) {
        if (self.model.deliveryStatus > 1) {
            if (indexPath.row == 0) {
                return 44;
            }else {
                return 88;
            }
        }else {
            return 0;
        }
        
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 44;
        }else {
            return 150;
        }
    }
    return 0;
}


- (void)getWinningDeliveryModel {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"issueId"] = self.winningModel.issueId;
    
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getOneLotteryInfo" parame:dic success:^(id json) {
        [SVProgressHUD dismiss];
        LWLog(@"%@",json);
        LWLog(@"%@",json[@"resultDescription"]);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            self.model = [WinningDeliveryModel mj_objectWithKeyValues:json[@"resultData"][@"data"]];
            [self.tableView reloadData];
            
            switch (self.model.deliveryStatus) {
                case 0:
                {
                    [self confirmAddress];
                    break;
                }
                case 1:
                {
                    [self addressHaveFillIn];
                    break;
                }
                case 2:
                {
                    [self addressHaveFillInAndSendOutGoods];
                    break;
                }
                case 5:
                {
                    [self successGetGoodsAndGoToShare];
                    break;
                }
                case 6:
                {
                    [self shareSuccess];
                    break;
                }
                default:
                    break;
            }
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        LWLog(@"%@",error);
    }];
}

/**
 *  显示确认收货地址
 */
- (void)confirmAddress {
    
    self.getGoodImage.image = [UIImage imageNamed:@"jiang_b"];
    self.confirmImage.image = [UIImage imageNamed:@"jiang_a"];
    self.sendImage.image = [UIImage imageNamed:@"jiang_f"];
    self.confirmGoodImage.image = [UIImage imageNamed:@"jiang_f"];
    self.endImage.image = [UIImage imageNamed:@"jiang_g"];

    self.getTimeLabel.text = [self getStringFromNunber:self.model.awardingDate];
    self.getGoodLabel.textColor = COLOR_TEXT_CONTENT;
    self.getTimeLabel.textColor = COLOR_TEXT_DATE;
//    self.getTimeLabel.hidden = NO;
    
    self.confirmButton.hidden = NO;
    self.confirmLabel.textColor = COLOR_BUTTON_ORANGE;
    [self.confirmButton bk_whenTapped:^{
        [self confirmationOfAddress];
    }];
    
    self.sendTime.hidden = YES;
    self.sendLabel.textColor = COLOR_TEXT_DATE;
    
    self.confirmGoodButton.hidden = YES;
    self.confirmGoodLabel.textColor = COLOR_TEXT_DATE;
    self.confirmGoodTime.hidden = YES;
    
    self.endButton.hidden = YES;
    self.endLabel.textColor = COLOR_TEXT_DATE;
    self.endTime.hidden = YES;
    
}

/**
 *  已填写收货地址还未发货
 */
- (void)addressHaveFillIn {
    
    self.getGoodImage.image = [UIImage imageNamed:@"jiang_b"];
    self.confirmImage.image = [UIImage imageNamed:@"jiang_c"];
    self.sendImage.image = [UIImage imageNamed:@"jiang_a"];
    self.confirmGoodImage.image = [UIImage imageNamed:@"jiang_f"];
    self.endImage.image = [UIImage imageNamed:@"jiang_g"];
    

    self.getTimeLabel.text = [self getStringFromNunber:self.model.awardingDate];
    self.getTimeLabel.hidden = NO;
    self.getGoodLabel.textColor = COLOR_TEXT_CONTENT;
    self.getTimeLabel.textColor = COLOR_TEXT_DATE;
    
    self.confirmButton.hidden = YES;
    self.confirmTime.hidden = NO;
    self.confirmLabel.textColor = COLOR_TEXT_CONTENT;
    self.confirmTime.text = [self getStringFromNunber:self.model.confirmAddressTime];
    self.confirmTime.textColor = COLOR_TEXT_DATE;
    
    self.sendTime.hidden = NO;
    self.sendTime.text = @"等待发货";
    self.sendTime.textColor = COLOR_BUTTON_ORANGE;
    self.sendLabel.textColor = COLOR_BUTTON_ORANGE;
    
    self.confirmGoodButton.hidden = YES;
    self.confirmGoodLabel.textColor = COLOR_TEXT_DATE;
    self.confirmGoodTime.hidden = YES;
    
    self.endButton.hidden = YES;
    self.endLabel.textColor = COLOR_TEXT_DATE;
    self.endTime.hidden = YES;
    
    [self _initAddressCell];
}


/**
 *  已填写收货地址已发货
 */
- (void)addressHaveFillInAndSendOutGoods {
    
    self.getGoodImage.image = [UIImage imageNamed:@"jiang_b"];
    self.confirmImage.image = [UIImage imageNamed:@"jiang_c"];
    self.sendImage.image = [UIImage imageNamed:@"jiang_c"];
    self.confirmGoodImage.image = [UIImage imageNamed:@"jiang_a"];
    self.endImage.image = [UIImage imageNamed:@"jiang_g"];
    

    self.getTimeLabel.text = [self getStringFromNunber:self.model.awardingDate];
    self.getTimeLabel.hidden = NO;
    self.getGoodLabel.textColor = COLOR_TEXT_CONTENT;
    self.getTimeLabel.textColor = COLOR_TEXT_DATE;
    
    self.confirmButton.hidden = YES;
    self.confirmTime.hidden = NO;
    self.confirmLabel.textColor = COLOR_TEXT_CONTENT;
    self.confirmTime.text = [self getStringFromNunber:self.model.confirmAddressTime];
    self.confirmTime.textColor = COLOR_TEXT_DATE;
    
    self.sendTime.hidden = NO;
    self.sendTime.text = [self getStringFromNunber:self.model.deliveryTime];
    self.sendTime.textColor = COLOR_TEXT_DATE;
    self.sendLabel.textColor = COLOR_TEXT_CONTENT;
    
    self.confirmGoodButton.hidden = NO;
    [self.confirmGoodButton bk_whenTapped:^{
        [self confirmationOfGoodsReceipt];
    }];
    self.confirmGoodLabel.textColor = COLOR_BUTTON_ORANGE;
    self.confirmGoodTime.hidden = YES;
    
    self.endButton.hidden = YES;
    self.endLabel.textColor = COLOR_TEXT_DATE;
    self.endTime.hidden = YES;
    
    [self _initAddressCell];
}

/**
 *  已确认收货收货，未晒单
 */

- (void)successGetGoodsAndGoToShare {
    
    self.getGoodImage.image = [UIImage imageNamed:@"jiang_b"];
    self.confirmImage.image = [UIImage imageNamed:@"jiang_c"];
    self.sendImage.image = [UIImage imageNamed:@"jiang_c"];
    self.confirmGoodImage.image = [UIImage imageNamed:@"jiang_c"];
    self.endImage.image = [UIImage imageNamed:@"jiang_e"];
    

    self.getTimeLabel.text = [self getStringFromNunber:self.model.awardingDate];
    self.getTimeLabel.hidden = NO;
    self.getGoodLabel.textColor = COLOR_TEXT_CONTENT;
    self.getTimeLabel.textColor = COLOR_TEXT_DATE;
    
    self.confirmButton.hidden = YES;
    self.confirmTime.hidden = NO;
    self.confirmLabel.textColor = COLOR_TEXT_CONTENT;
    self.confirmTime.text = [self getStringFromNunber:self.model.confirmAddressTime];
    self.confirmTime.textColor = COLOR_TEXT_DATE;
    
    self.sendTime.hidden = NO;
    self.sendTime.text = [self getStringFromNunber:self.model.deliveryTime];
    self.sendTime.textColor = COLOR_TEXT_DATE;
    self.sendLabel.textColor = COLOR_TEXT_CONTENT;
    
    self.confirmGoodButton.hidden = YES;
    self.confirmGoodLabel.textColor = COLOR_TEXT_CONTENT;
    self.confirmGoodTime.textColor = COLOR_TEXT_DATE;
    self.confirmGoodTime.text = [self getStringFromNunber:self.model.recieveGoodsTime];
    self.confirmGoodTime.hidden = NO;
    
    self.endButton.hidden = NO;
    [self.endButton bk_whenTapped:^{
        [self goToNewShare];
    }];
    self.endLabel.textColor = COLOR_BUTTON_ORANGE;
    self.endTime.hidden = YES;
    
    [self _initAddressCell];
}


/**
 *  已经晒单过了
 */
- (void)shareSuccess {
    
    self.getGoodImage.image = [UIImage imageNamed:@"jiang_b"];
    self.confirmImage.image = [UIImage imageNamed:@"jiang_c"];
    self.sendImage.image = [UIImage imageNamed:@"jiang_c"];
    self.confirmGoodImage.image = [UIImage imageNamed:@"jiang_c"];
    self.endImage.image = [UIImage imageNamed:@"jiang_e"];
    

    self.getTimeLabel.text = [self getStringFromNunber:self.model.awardingDate];
    self.getTimeLabel.hidden = NO;
    self.getGoodLabel.textColor = COLOR_TEXT_CONTENT;
    self.getTimeLabel.textColor = COLOR_TEXT_DATE;
    
    self.confirmButton.hidden = YES;
    self.confirmTime.hidden = NO;
    self.confirmLabel.textColor = COLOR_TEXT_CONTENT;
    self.confirmTime.text = [self getStringFromNunber:self.model.confirmAddressTime];
    self.confirmTime.textColor = COLOR_TEXT_DATE;
    
    self.sendTime.hidden = NO;
    self.sendTime.text = [self getStringFromNunber:self.model.deliveryTime];
    self.sendTime.textColor = COLOR_TEXT_DATE;
    self.sendLabel.textColor = COLOR_TEXT_CONTENT;
    
    self.confirmGoodButton.hidden = YES;
    self.confirmGoodLabel.textColor = COLOR_TEXT_CONTENT;
    self.confirmGoodTime.textColor = COLOR_TEXT_DATE;
    self.confirmGoodTime.text = [self getStringFromNunber:self.model.recieveGoodsTime];
    self.confirmGoodTime.hidden = NO;
    
    self.endButton.hidden = YES;
    self.endLabel.textColor = COLOR_BUTTON_ORANGE;
    self.endTime.textColor = COLOR_BUTTON_ORANGE;
    self.endTime.hidden = NO;
    self.endTime.text = @"已签收";
    
    [self _initAddressCell];
}

/**
 *  设置商品信息
 *
 *  @param winningModel winningModel description
 */
- (void)_initWinningModel {
    
    [_Image sd_setImageWithURL:[NSURL URLWithString:self.winningModel.defaultPictureUrl] placeholderImage:nil options:SDWebImageRetryFailed completed:nil];
    _goodName.text = self.winningModel.title;
    _joinId.text = [NSString stringWithFormat:@"参与期号：%@", self.winningModel.issueId];
    _person.text = [NSString stringWithFormat:@"总需：%@", self.winningModel.toAmount];
    _luckyNum.text = [self.winningModel.luckyNumber stringValue];
    _joinCount.text = [NSString stringWithFormat:@"本期参与：%@人次", self.winningModel.amount];
    _time.text = [NSString stringWithFormat:@"揭晓时间:%@", [self getStringFromNunber:self.winningModel.awardingDate]];
}

- (void)_initAddressCell {
    
    self.name.text = self.model.receiver;
    self.phone.text = [self.model.mobile stringValue];
    self.address.text = self.model.details;
    
}


/**
 *  去地址列表选择收货地址;
 *
 *  @param model
 */
- (void)goToAddressListChoose {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AdressController *address = [story instantiateViewControllerWithIdentifier:@"AdressController"];
    address.winningModel = self.winningModel;
    address.tpye = 2;
    [self.navigationController pushViewController:address animated:YES];
    
}


/**
 *  使用默认地址确认收货地址
 */
- (void)useDefaultAddress {
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
    AdressModel *address = [NSKeyedUnarchiver unarchiveObjectWithFile:fileNameAdd];
    
    if (address != nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"deliveryId"] = self.winningModel.deliveryId;
        dic[@"receiver"] = address.receiver;
        dic[@"mobile"] = address.mobile;
        dic[@"details"] = address.details;
        
        [UserLoginTool loginRequestGet:@"addLotteryReceiverInfo" parame:dic success:^(id json) {
            LWLog(@"%@",json);
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
                [self getWinningDeliveryModel];
            }
        } failure:^(NSError *error) {
            LWLog(@"%@", error);
        }];
        
    }else {
        [SVProgressHUD showErrorWithStatus:@"请设置默认地址"];
    }
    
}

/**
 *  确认收货
 */
- (void)confirmationOfGoods {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"deliveryId"] = self.winningModel.deliveryId;
    
    [UserLoginTool loginRequestGet:@"confirmReceipt" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"确认收货成功"];
            [self getWinningDeliveryModel];
            
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
}


/**
 *  去晒单
 */
- (void)goToNewShare {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewShareController *share = [story instantiateViewControllerWithIdentifier:@"NewShareController"];
    share.WinningModel = self.winningModel;
    [self.navigationController pushViewController:share animated:YES];
    
}


/**
 *  确认收货提示
 */
- (void)confirmationOfGoodsReceipt {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认收货" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"还没收到", nil];
    alert.tag = 2;
    [alert show];
}


/**
 *  确认收货地址提示
 */
- (void)confirmationOfAddress {
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
    AdressModel *address = [NSKeyedUnarchiver unarchiveObjectWithFile:fileNameAdd];
    
    if (address.receiver.length != 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请确认收货地址" message:nil delegate:self cancelButtonTitle:@"使用默认地址" otherButtonTitles:@"使用其他地址", nil];
        alert.tag = 1;
        [alert show];
    }else {
        [SVProgressHUD showErrorWithStatus:@"请使用默认地址"];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (alertView.tag) {
        case 1:
        {
            
            if (buttonIndex == 1) {
                [self goToAddressListChoose];
            }else {
                [self useDefaultAddress];
            }
            
            break;
        }
        case 2:
        {
            if (buttonIndex == 0) {
                [self confirmationOfGoods];
            }
            
            break;
        }
        default:
            break;
    }
    
}





- (NSString *)getStringFromNunber:(NSNumber *) num{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[num doubleValue] / 1000];
    return [formatter stringFromDate:date];
}


@end
