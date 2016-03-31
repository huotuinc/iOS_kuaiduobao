//
//  HomeController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/18.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "HomeController.h"
#import "XLPlainFlowLayout.h"
#import "HomeCollectionViewCell.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "HomeFourBtnCView.h"
#import "labelCollectionViewCell.h"
#import "HomeHeadCollectionViewCell.h"
#import "TenViewController.h"
#import "DetailViewController.h"
#import "ClassViewController.h"
#import "FL_Button.h"
#import "AppGoodsListModel.h"
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "ShareViewController.h"
#import "HomeSearchCView.h"
#import "SearchViewController.h"
#import "PayViewController.h"//
#import "DetailShareNextViewController.h"//
#import "AppNoticeListModel.h"
#import "AppSlideListModel.h"
#import "InformationViewController.h"
#import "CartModel.h"
#import "RedViewController.h"
#import "DetailWebViewController.h"
#import "LoginController.h"
#import "ArchiveLocalData.h"
#import "CircleBannerView.h"
#import "HomeSearchCView.h"
#import "HomeGetRedPocketCView.h"
#import "HomeSendRedPocketCView.h"
#import "MCController.h"
#import "AppDelegate.h"
#import "AppShareModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "GlobalModel.h"
static BOOL isExist = NO;//用于判断归档时有无该对象
@interface HomeController ()<CircleBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,logVCdelegate>

@property (strong, nonatomic)  UICollectionView *collectionView;
@property (strong, nonatomic)  HomeSearchCView *searchV;//搜索框
//@property (strong, nonatomic)  DCPicScrollView *headScrollView;//头部视图-轮播视图
@property (strong, nonatomic)  CircleBannerView *headScrollView;//头部视图-轮播视图

@property (strong, nonatomic)  HomeFourBtnCView *fourBtnView;//头部视图-四个按钮
@property (strong, nonatomic)  UICollectionView *labelCollectionView;//头部视图-中奖信息
@property (strong, nonatomic)  UIImageView *imageVNotice;//头部视图-提醒
@property (strong, nonatomic)  UIView *headView;//头部视图
@property (strong, nonatomic)  UIView *clearView;//分割的View
@property (strong, nonatomic)  HomeGetRedPocketCView *getRedView;//弹框 得到红包
@property (strong, nonatomic)  HomeSendRedPocketCView *sendRedView;//弹框 发出红包
@property (strong, nonatomic)  NSTimer *timer;//定时器
@property (strong , nonatomic) UIImageView *imageVRed;//中间四个选项 下划线
@property (weak , nonatomic) UIView *viewChoice;//中间四个选项
@property (strong, nonatomic)  UIImageView *imageV;//头部视图-提醒
@property (strong, nonatomic)  UIView *viewBackShare;//弹出红包时的背景
@property (nonatomic, strong) NSMutableArray *appGoodsList;
@property (nonatomic, strong) NSMutableArray *appNoticeList;
@property (nonatomic, strong) NSMutableArray *appSlideList;
@property (nonatomic, strong) NSMutableArray *arrURLString;//轮播图片
@property (nonatomic, strong) NSMutableArray *arrRedList;//弹窗红包

@property (nonatomic, strong) NSNumber *lastSort;
@property (nonatomic, strong) NSNumber *sendRedNumber;//判断是否弹出发红包视图 1可以
@property (nonatomic, strong) NSString *redShareInfo;//弹出红包的文字描述


@property (nonatomic, assign) BOOL isLoadView;
@property (nonatomic, assign) BOOL isFirstLoad;
@end

@implementation HomeController{


}


static NSString *identify = @"homeCellIdentify";
static NSString *headIdentify = @"homeCellHeadIdentify";
static NSString *topIdentify = @"homeCellTopIdentify";
static NSString *cellLabel = @"homeCellLabel";
static NSString *cellHead = @"homeCellHead";

static NSInteger labelHeight = 20;//中奖信息CollectionView高度
static NSInteger clearHeight = 10;//中奖信息CollectionView高度
static NSInteger num=0;//记录总需人数的点击次数
static NSInteger orderNumberNow=0;//记录排序的当前点击


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    self.navigationController.navigationBar.translucent=NO;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:0.7];
    self.view.backgroundColor=COLOR_BACK_MAIN;
    
    [self createBarButtonItem];
//    [self.navigationItem changeNavgationBarTitle:@"奇兵夺宝"];
//    [self createNavgationBarTitle];

    
    self.tabBarController.tabBar.hidden = NO;
    [self getHomeData];
    
