//
//  RedPacketController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RedPacketController.h"
#import "RedPacketCell.h"
#import "RedPacketsModel.h"
#import "AppShareModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <UIBarButtonItem+BlocksKit.h>


@interface RedPacketController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) NSInteger selectMark;
@property (nonatomic, strong) NSMutableArray *redList;

//@property (nonatomic, strong) NSNumber *unused;
//@property (nonatomic, strong) NSNumber *usedOrExpire;

@end

@implementation RedPacketController

static NSString *redPacketIdentify = @"redPactetIdentify";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的红包";
    
    self.redList = [NSMutableArray array];
    self.selectMark = 0;
    
    self.slider = [[UIView alloc] initWithFrame:CGRectMake(0, 33, KScreenWidth / 2, 2)];
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth / 8, 0, KScreenWidth / 4, 2)];
    redView.backgroundColor = [UIColor redColor];
    [self.slider addSubview:redView];
    self.slider.tag = 1001;
    [self.possess setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.selectBgView addSubview:self.slider];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.953 alpha:1.000];
    
    self.snatch.layer.cornerRadius = 5;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RedPacketCell" bundle:nil] forCellReuseIdentifier:redPacketIdentify];
    [self.tableView removeSpaces];
    [self setupRefresh];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"发红包" style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self shareRedPackets];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    
    [self getNewList];
}


- (void)hiddenNoneImageAndLabels {
    self.noneImage.hidden = YES;
    self.noneLabel.hidden = YES;
    self.snatch.hidden = YES;
    self.tableView.hidden = NO;
}

- (void)showNoneImageAndLabels {
    self.noneImage.hidden = NO;
    self.noneLabel.hidden = NO;
    self.snatch.hidden = NO;
    self.tableView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 



#pragma mark 按钮点击事件

- (IBAction)possessAction:(id)sender {
    
    if (self.slider.tag == 1000) {
        [UIView animateWithDuration:0.15 animations:^{
            self.slider.frame = CGRectMake(0, _slider.frame.origin.y, KScreenWidth / 2, 2);
            self.slider.tag = 1001;
            [self.possess setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.used setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.selectMark = 0;
            [self getNewList];
        }];
    }
    
}

- (IBAction)usedAction:(id)sender {
    
    if (self.slider.tag == 1001) {
        [UIView animateWithDuration:0.15 animations:^{
            self.slider.frame = CGRectMake(KScreenWidth / 2, _slider.frame.origin.y, KScreenWidth / 2, 2);
            self.slider.tag = 1000;
            [self.used setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.possess setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.selectMark = 1;
            [self getNewList];
        }];
    }
    
    
}
- (IBAction)snatchAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CannelLoginFailure object:nil];
    
}


- (void)shareRedPackets {
    [UserLoginTool loginRequestGet:@"shareRedPackets" parame:nil success:^(id json) {
        LWLog(@"%@", json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            AppShareModel *model = [AppShareModel mj_objectWithKeyValues:json[@"resultData"][@"share"]];
            [self goShare:model];
        }else if ([json[@"resultCode"] intValue]== 500) {
            
        }else {
            [SVProgressHUD showErrorWithStatus:json[@"resultDescription"]];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
    }];
}


- (void)goShare:(AppShareModel *) model {
    
    
    //1、创建分享参数
    NSArray* imageArray = @[model.imgUrl];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:model.text
                                         images:imageArray
                                            url:[NSURL URLWithString:model.url]
                                          title:model.title
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               
                               
                               [UserLoginTool loginRequestGet:@"successShareRedPackets" parame:nil success:^(id json) {
                                   LWLog(@"%@", json);
                               } failure:^(NSError *error) {
                                   LWLog(@"%@", error);
                               }];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                       
                   }];
        
    }
}

#pragma mark -tableView 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.redList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 114;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RedPacketCell *cell = [tableView dequeueReusableCellWithIdentifier:redPacketIdentify forIndexPath:indexPath];
    cell.selectMark = self.selectMark;
    cell.model = self.redList[indexPath.row];
    return  cell;
}


#pragma mark 网络请求

- (void)getNewList {
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @(self.selectMark);
    dic[@"lastId"] = @0;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyRedPacketsList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_header endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [RedPacketsModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.redList removeAllObjects];
            [self.redList addObjectsFromArray:temp];
            [self.tableView reloadData];
        }
        if (self.redList.count == 0) {
            [self showNoneImageAndLabels];
        }else {
            [self.possess setTitle:[NSString stringWithFormat:@"可使用(%@)", json[@"resultData"][@"unused"]] forState:UIControlStateNormal];
            [self.used setTitle:[NSString stringWithFormat:@"已使用/过期(%@)", json[@"resultData"][@"usedOrExpire"]] forState:UIControlStateNormal];
            [self hiddenNoneImageAndLabels];
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
    RedPacketsModel *model = [self.redList lastObject];
    dic[@"lastId"] = model.pid;
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestGet:@"getMyRedPacketsList" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        [SVProgressHUD dismiss];
        [_tableView.mj_footer endRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            NSArray *temp = [RedPacketsModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.redList addObjectsFromArray:temp];
            [self.tableView reloadData];
            
            [self.possess setTitle:[NSString stringWithFormat:@"可使用(%@)", json[@"resultData"][@"unused"]] forState:UIControlStateNormal];
            [self.used setTitle:[NSString stringWithFormat:@"已使用/过期(%@)", json[@"resultData"][@"usedOrExpire"]] forState:UIControlStateNormal];
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
    
    MJRefreshAutoFooter * Footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreList)];
    _tableView.mj_footer = Footer;
    
}


@end
