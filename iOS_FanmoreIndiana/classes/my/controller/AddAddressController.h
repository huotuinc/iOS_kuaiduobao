//  新增地址
//  AddAddressController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/18.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface AddAddressController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *personName;
@property (weak, nonatomic) IBOutlet UITextField *personIphone;
@property (weak, nonatomic) IBOutlet UITextView *detailAddress;
@property (weak, nonatomic) IBOutlet UISwitch *defaultAddress;

//1是增加地址 0修改地址
@property (nonatomic, assign) NSInteger temp;

@property (nonatomic, strong) AddressModel *model;

@end