//    NSString * login = [[NSUserDefaults standardUserDefaults] objectForKey:LoginStatus];
//    if ([login isEqualToString:Success]) {
//        [self getRedList];
//    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor yellowColor]];

    self.isFirstLoad = YES;
    self.isLoadView = NO;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendRedPocketYesOrNo) name:canSendRedPocketOrNot object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendRedPocketYesOrNo) name:canSendRedPocketOrNot object:nil];
    _appGoodsList=[NSMutableArray array];
    _appNoticeList=[NSMutableArray array];
    _appSlideList=[NSMutableArray array];
    _arrURLString=[NSMutableArray array];
    _arrRedList = [NSMutableArray array];
    [self createNavgationBarTitle];
    
    

    self.type = [NSNumber numberWithInteger:1];
    // 创建操作队列
   

//    [self getHomeData];
//    [self createGetRedView];


//    [self createHeadView];
//    [self createMainCollectionView];
    [self _initCollectionView];
        [self createLableCollectionView];

//    [self ]

}

-(void)createNavgationBarTitle{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:FONT_SIZE(36)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"奇兵夺宝";
    self.navigationItem.titleView = titleLabel;
}
#pragma mark 获取数据 线程
- (void)getHomeData {
//    [SVProgressHUD show];
    [self getGoodsList];

//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
////        [self getAppNoticeList];
////        [self createMainCollectionView];
//
//    }];
//    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
//        [self getGoodsList];
//
//    }];
//    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
////        [self createHeadView];
////        [self getAppNoticeList];
//
//    }];
//    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
////        [self getAppSlideList];
////        NSString * userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:UserInfo];
////        if ([login isEqualToString:Success]) {
////            [self getShoppingList];
////        }else{
//
//    }];
//    
//    [op2 addDependency:op1];
////    [op3 addDependency:op1];
//    [op3 addDependency:op2];
//    [op4 addDependency:op2];
//    
//    // 为队列添加线程
//    [queue addOperation:op1];
//    [queue addOperation:op2];
//    [queue addOperation:op3];
//    [queue addOperation:op4];
}
- (void)createBarButtonItem{
    UIButton *buttonL=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [buttonL setBackgroundImage:[UIImage imageNamed:@"search2"] forState:UIControlStateNormal];
    [buttonL bk_whenTapped:^{
        SearchViewController *search = [[SearchViewController alloc] init];
        [self.navigationController pushViewController:search animated:YES];
    }];
    UIBarButtonItem *bbiL=[[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem=bbiL;
    
    UIButton *buttonR=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationIconBadgeNumber != 0) {
        [buttonR setBackgroundImage:[UIImage imageNamed:@"xiaoxi_red"]forState:UIControlStateNormal];
    } else {
        [buttonR setBackgroundImage:[UIImage imageNamed:@"xiaoxi"]forState:UIControlStateNormal];
    }
    [buttonR bk_whenTapped:^{
        MCController *mc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MCController"];
        [self.navigationController pushViewController:mc animated:YES];
    }];
    UIBarButtonItem *bbiR=[[UIBarButtonItem alloc]initWithCustomView:buttonR];
    self.navigationItem.rightBarButtonItem=bbiR;
}
- (void)createGetRedView {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    _viewBackShare = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+10)];
    _viewBackShare.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8];
    [window addSubview:_viewBackShare];
    
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"HomeGetRedPocketCView" owner:nil options:nil];
    _getRedView=[nib firstObject];
    _getRedView.frame=CGRectMake(0,-SCREEN_HEIGHT-10, SCREEN_WIDTH, SCREEN_HEIGHT+10);
    if (_arrRedList.count == 1) {
        _getRedView.labelB.text = [NSString stringWithFormat:@"%@",_arrRedList[0]];
        _getRedView.labelC.text = @"您有一个金币红包";
    } else {
        NSInteger totalMoney = 0;
        for (int i = 0 ; i < _arrRedList.count; i++) {
            NSInteger step =[_arrRedList[i] integerValue];
            totalMoney += step;
        }
        _getRedView.labelB.text = [NSString stringWithFormat:@"%ld",(long)totalMoney];
        _getRedView.labelC.text = @"您有金币红包";
    }
    [UIView animateWithDuration:0.5f animations:^{
        _getRedView.frame=CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT+10);
    }];
    
    _getRedView.imageVClose.userInteractionEnabled = YES;
    [_getRedView.imageVClose bk_whenTapped:^{
        NSLog(@"点击了");
        [_getRedView removeFromSuperview];
        [_viewBackShare removeFromSuperview];
    }];
    [_getRedView.buttonGet bk_whenTapped:^{
        [_getRedView removeFromSuperview];
        [_viewBackShare removeFromSuperview];
    }];
    [_getRedView.imageVBack bk_whenTapped:^{
        [_getRedView removeFromSuperview];
        [_viewBackShare removeFromSuperview];
    }];
    [window addSubview:_getRedView];

}
- (void)createSendRedView {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:payMoneySuccess object:self];
    [_getRedView removeFromSuperview];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    _viewBackShare = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+10)];
    _viewBackShare.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8];
    [window addSubview:_viewBackShare];
    
    
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"HomeSendRedPocketCView" owner:nil options:nil];
    _sendRedView=[nib firstObject];
    _sendRedView.frame=CGRectMake(0,-SCREEN_HEIGHT-10, SCREEN_WIDTH, SCREEN_HEIGHT+10);
    _sendRedView.labelMain.text = _redShareInfo;

    _sendRedView.imageVClose.userInteractionEnabled = YES;
    [_sendRedView.imageVClose bk_whenTapped:^{
        [_sendRedView removeFromSuperview];
        [_viewBackShare removeFromSuperview];

    }];
    [_sendRedView.imageVBack bk_whenTapped:^{
        [_sendRedView removeFromSuperview];
        [_viewBackShare removeFromSuperview];

    }];
    [_sendRedView.buttonSend bk_whenTapped:^{
        [_sendRedView removeFromSuperview];
        [_viewBackShare removeFromSuperview];
        [self shareRedPackets];
    }];
    [UIView animateWithDuration:0.5f animations:^{
        _sendRedView.frame=CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT+10);
    }];
    
    
    [window addSubview:_sendRedView];}

