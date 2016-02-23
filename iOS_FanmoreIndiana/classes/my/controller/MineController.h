//
//  MineController.h
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/22.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineController : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *logo;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UIButton *message;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UIButton *pay;
@property (weak, nonatomic) IBOutlet UIImageView *goahead;
@property (weak, nonatomic) IBOutlet UIImageView *announced;
@property (weak, nonatomic) IBOutlet UIImageView *record;

- (IBAction)userAction:(id)sender;

- (IBAction)payAction:(id)sender;



@end
