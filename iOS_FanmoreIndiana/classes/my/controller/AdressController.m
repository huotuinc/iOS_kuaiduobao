//
//  AdressController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/18.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "AdressController.h"
#import "AddressCell.h"
#import "AddressModel.h"
#import "AddAddressController.h"
#import <UIBarButtonItem+BlocksKit.h>

@interface AdressController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *addressList;

@end

@implementation AdressController

static NSString *addressIdentify = @"addressIdnetify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addressList = [NSMutableArray array];
    
    self.title = @"地址列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"添加地址" style:UIBarButtonItemStylePlain handler:^(id sender) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AddAddressController *add = [story instantiateViewControllerWithIdentifier:@"AddAddressController"];
        add.temp = 1;
        [self.navigationController pushViewController:add animated:YES];
    }];
    
//    self.tableView.editing = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellReuseIdentifier:addressIdentify];
    [self.tableView removeSpaces];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getNewAddressList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getNewAddressList {
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [UserLoginTool loginRequestGet:@"getMyAddressList" parame:nil success:^(id json) {
        [SVProgressHUD dismiss];
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            [self.addressList removeAllObjects];
            if (![json[@"resultData"] isKindOfClass:[NSNull class]]) {
                NSArray *array = [AddressModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
                [self.addressList addObjectsFromArray:array];
                [self.tableView reloadData];
            }
        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }

    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        LWLog(@"%@",error);
    }];
}

#pragma mark -tableView 
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _addressList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressIdentify forIndexPath:indexPath];
    cell.model = _addressList[indexPath.row];
    [cell.exchanage bk_whenTapped:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AddAddressController *add = [story instantiateViewControllerWithIdentifier:@"AddAddressController"];
        add.temp = 0;
        add.model = _addressList[indexPath.row];
        [self.navigationController pushViewController:add animated:YES];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
