//
//  AreaPickerView.m
//  AreaPickerView
//
//  Created by zhuochenming on 16-3-11.
//  Copyright (c) 2016年 zhuochenming. All rights reserved.
//

#import "AreaPickerView.h"

@interface AreaPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

//省份数组
@property (nonatomic, strong) NSArray *provinces;

//城市数组
@property (nonatomic, strong) NSArray *cities;

//地区数组
@property (nonatomic, strong) NSMutableArray *areas;

//区域ID数组
@property (nonatomic, strong) NSMutableArray *codeArray;

//区域ID
@property (nonatomic, strong) NSNumber *areaID;

@property (nonatomic, strong) NSString *cityName;

@property (nonatomic, strong) UIPickerView *locatePicker;

@end

@implementation AreaPickerView

- (AreaLocation *)locate {
    if (_locate == nil) {
        _locate = [[AreaLocation alloc] init];
    }
    return _locate;
}

#pragma mark - 初始化
- (id)initWithDelegate:(id<AreaPickerDelegate>)delegate {
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
        self.frame = CGRectMake(0, 0, width, height);
        
        _locatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, height - 216, width, 216)];
        _locatePicker.backgroundColor = [UIColor whiteColor];
        _locatePicker.dataSource = self;
        _locatePicker.delegate = self;
        [self addSubview:_locatePicker];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, height - CGRectGetHeight(_locatePicker.frame) - 40, width, 40)];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"   取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPicker)];
        UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定   " style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
        
        toolbar.items = @[leftItem, centerSpace, rightItem];
        
        [self addSubview:toolbar];
        
        //加载数据
        self.provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areaCode.plist" ofType:nil]];
        self.cities = [[self.provinces objectAtIndex:0] objectForKey:@"city"];
        self.areas = [NSMutableArray array];
        self.codeArray = [NSMutableArray array];
        
        NSDictionary *areaDic = [[self.cities objectAtIndex:0] objectForKey:@"area"];
        
        for (NSDictionary *nameDic in areaDic) {
            [self.areas addObject:nameDic[@"name"]];
            [self.codeArray addObject:nameDic[@"id"]];
        }
        
        self.locate.province = [[self.provinces objectAtIndex:0] objectForKey:@"name"];
        self.locate.city = [[self.cities objectAtIndex:0] objectForKey:@"name"];
        if (self.areas.count > 0) {
            self.locate.area = [self.areas objectAtIndex:0];
            self.areaID = [self.codeArray objectAtIndex:0];
        } else {
            self.locate.area = @"";
        }
        //代理
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - pickerView代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [self.provinces count];
            break;
        case 1:
            return [self.cities count];
            break;
        case 2:
            return [self.areas count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [[self.provinces objectAtIndex:row] objectForKey:@"name"];
            break;
        case 1:
            return [[self.cities objectAtIndex:row] objectForKey:@"name"];
            break;
        case 2:
            if ([self.areas count] > 0) {
                self.areaID = [self.codeArray objectAtIndex:row];
                return [self.areas objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
        {
            [self.areas removeAllObjects];
            [self.codeArray removeAllObjects];
            
            self.cities = [[self.provinces objectAtIndex:row] objectForKey:@"city"];
            NSDictionary *areaDic = [[self.cities objectAtIndex:0] objectForKey:@"area"];
            for (NSDictionary *nameDic in areaDic) {
                [self.areas addObject:nameDic[@"name"]];
                [self.codeArray addObject:nameDic[@"id"]];
            }

            self.locate.province = [[self.provinces objectAtIndex:row] objectForKey:@"name"];
            self.locate.city = [[self.cities objectAtIndex:0] objectForKey:@"name"];
            
            if ([self.areas count] > 0) {
                self.areaID = [self.codeArray objectAtIndex:0];
                self.locate.area = [self.areas objectAtIndex:0];
            } else {
                self.locate.area = @"";
            }
            
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];

            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            
            break;
        }
        case 1:
        {
            [self.areas removeAllObjects];
            [self.codeArray removeAllObjects];
            
            NSDictionary *areaDic = [[self.cities objectAtIndex:row] objectForKey:@"area"];
            for (NSDictionary *nameDic in areaDic) {
                [self.areas addObject:nameDic[@"name"]];
                [self.codeArray addObject:nameDic[@"id"]];
            }
            
            self.locate.city = [[self.cities objectAtIndex:row] objectForKey:@"name"];
            if ([self.areas count] > 0) {
                self.areaID = [self.codeArray objectAtIndex:0];
                self.locate.area = [self.areas objectAtIndex:0];
            } else {
                self.locate.area = @"";
            }
            
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
  
            break;
        }
        case 2:
            if ([self.areas count] > 0) {
                self.areaID = [self.codeArray objectAtIndex:row];
                self.locate.area = [self.areas objectAtIndex:row];
            } else {
                self.locate.area = @"";
            }
            break;
        default:
            break;
    }
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:self];
    }
}

