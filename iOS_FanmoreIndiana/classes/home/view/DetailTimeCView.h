//
//  DetailTimeCView.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/26.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NOTIFICATION_COUNT_TIME  @"NotificationCountTime"


//110
@interface DetailTimeCView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelIssue;
@property (weak, nonatomic) IBOutlet UILabel *labelEndTime;
@property (weak, nonatomic) IBOutlet UILabel *labelIssueA;
@property (weak, nonatomic) IBOutlet UILabel *labelEndTimeA;
@property (weak, nonatomic) IBOutlet UIButton *buttonDetail;
@property (weak, nonatomic) IBOutlet UIView *viewBase;


@property (nonatomic, weak)   id           m_data;

// 获取table view cell 的indexPath


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