-(void)createMainCollectionView{
    if (self.collectionView) {
        return;
    }else {
//        XLPlainFlowLayout *flowLayout = [[XLPlainFlowLayout alloc] init];
//        flowLayout.naviHeight = 0;
//        flowLayout.minimumInteritemSpacing = 0.5;
//        flowLayout.minimumLineSpacing = 1;
//        flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
//        
//        
//        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64 -5) collectionViewLayout:flowLayout];
//        self.collectionView.tag=100;
//        self.collectionView.delegate = self;
//        self.collectionView.dataSource = self;
//        self.collectionView.backgroundColor=COLOR_BACK_MAIN;
//        [self.view addSubview:self.collectionView];
//        
//        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentify];
//        [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellHead];
//        
//        [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identify];
//        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:topIdentify];
//        [self setupRefresh];
    }
    
}
- (void)setupRefresh
{
    MJRefreshNormalHeader * headRe = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHomeData)];
    self.collectionView.mj_header = headRe;
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(getNewData)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    //    self.tableView.headerPullToRefreshText = @"下拉可以刷新了"
    //    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    //    self.tableView.headerRefreshingText = @"正在刷新最新数据,请稍等";
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    MJRefreshBackNormalFooter * Footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreGoodsList)];
    self.collectionView.mj_footer = Footer;
    
    //        [_tableView addFooterWithTarget:self action:@selector(getMoreGoodList)];
    
    
}



#pragma mark 网络请求中奖通知列表

