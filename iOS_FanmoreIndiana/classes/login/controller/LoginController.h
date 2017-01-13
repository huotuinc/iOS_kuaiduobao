//
//  LoginController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/19.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol logVCdelegate <NSObject>

-(void)tableViewReloadData;


@end

@interface LoginController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *forgot;

@property (weak, nonatomic) IBOutlet UIButton *login;

@property (strong, nonatomic) IBOutlet UIButton *phoneRegister;

@property (weak, nonatomic) IBOutlet UIButton *weixinLogin;

@property (weak, nonatomic) IBOutlet UIButton *qqLogin;

- (IBAction)userNameAndPasswordLogin:(id)sender;

- (IBAction)loginWithWeixin:(id)sender;

- (IBAction)loginWithQQ:(id)sender;
@property (nonatomic, copy) NSString *cartsString;
@property (nonatomic, assign) NSInteger postData;//0不 1去

@property (nonatomic,weak)id<logVCdelegate>logDelegate;

@property (nonatomic, assign) BOOL isFromMall;


@end
