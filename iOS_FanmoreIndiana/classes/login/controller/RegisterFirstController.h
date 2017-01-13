//
//  RegisterFirstController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/21.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterFirstController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *security;
@property (weak, nonatomic) IBOutlet UILabel *countdown;
@property (weak, nonatomic) IBOutlet UIButton *next;

- (void)getSecurtityCode;

- (IBAction)goNext:(id)sender;

@end