- (void)getAppNoticeList {
    
    [UserLoginTool loginRequestGet:@"getNoticeList" parame:nil success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [AppNoticeListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.appNoticeList removeAllObjects];
            [self.appNoticeList addObjectsFromArray:temp];
//            if (!_labelCollectionView) {
//                [self createLableCollectionView];
//            }else {
                [_labelCollectionView reloadData];
//            }
            
        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    
}
#pragma mark 网络弹窗红包列表

- (void)getRedList{
    
    [UserLoginTool loginRequestGet:@"getRemindRedPackets" parame:nil success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [NSArray arrayWithArray:json[@"resultData"][@"redpackets"]];
            [self.arrRedList removeAllObjects];
            [self.arrRedList addObjectsFromArray:temp];
            if (_arrRedList.count != 0) {
                [self createGetRedView];
            }
        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    
}
#pragma mark 网络顶部轮播视图列表

- (void)getAppSlideList{

    [UserLoginTool loginRequestGet:@"getSlideList" parame:nil success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [AppSlideListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.appSlideList removeAllObjects];
            [self.arrURLString removeAllObjects];
            [self.appSlideList addObjectsFromArray:temp];
            for (int i =0; i<_appSlideList.count; i++) {
                AppSlideListModel *model = _appSlideList[i];
                [_arrURLString addObject:model.pictureUrl];
            }
           
            
        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    
}
#pragma mark 网络请求商品列表
/**
 *  下拉刷新
 */
- (void)getGoodsList {
    [SVProgressHUD show];

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = self.type;
    if (orderNumberNow == 2) {
        dic[@"lastSort"]= @100;

    }else {
        dic[@"lastSort"]= @0;

    }
    
    [UserLoginTool loginRequestGet:@"getGoodsListByIndex" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [AppGoodsListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            self.lastSort =json[@"resultData"][@"sort"];
            [self.appGoodsList removeAllObjects];
            [self.appGoodsList addObjectsFromArray:temp];
//            if (!_collectionView) {
//                [self createMainCollectionView];
//            }else {
                [_collectionView reloadData];

//            }

        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
        [SVProgressHUD dismiss];

        

    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
    [_collectionView.mj_header endRefreshing];

    NSString * login = [[NSUserDefaults standardUserDefaults] objectForKey:LoginStatus];
    if ([login isEqualToString:Success]) {
        [self getRedList];
    }
}

/**
 *  上拉加载更多
 */
- (void)getMoreGoodsList {
     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = self.type;
    dic[@"lastSort"]= self.lastSort;
    
    [UserLoginTool loginRequestGet:@"getGoodsListByIndex" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            NSArray *temp = [AppGoodsListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            self.lastSort =json[@"resultData"][@"sort"];

            [self.appGoodsList addObjectsFromArray:temp];
            LWLog(@"%@",json[@"resultDescription"]);

            if (temp.count == 0) {
                return ;
            }else {
                [_collectionView reloadData];
            }
            
        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
        [_collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog (@"%@",error);
    }];
    
//    [_collectionView.mj_footer endRefreshing];

    
}

#pragma mark  网络加入购物车

-(void)joinShoppingCart {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"issueId"] = self.issueId;

    [UserLoginTool loginRequestPostWithFile:@"joinShoppingCart" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            LWLog(@"%@",json[@"resultDescription"]);
        }else {
            LWLog(@"%@",json[@"resultDescription"]);
        }
        [SVProgressHUD showSuccessWithStatus:@"加入清单成功"];
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"加入清单失败"];

        
    } withFileKey:nil];
    
    
}
- (void)createHeadScrollView {
    _headScrollView = [[CircleBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(280))];
    _headScrollView.delegate = self;
    if (_arrURLString.count == 1) {
        _headScrollView.interval = 0.f;
    }else {
        _headScrollView.interval = 2.f;
        
    }
    [_headScrollView circleBannerWithURLArray:_arrURLString];

}



- (void)createFourBtnView {
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"HomeFourBtnCView" owner:nil options:nil];
    _fourBtnView=[nib firstObject];
    _fourBtnView.frame=CGRectMake(0,ADAPT_HEIGHT(280), SCREEN_WIDTH, ADAPT_HEIGHT(160));
    for (int i =0; i<5; i++) {
        UIImageView *imageV=[_fourBtnView viewWithTag:200+i];
        imageV.userInteractionEnabled=YES;
    }
#pragma mark 分类
    [_fourBtnView.imageVClass bk_whenTapped:^{
        ClassViewController *class=[[ClassViewController alloc]init];
        [self.navigationController pushViewController:class animated:YES];
    }];
#pragma mark 10元专区
    [_fourBtnView.imageTen bk_whenTapped:^{
        TenViewController *ten=[[TenViewController alloc]init];
        ten.whichAPI = 1;
        [self.navigationController pushViewController:ten animated:YES];
    }];
#pragma mark 红包专区
    [_fourBtnView.imageVRed bk_whenTapped:^{
        
        NSString * login = [[NSUserDefaults standardUserDefaults] objectForKey:LoginStatus];
        if ([login isEqualToString:Success]) {
            RedViewController * red = [[RedViewController alloc] init];
            [self.navigationController pushViewController:red animated:YES];
        }else{
            [self goToLogin];
        }
        
        
    }];
    
#pragma mark 晒单
    [_fourBtnView.imageVShow bk_whenTapped:^{
        ShareViewController *share=[[ShareViewController alloc]init];
        [self.navigationController pushViewController:share animated:YES];
        
    }];
#pragma mark 分享
    [_fourBtnView.imageVHelp bk_whenTapped:^{
        
        //        DetailViewController *detail=[[DetailViewController alloc]init];
        //        detail.issueId=[NSNumber numberWithInteger:100000002];
        //        detail.whichAPI=[NSNumber numberWithInteger:2];
        //        [self.navigationController pushViewController:detail animated:YES];
        //        PayViewController *pay = [[PayViewController alloc] init];
        //        [self.navigationController pushViewController:pay animated:YES];
        
        DetailWebViewController *web = [[DetailWebViewController alloc] init];
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [path stringByAppendingPathComponent:GlobalInfo];
        GlobalModel *global = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
        web.webURL = global.helpURL;
        [self.navigationController pushViewController:web animated:YES];
        
        
    }];

}

#pragma mark 网络请求结算 未登录 进行登陆
- (void)goToLogin {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginController *login = [story instantiateViewControllerWithIdentifier:@"LoginController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    login.logDelegate = self;
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
}

- (void)createImageVNotice {
    _imageVNotice=[[UIImageView alloc]initWithFrame:CGRectMake(20, ADAPT_HEIGHT(440)+5, 30, 30)];
    _imageVNotice.image=[UIImage imageNamed:@"news"];
}

- (void)createClearView {
    _clearView=[[UIView alloc]initWithFrame:CGRectMake(0, ADAPT_HEIGHT(440)+40, SCREEN_WIDTH, clearHeight)];
    _clearView.backgroundColor=COLOR_BACK_MAIN;
}

-(void)createHeadView{
    [self createHeadScrollView];
//    _imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(440)+labelHeight+clearHeight+10)];
//    _imageV.image=[UIImage imageNamed:@"buy_fukuan_red"];
//    [self createFourBtnView];
//    [self createImageVNotice];
//    [self createLableCollectionView];
//    [self createClearView];
    

//    [_headView addSubview:_headScrollView];
//    [_headView addSubview:_fourBtnView];
//    [_headView addSubview:_imageVNotice];
//    [_headView addSubview:_labelCollectionView];
//    [_headView addSubview:_clearView];
}
-(void)createLableCollectionView{
//    if (!_labelCollectionView) {
        _labelCollectionView.userInteractionEnabled = NO;
//        self.automaticallyAdjustsScrollViewInsets = YES;
        UICollectionViewFlowLayout *viewlayout = [[UICollectionViewFlowLayout alloc]init];
        viewlayout.minimumLineSpacing = 0;
        viewlayout.minimumInteritemSpacing = 0;
        viewlayout.itemSize = CGSizeMake(SCREEN_WIDTH-_imageVNotice.frame.origin.x-_imageVNotice.frame.size.width-5-20, labelHeight);
        viewlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        viewlayout.scrollDirection =UICollectionViewScrollDirectionVertical;
        
        
        _labelCollectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(_imageVNotice.frame.origin.x+_imageVNotice.frame.size.width+5 , ADAPT_HEIGHT(440)+10, SCREEN_WIDTH-_imageVNotice.frame.origin.x-_imageVNotice.frame.size.width-5-20,labelHeight)collectionViewLayout:viewlayout];
        [_labelCollectionView registerNib:[UINib nibWithNibName:@"labelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellLabel];
        
        _labelCollectionView.delegate = self;
        _labelCollectionView.dataSource = self;
        _labelCollectionView.pagingEnabled = YES;
        _labelCollectionView.showsVerticalScrollIndicator=NO;
        _labelCollectionView.showsHorizontalScrollIndicator = NO;
        _labelCollectionView.tag=101;
        _labelCollectionView.backgroundColor=[UIColor whiteColor];
//    }else {
//        return;
//    }
    

    //    _collectionView.contentSize=CGSizeMake(_collectionView.frame.size.width,100*_arr.count );
    
    //创建一个 cell 的注册方式 必须写上
    //  设置时钟动画 定时器
    //    _isDragging=NO;
//    if (_timer) {
//        return;
//    }else {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
//    }
//    //  将定时器添加到主线程
//    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

}
- (void)update:(NSTimer *)timer{
    CGPoint offSet = _labelCollectionView.contentOffset;
    if ((NSInteger)offSet.y % labelHeight == 0) {
        offSet.y +=labelHeight;
    }else {
        LWLog(@"labelCollectionV滚动错位 修复中");
        NSInteger errorDistance = (NSInteger)offSet.y % labelHeight;
        offSet.y -= errorDistance;
        offSet.y +=labelHeight;
    }
    [_labelCollectionView setContentOffset:offSet animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag == 100) {
        return 2;
    }
    else{
        return 1;
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 100) {
        if (section == 0) {
            return 1;
        }else {
            return _appGoodsList.count;
        }
    }
    else{
        if (_appGoodsList == nil) {
            [self getAppNoticeList];
            return _appNoticeList.count  ;

        }else {
            return _appNoticeList.count * 10000 ;

        }
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView.tag == 100) {
        if (indexPath.section == 0) {
            HomeHeadCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellHead forIndexPath:indexPath ];
//
//            [self getAppSlideList];
            [_headScrollView removeFromSuperview];
            [self createHeadScrollView];
            [_fourBtnView removeFromSuperview];
            [self createFourBtnView];
            [self.imageVNotice removeFromSuperview];
            [self createImageVNotice];
            [self.labelCollectionView removeFromSuperview];
            [self createLableCollectionView];
            if (!_labelCollectionView) {
                [self createLableCollectionView];
            }else {
                [_labelCollectionView reloadData];
            }
            [self getAppNoticeList];
            [self.clearView removeFromSuperview];
            [self createClearView];
            
            [cell addSubview:_headScrollView];
            [cell addSubview:_fourBtnView];
            [cell addSubview:_imageVNotice];
            [cell addSubview:_labelCollectionView];
            [cell addSubview:_clearView];
            if (_timer) {
            }else {
                _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
            }
            //  将定时器添加到主线程
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            cell.selectedBackgroundView = [[UIView alloc] init];
            cell.backgroundColor = [UIColor whiteColor];
            
            return cell;
            
        }else {
            HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];

            
            AppGoodsListModel *model=_appGoodsList[indexPath.row];
            
            cell.imageVState.image = [UIImage imageNamed:@""];
            if ([model.areaAmount integerValue] > 0) {
                cell.imageVState.image=[UIImage imageNamed:@"zhuanqu_a"];
            }

            
            cell.labelName.text=model.title;
            CGFloat percent=(model.toAmount.floatValue -model.remainAmount.floatValue)/(model.toAmount.floatValue);
            cell.viewProgress.progress=percent;
            NSString *percentString = [NSString stringWithFormat:@"%.0f%%",percent*100];
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"开奖进度 %@",percentString]];
            [attString addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_TITILE range:NSMakeRange(0,4)];
            [attString addAttribute:NSForegroundColorAttributeName value:COLOR_SHINE_BLUE range:NSMakeRange(5,percentString.length)];
            cell.labelProgress.attributedText = attString;
            [cell.imageVGoods sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl]];
            cell.joinList.tag = 500 + indexPath.row;
            [cell.joinList bk_whenTapped:^{
                NSInteger row = cell.joinList.tag - 500;
                AppGoodsListModel * joinModel = _appGoodsList[row];
                //加入购物车
                NSString * login = [[NSUserDefaults standardUserDefaults] objectForKey:LoginStatus];
                if ([login isEqualToString:Success]) {
#pragma mark 加入购物车 已登陆
                    self.issueId = joinModel.issueId;
                    [self joinShoppingCart];
                }else{
#pragma mark 加入购物车 未登陆
                    [ArchiveLocalData archiveLocalDataArrayWithGoodsModel:joinModel];
                    [SVProgressHUD showSuccessWithStatus:@"加入清单成功"];
                    
                }
            }];
            if (indexPath.row % 2) {
                
            }else {
                
            }
            
//            cell.layer.borderColor=[UIColor whiteColor].CGColor;
//            cell.layer.borderWidth=0;
            
            return cell;
        }
    }
    else{
        labelCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:cellLabel forIndexPath:indexPath];
        if (indexPath.item >= _appNoticeList.count) {
            NSInteger i = indexPath.item % _appNoticeList.count;
            AppNoticeListModel *model =_appNoticeList[i];
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"恭喜%@%ld分钟前获得了%@ ",model.name,[model.time integerValue]/60,model.title]];
            [attString addAttribute:NSForegroundColorAttributeName value:COLOR_BUTTON_BLUE range:NSMakeRange(2, model.name.length)];
            NSInteger startRange = 2 +model.name.length +[NSString stringWithFormat:@"%ld",[model.time integerValue]/60].length +6;
            [attString addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_CONTENT range:NSMakeRange(startRange, model.title.length)];
            cell.labelMain.attributedText = attString;
            return cell;

        }
    else {
            AppNoticeListModel *model =_appNoticeList[indexPath.item];
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"恭喜%@%ld分钟前获得了%@ ",model.name,[model.time integerValue]/60,model.title]];
            [attString addAttribute:NSForegroundColorAttributeName value:COLOR_BUTTON_BLUE range:NSMakeRange(2, model.name.length)];
            NSInteger startRange = 2 +model.name.length +[NSString stringWithFormat:@"%ld",[model.time integerValue]/60].length +6;
            [attString addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_CONTENT range:NSMakeRange(startRange, model.title.length)];
            cell.labelMain.attributedText = attString;
            return cell;


        }
