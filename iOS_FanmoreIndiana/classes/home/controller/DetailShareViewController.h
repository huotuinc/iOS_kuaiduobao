//
//  DetailShareViewController.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
//商品往期晒单
@interface DetailShareViewController : UIViewController

@property (nonatomic, assign) NSNumber *goodsId;
@property (nonatomic, assign) NSNumber *lastId;//上一页的最后一个期号

@end
