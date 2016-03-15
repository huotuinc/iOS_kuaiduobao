//
//  DetailGoodsSelectCView.h
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/2.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>
//460
@interface DetailGoodsSelectCView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelPerson;

@property (weak, nonatomic) IBOutlet UILabel *labelAttend;
@property (weak, nonatomic) IBOutlet UIButton *buttonCut;
@property (weak, nonatomic) IBOutlet UITextField *textFNumber;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UIButton *buttonGo;
@property (weak, nonatomic) IBOutlet UIView *viewChange;
@property (weak, nonatomic) IBOutlet UIView *viewPerson;
@property (weak, nonatomic) IBOutlet UIButton *buttonClose;


@end
