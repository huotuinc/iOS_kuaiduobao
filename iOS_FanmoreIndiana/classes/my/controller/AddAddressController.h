//
//  AddAddressController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/18.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAddressController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *personName;
@property (weak, nonatomic) IBOutlet UITextField *personIphone;
@property (weak, nonatomic) IBOutlet UITextView *detailAddress;
@property (weak, nonatomic) IBOutlet UISwitch *defaultAddress;
@property (nonatomic, strong) UIPickerView *pickerView;

@end
