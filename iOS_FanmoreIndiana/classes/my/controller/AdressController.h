//  地址列表页面
//  AdressController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/18.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinningModel.h"

@interface AdressController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//1.地址列表 2.选择地址
@property (nonatomic, assign) NSInteger tpye;

@property (nonatomic, strong) WinningModel *winningModel;

@end
