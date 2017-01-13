//
//  ChangePasswordFromOldController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/3/11.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordFromOldController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *oldBgView;
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UISwitch *oldSwich;

@property (weak, nonatomic) IBOutlet UIView *BgView;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UISwitch *Swich;
@property (weak, nonatomic) IBOutlet UIButton *resetPasswordButton;
- (IBAction)resetPasswordAction:(id)sender;

@end
