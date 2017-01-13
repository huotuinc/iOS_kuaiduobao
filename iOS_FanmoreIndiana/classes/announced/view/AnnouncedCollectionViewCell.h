//
//  AnnouncedCollectionViewCell.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TIME_CELL               @"TimeCell"
#define NOTIFICATION_TIME_CELL  @"NotificationTimeCell"

//520
@interface AnnouncedCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageVKind;
@property (weak, nonatomic) IBOutlet UIImageView *imageVGoods;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelItem;
@property (weak, nonatomic) IBOutlet UIImageView *imageVNotice;
@property (weak, nonatomic) IBOutlet UILabel *labelAnnounce;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UIView *viewMain;

@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

// 获取table view cell 的indexPath
@property (nonatomic, weak) NSIndexPath *m_indexPath;

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
- (void)loadData:(id)data indexPath:(NSIndexPath*)indexPath;


@end
