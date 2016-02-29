//
//  NewShareController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "NewShareController.h"

@interface NewShareController ()

@end

@implementation NewShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        if (KScreenWidth == 375) {
            return 310;
        }else if (KScreenWidth == 320){
            return 296;
        }else if (KScreenWidth == 414){
            return 320;
        }
    }
    return 0;
}




@end
