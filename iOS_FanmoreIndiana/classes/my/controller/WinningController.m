//
//  WinningController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/31.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "WinningController.h"
#import "WinningCell.h"
#import "WinningModel.h"
#import "AdressController.h"
#import "WinningConfirmController.h"
#import "NewShareController.h"

@interface WinningController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *winningArray;

@property (nonatomic, strong) WinningModel *selectModel;

@end

@implementation WinningController

static NSString *winningIdentify = @"winningIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"中奖记录";
    
    self.winningArray = [NSMutableArray array];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.snatch.layer.cornerRadius = 5;
    self.tabBarController.tabBar.hidden = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    [self.tableView registerNib:[UINib nibWithNibName:@"WinningCell" bundle:nil] forCellReuseIdentifier:winningIdentify];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView removeSpaces];
    [self setupRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getNewList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -tableView 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _winningArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 207;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WinningCell *cell = [tableView dequeueReusableCellWithIdentifier:winningIdentify forIndexPath:indexPath];
    cell.model = self.winningArray[indexPath.row];
    cell.confirm.tag = indexPath.row + 10000;
    
    switch (cell.model.deliveryStatus) {
        case 0:
        {
            cell.confirm.userInteractionEnabled = YES;
            [cell.confirm setTitle:@"确认收货地址" forState:UIControlStateNormal];
            [cell.confirm setBackgroundColor:[UIColor colorWithRed:0.933 green:0.384 blue:0.090 alpha:1.000]];
            [cell.confirm addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case 1:
        {
            //已取人收货地址
            cell.confirm.userInteractionEnabled = NO;
            [cell.confirm setTitle:@"等待奖品发放" forState:UIControlStateNormal];
            [cell.confirm setBackgroundColor:[UIColor colorWithWhite:0.702 alpha:1.000]];
            break;
        }
        case 2:
        {
            //已取人收货地址
            cell.confirm.userInteractionEnabled = YES;
            [cell.confirm setTitle:@"确认收货" forState:UIControlStateNormal];
            [cell.confirm setBackgroundColor:[UIColor colorWithRed:0.933 green:0.384 blue:0.090 alpha:1.000]];
            [cell.confirm addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case 5:
        {
            cell.confirm.userInteractionEnabled = YES;
            [cell.confirm setTitle:@"去晒单" forState:UIControlStateNormal];
            [cell.confirm setBackgroundColor:[UIColor colorWithRed:0.933 green:0.384 blue:0.090 alpha:1.000]];
            [cell.confirm addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case 6:
        {
            cell.confirm.userInteractionEnabled = NO;
            [cell.confirm setTitle:@"已晒单" forState:UIControlStateNormal];
            [cell.confirm setBackgroundColor:[UIColor colorWithWhite:0.702 alpha:1.000]];
            break;
        }
        default:
            break;
    }
    

    return  cell;
}

- (void)confirmAction:(UIButton *) button {
    WinningModel *model = self.winningArray[button.tag - 10000];
    
    
    switch (model.deliveryStatus) {
        case 0:
        {
            
            self.selectModel = model;
            [self confirmationOfAddress];

            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            //已取人收货地址

            self.selectModel = model;
            [self confirmationOfGoodsReceipt];
            break;
        }
        case 5:
        {

            self.selectModel = model;
            [self goToNewShare];
            break;
        }
        case 6:
        {
            break;
        }
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WinningConfirmController *confirm = [story instantiateViewControllerWithIdentifier:@"WinningConfirmController"];
    WinningModel *model = self.winningArray[indexPath.row];
    confirm.winningModel = model;
    [self.navigationController pushViewController:confirm animated:YES];
}

- (void)hiddenNoneImageAndLabels {
    self.winImage.hidden = YES;
    self.showLabel.hidden = YES;
    self.snatch.hidden = YES;
    self.tableView.hidden = NO;
}

- (void)showNoneImageAndLabels {
    self.winImage.hidden = NO;
    self.showLabel.hidden = NO;
    self.snatch.hidden = NO;
    self.tableView.hidden = YES;
}

- (IBAction)goHomeController:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CannelLoginFailure object:nil];
    
}


#pragma mark 网络请求

- (void)getNewList {
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    dic[@"lastTime"] = @0;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyLotteryList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [self.winningArray removeAllObjects];
        [_tableView.mj_header endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [WinningModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.winningArray addObjectsFromArray:temp];
            [self.tableView reloadData];
        }
        if (self.winningArray.count == 0) {
            [self showNoneImageAndLabels];
        }else {
            [self hiddenNoneImageAndLabels];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [_tableView.mj_header endRefreshing];
        LWLog(@"%@",error);
    }];
    
}

- (void)getMoreList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    WinningModel *model = [self.winningArray lastObject];
    dic[@"lastTime"] = model.time;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyLotteryList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_footer endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [WinningModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.winningArray addObjectsFromArray:temp];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [_tableView.mj_footer endRefreshing];
        LWLog(@"%@",error);
    }];
}


- (void)setupRefresh
{
    
    MJRefreshNormalHeader * headRe = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewList)];
    _tableView.mj_header = headRe;
    
    MJRefreshBackNormalFooter * Footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreList)];
    _tableView.mj_footer = Footer;
    
}