//
    }
    
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 100) {
        if (kind == UICollectionElementKindSectionHeader) {
            
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentify forIndexPath:indexPath];
            NSArray *arr=@[@"人气",@"最新",@"进度",@"总需人次"];
            
            if (_viewChoice != nil) {
                [_viewChoice removeFromSuperview];
                _viewChoice = nil;
            }
            
            UIView* localView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            
//            _viewChoice=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            
            for (int i=0; i<4; i++) {
                FL_Button *button = [FL_Button fl_shareButton];
                [button setTitle:arr[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                button.status = FLAlignmentStatusCenter;
                button.frame=CGRectMake(SCREEN_WIDTH/4*i, 0, SCREEN_WIDTH/4, 43);
                button.tag=100+i;
                if (i==3) {
                    [button setImage:[UIImage imageNamed:@"paixu"] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"paixu_b"] forState:UIControlStateSelected];
                }
                [button bk_whenTapped:^{
                    for (int i = 0; i< 4; i++) {
                        FL_Button *btn =[localView viewWithTag:100+i];
                        btn.selected=NO;
                    }
                    button.selected = YES;
                    if (button.tag != 103) {
                        num =0;
                        if (button.tag ==100) {
                            [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                            self.type = [NSNumber numberWithInteger:1];
                            orderNumberNow = 0;
                        }
                        if (button.tag ==101) {
                            [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                            self.type = [NSNumber numberWithInteger:2];
                            orderNumberNow = 1;

                        }
                        //进度
                        if (button.tag ==102) {
                            [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                            self.type = [NSNumber numberWithInteger:3];
                            orderNumberNow = 2;
                        }
                        [UIView animateWithDuration:0.3f animations:^{
                        }];
                        [UIView animateWithDuration:0.3f animations:^{
                            _imageVRed.center=CGPointMake(button.center.x,_imageVRed.center.y );
                        } completion:^(BOOL finished) {
                            [self getGoodsList];
                        }];
                    }else{
                        //总需人次的第一次点击
                        button.selected=YES;
                        if (num %2 ==0) {
                            [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                            LWLog(@"总需人次的第一次点击");
                            [button setImage:[UIImage imageNamed:@"paixu_b"] forState:UIControlStateSelected];
                            self.type = [NSNumber numberWithInteger:5];
                            [self getGoodsList];
                            orderNumberNow = 3;
}
                        //总需人次的第二次点击
                        else{
                            [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                            LWLog(@"总需人次的第二次点击");
                            [button setImage:[UIImage imageNamed:@"paixu_a"] forState:UIControlStateSelected];
                            self.type = [NSNumber numberWithInteger:4];
                            
                            orderNumberNow = 4;

                        }
                        [UIView animateWithDuration:0.3f animations:^{
                        }];
                        [UIView animateWithDuration:0.3f animations:^{
                            _imageVRed.center=CGPointMake(button.center.x,_imageVRed.center.y );
                        } completion:^(BOOL finished) {
                            [self getGoodsList];
                        }];

                        num ++;
                        
                    }
                    
                }];
                
                [localView addSubview:button];

            }
            
            UIImageView *imageVBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, localView.frame.size.height-1, SCREEN_WIDTH, 1)];
//            imageVBack.image=[UIImage imageNamed:@"line_huise"];
            imageVBack.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
            _imageVRed.image=[UIImage imageNamed:@"line_red"];

            [localView addSubview:imageVBack];
            [localView addSubview:_imageVRed];
            
            if (_isFirstLoad == YES) {
                FL_Button *buttonHot=[localView viewWithTag:100];
                buttonHot.selected=YES;
                _isFirstLoad = NO;
                _imageVRed=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4-SCREEN_WIDTH/4*4/5)/2, localView.frame.size.height-1, SCREEN_WIDTH/4*4/5, 2)];
            }else{
                if (orderNumberNow >3) {
                    FL_Button *buttonClicked=[localView viewWithTag:100 + orderNumberNow - 1];
                    [buttonClicked setImage:[UIImage imageNamed:@"paixu_a"] forState:UIControlStateSelected];
                    buttonClicked.selected=YES;
                }else{
                    FL_Button *buttonClicked=[localView viewWithTag:100 + orderNumberNow ];
                    buttonClicked.selected=YES;
                    if (orderNumberNow == 3) {
                        [buttonClicked setImage:[UIImage imageNamed:@"paixu_b"] forState:UIControlStateSelected];

                    }
                }
            
            }

                [view addSubview:localView];
                _viewChoice = localView;
                
                view.backgroundColor=[UIColor whiteColor];
            
                return view;
          
            
        }
        return nil;
    }
    else{
        return nil;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        DetailViewController *detail=[[DetailViewController alloc]init];
        AppGoodsListModel *aModel=[[AppGoodsListModel alloc]init];
        aModel=_appGoodsList[indexPath.row];
        detail.joinModel = aModel;
        detail.goodsId=aModel.pid;
        detail.whichAPI=[NSNumber numberWithInteger:1];
        [self.navigationController pushViewController:detail animated:YES];    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 100) {
        if (indexPath.section == 0) {
            return  CGSizeMake(SCREEN_WIDTH, ADAPT_HEIGHT(440)+40+clearHeight);
        }else {
            if (KScreenWidth == 414) {
                
                return CGSizeMake([UIScreen mainScreen].bounds.size.width / 2 - 0.5, [UIScreen mainScreen].bounds.size.width / 2 * 1.32);
            }else {
                return CGSizeMake([UIScreen mainScreen].bounds.size.width / 2 - 0.5, [UIScreen mainScreen].bounds.size.width / 2 * 1.32);
            }
        }
    }
    else{
        return CGSizeMake(SCREEN_WIDTH-_imageVNotice.frame.origin.x-_imageVNotice.frame.size.width-5-20, labelHeight);    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (collectionView.tag == 100) {
        if (section == 0) {
            return CGSizeZero;
        }else {
            
            return CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
        }
        
    }
    else{
        return CGSizeZero;

    }
    
    
}
#pragma mark 轮播
//加载图片的代理，你自己想 怎么加载 就怎么加载
- (void)imageView:(UIImageView *)imageView loadImageForUrl:(NSString *)url{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"wtx"]];
}

