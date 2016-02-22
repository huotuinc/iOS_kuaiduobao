//
//  ListTableViewCell.h
//  粉猫xib
//
//  Created by che on 16/2/15.
//  Copyright © 2016年 车. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartModel.h"
//275

/**
 *  @author LQQ, 16-02-18 11:02:02
 *
 *  cell是否被选中的回调
 *
 *  @param select 是否被选中
 */
typedef void(^LQQCartBlock)(BOOL select);

/**
 *  @author LQQ, 16-02-18 11:02:48
 *
 *  数量改变的回调
 */
typedef void(^LQQNumChange)();

@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *buttonSelected;
@property (weak, nonatomic) IBOutlet UIImageView *imageVGoods;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelTotal;
@property (weak, nonatomic) IBOutlet UILabel *labelRest;
@property (weak, nonatomic) IBOutlet UILabel *lableAttend;
@property (weak, nonatomic) IBOutlet UIButton *buttonCut;
@property (weak, nonatomic) IBOutlet UITextField *textFNumber;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UILabel *labelNotice;


@property (nonatomic,assign) CGFloat keyBoardHeight;


//数量
@property (nonatomic,assign)BOOL isSelected;
@property (nonatomic,copy)LQQCartBlock cartBlock;
@property (nonatomic,copy)LQQNumChange numAddBlock;
@property (nonatomic,copy)LQQNumChange numCutBlock;

@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

/**
 *  @author LQQ, 16-02-18 11:02:39
 *
 *  刷新cell
 *
 *  @param model cell数据模型
 */
-(void)reloadDataWith:(CartModel*)model;

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
