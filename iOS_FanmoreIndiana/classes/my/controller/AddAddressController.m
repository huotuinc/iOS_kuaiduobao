//
//  AddAddressController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/18.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "AddAddressController.h"

@interface AddAddressController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *provinceArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *districtArray;

@end

@implementation AddAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 216, KScreenWidth, 216)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
    
}

- (void)_initPickerData {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