/**
 *  去地址列表选择收货地址;
 *
 *  @param model
 */
- (void)goToAddressListChoose:(WinningModel *) model {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AdressController *address = [story instantiateViewControllerWithIdentifier:@"AdressController"];
    address.winningModel = self.selectModel;
    address.tpye = 2;
    [self.navigationController pushViewController:address animated:YES];
    
}


/**
 *  使用默认地址确认收货地址
 */
- (void)useDefaultAddress {
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
    AdressModel *address = [NSKeyedUnarchiver unarchiveObjectWithFile:fileNameAdd];
    
    if (address.receiver.length != 0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"deliveryId"] = self.selectModel.deliveryId;
        dic[@"receiver"] = address.receiver;
        dic[@"mobile"] = address.mobile;
        dic[@"details"] = address.details;
        
        [UserLoginTool loginRequestGet:@"addLotteryReceiverInfo" parame:dic success:^(id json) {
            LWLog(@"%@",json);
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
                [self getNewList];
            }
        } failure:^(NSError *error) {
            LWLog(@"%@", error);
        }];
        
    }else {
        [SVProgressHUD showErrorWithStatus:@"请设置默认地址"];
    }
    
    
}

/**
 *  确认收货
 */
- (void)confirmationOfGoods {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"deliveryId"] = self.selectModel.deliveryId;
    
    [UserLoginTool loginRequestGet:@"confirmReceipt" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"确认收货成功"];
            [self getNewList];
            
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
}


/**
 *  去晒单
 */
- (void)goToNewShare {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewShareController *share = [story instantiateViewControllerWithIdentifier:@"NewShareController"];
    share.WinningModel = self.selectModel;
    [self.navigationController pushViewController:share animated:YES];
    
}

/**
 *  确认收货提示
 */
- (void)confirmationOfGoodsReceipt {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认收货" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"还没收到", nil];
    alert.tag = 2;
    [alert show];
}


/**
 *  确认收货地址提示
 */
- (void)confirmationOfAddress {
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
    AdressModel *address = [NSKeyedUnarchiver unarchiveObjectWithFile:fileNameAdd];
    
    if (address.receiver.length != 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请确认收货地址" message:nil delegate:self cancelButtonTitle:@"使用默认地址" otherButtonTitles:@"使用其他地址", nil];
        alert.tag = 1;
        [alert show];
    }else {
        [self goToAddressListChoose:self.selectModel];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (alertView.tag) {
        case 1:
        {
            
            if (buttonIndex == 1) {
                [self goToAddressListChoose:self.selectModel];
            }else {
                [self useDefaultAddress];
            }
            
            break;
        }
        case 2:
        {
            if (buttonIndex == 0) {
                [self confirmationOfGoods];
            }
            
            break;
        }
        default:
            break;
    }
    
}



@end
