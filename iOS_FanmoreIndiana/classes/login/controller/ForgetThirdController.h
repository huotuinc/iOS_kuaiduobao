//
//  ForgetThirdController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetThirdController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passwrod;
@property (weak, nonatomic) IBOutlet UIButton *next;

@property (nonatomic, strong) NSString *userName;
- (IBAction)resetPassword:(id)sender;

@end
