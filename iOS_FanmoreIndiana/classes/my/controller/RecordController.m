//
//  RecordController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/23.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RecordController.h"
#import "RecordCell.h"
#import "GoAheadCell.h"
#import "RaiderModel.h"

@interface RecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@property (nonatomic, strong) UILabel *selectLabel;

//数据列表
@property (nonatomic, strong) NSMutableArray *recordList;

@end

@implementation RecordController

static NSString *recordCellIdentify = @"recordCellIdentify";
static NSString *goAheadCellIdentify = @"goAheadCellIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"夺宝记录";
    
    self.recordList = [NSMutableArray array];
    
    [self _initLeftAndRightSwipeGesture];
    
    self.selectLabel = [[UILabel alloc] init];
    
    [self setupRefresh];
    
    [self.tableView removeSpaces];
//    self.tableView.hidden = YES;
    
    [self.all bk_whenTapped:^{
        if (self.selectMark != 0) {
            self.selectMark = 0;
            [self seleceMarkChanged];
        }
    }];
    
    [self.doing bk_whenTapped:^{
        if (self.selectMark != 1) {
            self.selectMark = 1;
            [self seleceMarkChanged];
        }
    }];
    
    [self.end bk_whenTapped:^{
        if (self.selectMark != 2) {
            self.selectMark = 2;
            [self seleceMarkChanged];
        }
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.sliderBgView layoutIfNeeded];
    
    [self _initSliderFrame];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RecordCell" bundle:nil] forCellReuseIdentifier:recordCellIdentify];
    [self.tableView  registerNib:[UINib nibWithNibName:@"GoAheadCell" bundle:nil] forCellReuseIdentifier:goAheadCellIdentify];
    
    [self getNewList];
    
}

- (void)_initSliderFrame {
    switch (_selectMark) {
        case 0:
        {
            self.sliderX.constant = self.slider.frame.size.width * _selectMark;
            self.all.textColor = [UIColor redColor];
            self.selectLabel = self.all;
            break;
        }
        case 1:
        {
            self.sliderX.constant = self.slider.frame.size.width * _selectMark;
            self.doing.textColor = [UIColor redColor];
            self.selectLabel = self.doing;
            break;
        }
        case 2:
        {
            self.sliderX.constant = self.slider.frame.size.width * _selectMark;
            self.end.textColor = [UIColor redColor];
            self.selectLabel = self.end;
            break;
        }
        default:
            break;
    }
}


- (void)seleceMarkChanged {
    
    switch (_selectMark) {
        case 0:
        {
            [UIView animateWithDuration:0.35 animations:^{
                self.slider.frame = CGRectMake(0, _slider.frame.origin.y, _slider.frame.size.width, _slider.frame.size.height);
//                self.sliderX.constant = self.slider.frame.size.width * _selectMark;
                self.all.textColor = [UIColor redColor];
                self.selectLabel.textColor = [UIColor blackColor];
                self.selectLabel = self.all;
                
            }];
            [self getNewList];
            break;
        }
        case 1:
        {
            [UIView animateWithDuration:0.35 animations:^{
                self.slider.frame = CGRectMake(self.slider.frame.size.width * _selectMark, _slider.frame.origin.y, _slider.frame.size.width, _slider.frame.size.height);
//                self.sliderX.constant = ;
                self.doing.textColor = [UIColor redColor];
                self.selectLabel.textColor = [UIColor blackColor];
                self.selectLabel = self.doing;
            }];
            [self getNewList];
            break;
        }
        case 2:
        {
            [UIView animateWithDuration:0.35 animations:^{
                self.slider.frame = CGRectMake(self.slider.frame.size.width * _selectMark, _slider.frame.origin.y, _slider.frame.size.width, _slider.frame.size.height);
//                self.sliderX.constant = self.slider.frame.size.width * _selectMark;
                self.end.textColor = [UIColor redColor];
                self.selectLabel.textColor = [UIColor blackColor];
                self.selectLabel = self.end;
            }];
            [self getNewList];
            break;
        }
        default:
            break;
    }
    
    
}


#pragma mark 网络请求

