//
//  PayController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/16.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "PayController.h"
#import "PayModel.h"
@interface PayController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, assign) NSInteger selectPay;

@property (nonatomic, strong) UIButton *selectedPayButton;



@end

@implementation PayController

static NSString *payIdentify = @"payIdentifty";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:payIdentify];
    self.tableView.editing = YES;
    self.tableView.scrollEnabled = NO;
    
    self.verifyPay.layer.cornerRadius = 5;
    
    self.selectPay = 0;
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    [self _initPayButtons];

    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_initPayButtons {
    
    self.pay20.layer.borderColor = [UIColor redColor].CGColor;
    self.pay20.layer.borderWidth = 1;
    [self.pay20 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.selectedPayButton = self.pay20; 
    [self.pay20 bk_whenTapped:^{
        [self.pay20 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.pay20.layer.borderColor = [UIColor redColor].CGColor;
        [self.payOther resignFirstResponder];
        self.payOther.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
        self.payOther.textColor = [UIColor colorWithWhite:0.859 alpha:1.000];
        if (self.selectedPayButton != nil) {
            self.selectedPayButton.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
            [self.selectedPayButton setTitleColor:[UIColor colorWithWhite:0.859 alpha:1] forState:UIControlStateNormal];
        }
        self.selectedPayButton = self.pay20;
    }];
    
    
    self.pay50.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
    self.pay50.layer.borderWidth = 1;
    [self.pay50 bk_whenTapped:^{
        [self.pay50 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.pay50.layer.borderColor = [UIColor redColor].CGColor;
        [self.payOther resignFirstResponder];
        self.payOther.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
        self.payOther.textColor = [UIColor colorWithWhite:0.859 alpha:1.000];
        if (self.selectedPayButton != nil) {
            self.selectedPayButton.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
            [self.selectedPayButton setTitleColor:[UIColor colorWithWhite:0.859 alpha:1] forState:UIControlStateNormal];
        }
        self.selectedPayButton = self.pay50;
    }];
    
    self.pay100.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
    self.pay100.layer.borderWidth = 1;
    [self.pay100 bk_whenTapped:^{
        [self.pay100 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.pay100.layer.borderColor = [UIColor redColor].CGColor;
        [self.payOther resignFirstResponder];
        self.payOther.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
        self.payOther.textColor = [UIColor colorWithWhite:0.859 alpha:1.000];
        if (self.selectedPayButton != nil) {
            self.selectedPayButton.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
            [self.selectedPayButton setTitleColor:[UIColor colorWithWhite:0.859 alpha:1] forState:UIControlStateNormal];
        }
        self.selectedPayButton = self.pay100;
    }];
    
    self.pay200.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
    self.pay200.layer.borderWidth = 1;
    [self.pay200 bk_whenTapped:^{
        [self.pay200 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.pay200.layer.borderColor = [UIColor redColor].CGColor;
        [self.payOther resignFirstResponder];
        self.payOther.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
        self.payOther.textColor = [UIColor colorWithWhite:0.859 alpha:1.000];
        if (self.selectedPayButton != nil) {
            self.selectedPayButton.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
            [self.selectedPayButton setTitleColor:[UIColor colorWithWhite:0.859 alpha:1] forState:UIControlStateNormal];
        }
        self.selectedPayButton = self.pay200;
    }];
    
    self.pay500.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
    self.pay500.layer.borderWidth = 1;
    [self.pay500 bk_whenTapped:^{
        [self.pay500 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.pay500.layer.borderColor = [UIColor redColor].CGColor;
        [self.payOther resignFirstResponder];
        self.payOther.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
        self.payOther.textColor = [UIColor colorWithWhite:0.859 alpha:1.000];
        if (self.selectedPayButton != nil) {
            self.selectedPayButton.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
            [self.selectedPayButton setTitleColor:[UIColor colorWithWhite:0.859 alpha:1] forState:UIControlStateNormal];
        }
        self.selectedPayButton = self.pay500;
    }];
    
    self.payOther.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
    self.payOther.layer.borderWidth = 1;
    self.payOther.delegate = self;
    
    
}

#pragma mark textField 
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.payOther.layer.borderColor = [UIColor redColor].CGColor;
    self.payOther.textColor = [UIColor redColor];
    self.selectedPayButton.layer.borderColor = [UIColor colorWithWhite:0.859 alpha:1.000].CGColor;
    [self.selectedPayButton setTitleColor:[UIColor colorWithWhite:0.859 alpha:1] forState:UIControlStateNormal];
    self.selectedPayButton = nil;
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.payOther resignFirstResponder];
}


#pragma mark tabViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:NO];
        self.selectPay = indexPath.row;
    }else {
        [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO];
        self.selectPay = indexPath.row;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.selectPay) {
        self.selectPay = 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payIdentify forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"微信支付";
    }else {
        cell.textLabel.text = @"支付宝";
    }
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (IBAction)verifyPayAction:(id)sender {
    
    
    if (self.selectPay != 100) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        if (self.selectedPayButton) {
            dic[@"money"] = self.selectedPayButton.titleLabel.text;
        }else {
            dic[@"money"] = self.payOther.text;
        }
        dic[@"payType"] = @(self.selectPay);
        
        [UserLoginTool loginRequestGet:@"putMoney" parame:dic success:^(id json) {
            LWLog(@"%@",json);
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                PayModel *payModel = [PayModel mj_objectWithKeyValues:json[@"resultData"][@"data"]];
                
            }
        } failure:^(NSError *error) {
            LWLog(@"%@",error);
        }];
    }else {
        [SVProgressHUD showErrorWithStatus:@"请选择支付方式"];
    }
    
    
    
}
@end