#pragma mark - 展示
- (void)showInView:(UIView *)view {
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    self.alpha = 0;
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
    
}

#pragma mark - 确定
- (void)doneClick {
    if ([self.delegate respondsToSelector:@selector(pickerViewSelectAreaOfCode:)]) {
        [self.delegate pickerViewSelectAreaOfCode:self.locate];
    }
    [self cancelPicker];
}

#pragma mark - 取消
- (void)cancelPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}


#pragma mark - 设置位置 
- (void)setSelectedLocate:(AreaLocation *)selectedLocate {
    _selectedLocate = selectedLocate;
    for (int i = 0; i < self.provinces.count; i++) {
        //判断是哪个省
        if ([_selectedLocate.province isEqualToString:[[self.provinces objectAtIndex:i] objectForKey:@"name"]]) {
            //选中省同时写入数据
            [_locatePicker selectRow:i inComponent:0 animated:YES];
            
            self.locate.province = [[self.provinces objectAtIndex:i] objectForKey:@"name"];
            
            //拉取城市列表重新加载
            self.cities = [[self.provinces objectAtIndex:i] objectForKey:@"city"];
            [_locatePicker reloadComponent:1];
            for (int j = 0; j < self.cities.count; j++) {
                //判断并选中城市
                if ([_selectedLocate.city isEqualToString:[[self.cities objectAtIndex:j] objectForKey:@"name"]] ) {
                    
                    [_locatePicker selectRow:j inComponent:1 animated:YES];
                    
                    self.locate.city = [[self.cities objectAtIndex:j] objectForKey:@"name"];

                    
                    NSDictionary *areaDic = [[self.cities objectAtIndex:j] objectForKey:@"area"];
                    
                    [self.areas removeAllObjects];
                    [self.codeArray removeAllObjects];
                    
                    for (NSDictionary *nameDic in areaDic) {
                        [self.areas addObject:nameDic[@"name"]];
                        [self.codeArray addObject:nameDic[@"id"]];
                    }
                    [_locatePicker reloadComponent:2];
                    
                    for (int k = 0; k < self.areas.count; k++) {
                        if ([_selectedLocate.area isEqualToString:[self.areas objectAtIndex:k]]) {
                            [_locatePicker selectRow:k inComponent:2 animated:YES];
                            if ([self.areas count] > 0) {
                                self.areaID = [self.codeArray objectAtIndex:k];
                                self.locate.area = [self.areas objectAtIndex:k];
                            } else {
                                self.locate.area = @"";
                            }
                            
                            break;
                        }
                    }
                    
                    
                }
            }
//            self.locate.province = [[self.provinces objectAtIndex:i] objectForKey:@"name"];
//            self.locate.city = [[self.cities objectAtIndex:0] objectForKey:@"name"];
//            
//            if ([self.areas count] > 0) {
//                self.areaID = [self.codeArray objectAtIndex:0];
//                self.locate.area = [self.areas objectAtIndex:0];
//            } else {
//                self.locate.area = @"";
//            }
//            
//            [_locatePicker reloadComponent:1];
//            [_locatePicker reloadComponent:2];
            
            break;
        }
    }
}

@end