//点击回调
- (void)bannerView:(CircleBannerView *)bannerView didSelectAtIndex:(NSUInteger)index {
    if (_appSlideList.count == 0) {
        return;
    }
    
    if (bannerView == self.headScrollView) {
        AppSlideListModel *slideM = _appSlideList[index];
        if ([slideM.goodsId isEqualToNumber:[NSNumber numberWithInteger:0]]) {
            DetailWebViewController *web = [[DetailWebViewController alloc] init];
            web.webURL = slideM.link;
            [self.navigationController pushViewController:web animated:YES];
        }else {
            DetailViewController *detail = [[DetailViewController alloc] init];
            detail.goodsId = slideM.goodsId;
            detail.whichAPI = [NSNumber numberWithInteger:1];
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.tabBarController.tabBar.hidden =NO;
}

#pragma mark 

- (void)_initCollectionView {
    XLPlainFlowLayout *flowLayout = [[XLPlainFlowLayout alloc] init];
    flowLayout.naviHeight = 0;
    if (KScreenWidth == 414) {
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 0.5;
    }else {
        flowLayout.minimumInteritemSpacing = 0.5;
        flowLayout.minimumLineSpacing = 1;
    }
    
    flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64 -5) collectionViewLayout:flowLayout];
    self.collectionView.tag=100;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor=COLOR_BACK_MAIN;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentify];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellHead];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identify];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:topIdentify];
    [self setupRefresh];
//    [self getAppNoticeList];

//    self.collectionView.
}

#pragma mark 支付成功后是否刷新红包

- (void)sendRedPocketYesOrNo{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:canSendRedPocketOrNot object:nil];
    [UserLoginTool loginRequestGet:@"judgeIfCanShareRedpackets" parame:nil success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            _sendRedNumber = json[@"resultData"][@"canShare"];
            _redShareInfo = json[@"resultData"][@"redShareInfo"];
            if ([_sendRedNumber isEqualToNumber:@1]) {
                [self createSendRedView];
            }
            
        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    
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


@end
