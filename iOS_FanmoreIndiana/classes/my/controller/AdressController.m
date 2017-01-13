//
//  AdressController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/18.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "AdressController.h"
#import "AddressCell.h"
#import "AdressModel.h"
#import "AddAddressController.h"
#import <UIBarButtonItem+BlocksKit.h>

@interface AdressController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *addressList;

@property (nonatomic, assign) NSInteger selected;


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
    
    if (_tpye == 1) {
        self.tableView.editing = NO;
    }else if (_tpye == 2) {
        self.tableView.editing = YES;
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellReuseIdentifier:addressIdentify];
    [self.tableView removeSpaces];
    
    [self.tableView layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getNewAddressList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///**
// *  取出默认地址保存本地
// */
//- (void)saveDefaultAddress {
//    for (AdressModel *address in _addressList) {
//        if (address.defaultAddress) {
//            NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory®, NSUserDomainMask, YES) lastObject];
//            NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
//            [NSKeyedArchiver archiveRootObject:address toFile:fileNameAdd];
//            
//        }
//    }
//}

- (void)getNewAddressList {
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [UserLoginTool loginRequestGet:@"getMyAddressList" parame:nil success:^(id json) {
        [SVProgressHUD dismiss];
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            [self.addressList removeAllObjects];
            if (![json[@"resultData"] isKindOfClass:[NSNull class]]) {
                NSArray *array = [AdressModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
                [self.addressList addObjectsFromArray:array];
                [self.tableView reloadData];                                                                                                      
                
                
                [self getDefaultAddress];
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
    
    if (_tpye == 1) {
        return UITableViewCellEditingStyleDelete;
    }else if (_tpye == 2){
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleNone;
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
    if (cell.model.defaultAddress) {
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
        [NSKeyedArchiver archiveRootObject:cell.model toFile:fileNameAdd];
    }
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
    if (_tpye == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (_tpye == 2) {
        [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selected inSection:0] animated:YES];
        AddressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.selected = indexPath.row;
        AdressModel *model = self.addressList[indexPath.row];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"deliveryId"] = self.winningModel.deliveryId;
        dic[@"receiver"] = model.receiver;
        dic[@"mobile"] = model.mobile;
        dic[@"details"] = cell.address.text;
        
        [UserLoginTool loginRequestGet:@"addLotteryReceiverInfo" parame:dic success:^(id json) {
            LWLog(@"%@",json);
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            LWLog(@"%@", error);
        }];
        
        
    }
}



- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AdressModel *model = self.addressList[indexPath.row];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"addressId"] = model.addressId;
        
        [UserLoginTool loginRequestPostWithFile:@"deleteAddress" parame:dic success:^(id json) {
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
                [self.addressList removeObject:model];
                [self.tableView reloadData];
                
                [self getDefaultAddress];
            }
        } failure:^(NSError *error) {
            LWLog(@"%@",error);
        } withFileKey:nil];
    }
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)getDefaultAddress {
    if (_addressList.count != 0) {
        
        for (int i = 0; i < _addressList.count; i++) {
            AdressModel *model = _addressList[i];
            if (model.defaultAddress) {
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
                [NSKeyedArchiver archiveRootObject:model toFile:fileNameAdd];
                return;
            }else {
                AdressModel *temp = [[AdressModel alloc] init];
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
                [NSKeyedArchiver archiveRootObject:temp toFile:fileNameAdd];
            }
        }
    }else {
        AdressModel *temp = [[AdressModel alloc] init];
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
        [NSKeyedArchiver archiveRootObject:temp toFile:fileNameAdd];
    }
}

@end
