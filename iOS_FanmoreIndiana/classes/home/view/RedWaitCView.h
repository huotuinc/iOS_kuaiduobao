//
//  RedWaitCView.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/10.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NOTIFICATION_RED_WAIT  @"NotificationRedWait"

//mainScreen
@interface RedWaitCView : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewBase;
@property (weak, nonatomic) IBOutlet UILabel *labelRest;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;


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
