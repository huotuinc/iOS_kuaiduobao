//
//  ListViewController.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/20.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController

@property (nonatomic, strong) NSNumber *shoppingCartId;
@property (assign) BOOL payImmediately;//YES立刻结算 默认选中状态
@property (nonatomic, strong) NSNumber *payGoodsId;//标识默认选中的商品Id;
//@property (nonatomic,strong) NSNumber *redNumber;

@end
