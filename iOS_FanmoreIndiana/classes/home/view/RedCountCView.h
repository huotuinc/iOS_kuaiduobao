//
//  RedCountCView.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/8.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NOTIFICATION_RED_END  @"NotificationRedEnd"//xiuxiu倒计时
//100 label tag 100 - 105
@interface RedCountCView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelAA;
@property (weak, nonatomic) IBOutlet UILabel *labelBB;
@property (weak, nonatomic) IBOutlet UILabel *labelA;
@property (weak, nonatomic) IBOutlet UILabel *labelB;
@property (weak, nonatomic) IBOutlet UILabel *labelC;
@property (weak, nonatomic) IBOutlet UILabel *labelD;
@property (weak, nonatomic) IBOutlet UILabel *labelE;
@property (weak, nonatomic) IBOutlet UILabel *labelF;


@property (nonatomic, weak)   id           m_data;

// 获取table view cell 的indexPath

@property (nonatomic)       BOOL         m_isDisplayed;

/**
 *  == [子类可以重写] ==
 *
 *  配置cell的默认属性
 */
- (void)defaultConfig;

/**
 *  == [子类可以重写] ==
 *
 *  在cell上面构建views
 */
- (void)buildViews;

/**
 *  == [子类可以重写] ==
 *
 *  加载数据
 *
 *  @param data      数据
 *  @param indexPath 数据编号
 */
- (void)loadData:(id)data;

@end
