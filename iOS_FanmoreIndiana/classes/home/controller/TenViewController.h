//
//  TenViewController.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/21.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TenViewController : UIViewController
@property (nonatomic, assign) NSNumber *step;//专区起始价格 todo 在全局中赋值
@property (nonatomic, assign) NSInteger whichAPI;//1 10元专区进去 2 全部进入(有分页参数) 3商品分类(pid)进入 4其他进入(有分页参数)
@property (nonatomic, assign) NSNumber *pid;
@property (nonatomic, assign) NSNumber *lastSort;
@property (nonatomic, assign) NSNumber *issueId;
@property (nonatomic, copy) NSString *tenTitle;

@end
