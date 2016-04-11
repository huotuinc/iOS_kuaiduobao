//
//  HomeCollectionViewCell.h
//  home
//
//  Created by 刘琛 on 16/1/15.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppGoodsListModel.h"

@interface HomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *joinList;
@property (weak, nonatomic) IBOutlet UIImageView *imageVGoods;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *viewProgress;

@property (weak, nonatomic) IBOutlet UIImageView *imageVState;

@property (nonatomic, strong) AppGoodsListModel *model;


@end
