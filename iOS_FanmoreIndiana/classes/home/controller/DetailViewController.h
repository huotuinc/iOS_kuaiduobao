//
//  DetailViewController.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/25.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppGoodsListModel.h"
@interface DetailViewController : UIViewController

@property (nonatomic, assign) NSNumber *goodsId;
@property (nonatomic, assign) NSNumber *issueId;
@property (nonatomic, assign) NSNumber *lastId;
@property (nonatomic, assign) NSNumber *whichAPI;//1 为正常状态 2为倒计时
@property (nonatomic, strong) AppGoodsListModel *joinModel;

@end
