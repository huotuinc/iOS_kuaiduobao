//
//  ForgetSecondController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetSecondController : UIViewController

@property (nonatomic, strong) NSString *userName;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *security;
@property (weak, nonatomic) IBOutlet UILabel *countCode;
@property (weak, nonatomic) IBOutlet UIButton *next;


- (IBAction)doNext:(id)sender;

@end