- (void)getNewList {
    
    [self.recordList removeAllObjects];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @(self.selectMark);
    dic[@"lastId"] = @0;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyRaiderList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_header endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [RaiderModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.recordList addObjectsFromArray:temp];
            [self.tableView reloadData];
        }
        if (self.recordList.count == 0) {
            [self showGoHomeButton];
        }else {
            [self HiddenGoHomeButton];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [_tableView.mj_header endRefreshing];
        LWLog(@"%@",error);
    }];
    
}

- (void)getMoreList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @(self.selectMark);
    RaiderModel *model = [self.recordList lastObject];
    dic[@"lastId"] = model.pid;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyRaiderList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_footer endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [RaiderModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.recordList addObjectsFromArray:temp];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [_tableView.mj_footer endRefreshing];
        LWLog(@"%@",error);
    }];
}


- (void)setupRefresh
{
    
    MJRefreshNormalHeader * headRe = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewList)];
    _tableView.mj_header = headRe;

    MJRefreshAutoNormalFooter * Footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreList)];
    _tableView.mj_footer = Footer;
 
}




- (void)_initLeftAndRightSwipeGesture {
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        LWLog(@"尼玛的, 你在往左边跑啊....") ;
        if (self.selectMark != 0) {
            self.selectMark--;
            [self seleceMarkChanged];
        }
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        LWLog(@"尼玛的, 你在往右边跑啊....") ;
        if (self.selectMark != 2) {
            self.selectMark++;
            [self seleceMarkChanged];
        }
    }
}

- (void)showGoHomeButton {
    self.noneBox.hidden = NO;
    self.noneLabel.hidden = NO;
    self.goHome.hidden = NO;
    self.tableView.hidden = YES;
}

- (void)HiddenGoHomeButton {
    self.noneBox.hidden = YES;
    self.noneLabel.hidden = YES;
    self.goHome.hidden = YES;
    self.tableView.hidden = NO;
}

- (IBAction)goHomeAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CannelLoginFailure object:nil];
}

#pragma mark tableView 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.selectMark == 0) {
        return self.recordList.count;
    }else if (self.selectMark == 1) {
        return self.recordList.count;
    }else if (self.selectMark == 2) {
        return self.recordList.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectMark == 0) {
        RaiderModel *model = self.recordList[indexPath.row];
        if ([model.status integerValue] == 0) {
            
            return 127;
        }else if([model.status integerValue] == 2) {
            
            return 235;
        };
    }else if (self.selectMark == 1) {
        return 127;
    }else if (self.selectMark == 2) {
        return 235;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectMark == 0) {
        RaiderModel *model = self.recordList[indexPath.row];
        if ([model.status integerValue] == 0) {
            GoAheadCell *cell = [tableView dequeueReusableCellWithIdentifier:goAheadCellIdentify forIndexPath:indexPath];
            cell.model = self.recordList[indexPath.row];
            return cell;
        }else if([model.status integerValue] == 2) {
            RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:recordCellIdentify forIndexPath:indexPath];
            cell.model = self.recordList[indexPath.row];
            return cell;
        }
        
    }else if (self.selectMark == 1) {
        GoAheadCell *cell = [tableView dequeueReusableCellWithIdentifier:goAheadCellIdentify forIndexPath:indexPath];
        cell.model = self.recordList[indexPath.row];
        return cell;
    }else if (self.selectMark == 2) {
        RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:recordCellIdentify forIndexPath:indexPath];
        cell.model = self.recordList[indexPath.row];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectMark == 0) {
        RaiderModel *model = self.recordList[indexPath.row];
        if ([model.status integerValue] == 0) {
            GoAheadCell *cell = [tableView dequeueReusableCellWithIdentifier:goAheadCellIdentify forIndexPath:indexPath];
            cell.model = self.recordList[indexPath.row];
  
        }else if([model.status integerValue] == 2) {
            RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:recordCellIdentify forIndexPath:indexPath];
            cell.model = self.recordList[indexPath.row];
  
        }
        
    }else if (self.selectMark == 1) {
        GoAheadCell *cell = [tableView dequeueReusableCellWithIdentifier:goAheadCellIdentify forIndexPath:indexPath];
        cell.model = self.recordList[indexPath.row];

    }else if (self.selectMark == 2) {
        RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:recordCellIdentify forIndexPath:indexPath];
        cell.model = self.recordList[indexPath.row];

    }
    
}



@end
