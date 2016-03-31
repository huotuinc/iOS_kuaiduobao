//
//  DetailViewController.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/25.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppGoodsListModel.h"
/**
 *  详情页面  
 *  分三种界面显示 A.商品可购买状态 B.商品已被卖光倒计时状态 C.商品倒计时结束 产生中奖者  (B.C 的底部视图为立即前往)
 *  共六种情况进入 1.首页(A) 2.搜索(A) 3.分类(A) 4.专区商品(A) 5.详情页面(立即前往)(A) 5.6最新揭晓(B/C)
 *  三种页面两个API囊括(_whichAPI) 都有所有参与记录API(getBuyList)
 */
@interface DetailViewController : UIViewController

@property (nonatomic, assign) NSNumber *goodsId;
@property (nonatomic, assign) NSNumber *issueId;
@property (nonatomic, assign) NSNumber *lastId;
@property (nonatomic, assign) NSNumber *whichAPI;//1 为正常状态 2为倒计时
@property (nonatomic, strong) AppGoodsListModel *joinModel;//首页传过来的


@end
