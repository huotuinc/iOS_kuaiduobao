//
//  TenViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/21.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "TenViewController.h"
#import "TenTableViewCell.h"
#import "AppGoodsListModel.h"
#import <UIImageView+WebCache.h>
#import "DetailViewController.h"
#import "ArchiveLocalData.h"
static NSString *cellTenMain=@"cellTenMain";

@interface TenViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *appGoodsList;
@property (nonatomic, strong) NSString * tenAPI;

@end

@implementation TenViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden =YES;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    if (self.whichAPI == 1) {
        [self.navigationItem changeNavgationBarTitle:self.tenTitle];
    } else if (self.whichAPI == 2) {
        [self.navigationItem changeNavgationBarTitle:self.tenTitle];
    } else if (self.whichAPI == 3) {
        [self.navigationItem changeNavgationBarTitle:self.tenTitle];
    } else if (self.whichAPI == 4) {
        [self.navigationItem changeNavgationBarTitle:self.tenTitle];
    } else {
        [self.navigationItem changeNavgationBarTitle:@"专区商品"];
    }
    self.view.backgroundColor=[UIColor whiteColor];
    [self createBarButtonItem];
    [self getAppGoodsList];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBarButtonItem];
    if (self.whichAPI == 1) {
        _tenAPI = @"getGoodsListByArea";
    } else if (self.whichAPI == 2) {
        _tenAPI = @"getGoodsListByAllCategory";
    } else if (self.whichAPI == 3) {
        _tenAPI = @"getGoodsListByCategory";
    } else if (self.whichAPI == 4) {
        _tenAPI = @"getGoodsListByOtherCategory";
    }
    _appGoodsList=[NSMutableArray array];
    [self createTableView];
}
- (void)createBarButtonItem{

    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:COLOR_NAV_BACK];
}
- (void)setupRefresh
{
    [self.tableView removeSpaces];

    MJRefreshNormalHeader * headRe = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getAppGoodsList)];
    _tableView.mj_header = headRe;
    
    MJRefreshAutoFooter * Footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreGoodsList)];
    _tableView.mj_footer = Footer;

}

//1 10元专区进去 2 全部进入(有分页参数) 3商品分类(pid)进入 4其他进入(有分页参数)
#pragma mark 网络请求专区商品列表
/**
 *  下拉刷新
 */
- (void)getAppGoodsList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (_whichAPI == 1 || _whichAPI == 3) {
        if (_whichAPI == 3) {
            dic[@"categoryId"] = self.pid;
        }
    }else {
        dic[@"lastSort"] =@0;
    }
    [UserLoginTool loginRequestGet:_tenAPI parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [AppGoodsListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            self.lastSort =json[@"resultData"][@"sort"];
            [self.appGoodsList removeAllObjects];
            [self.appGoodsList addObjectsFromArray:temp];
            [_tableView reloadData];

        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
        [_tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    
}

/**
 *  上拉加载更多
 */
- (void)getMoreGoodsList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (_whichAPI == 1 || _whichAPI == 3) {
        
    }else {
        dic[@"lastSort"] =self.lastSort;
    }
    [UserLoginTool loginRequestGet:_tenAPI parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            NSArray *temp = [AppGoodsListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            self.lastSort =json[@"resultData"][@"sort"];
            [self.appGoodsList addObjectsFromArray:temp];
            [_tableView reloadData];
        }
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        LWLog (@"%@",error);
    }];
    
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
        [SVProgressHUD showSuccessWithStatus:@"加入清单失败"];
    } withFileKey:nil];
}
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TenTableViewCell" bundle:nil] forCellReuseIdentifier:cellTenMain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    if (_whichAPI == 1 || _whichAPI == 3) {
    }else {
        [self setupRefresh];
    }
    
    [_tableView removeSpaces];
}


#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellTenMain forIndexPath:indexPath];
    AppGoodsListModel *model=_appGoodsList[indexPath.row];
    cell.labelTitle.text=model.title;
    
    NSMutableAttributedString *attStringA = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总需 %ld",(long)[model.toAmount integerValue]]];
    [attStringA addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_DATE range:NSMakeRange(0,2)];
    cell.labelTotal.attributedText=attStringA;
    
    NSMutableAttributedString *attStringB = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"剩余 %ld",(long)[model.remainAmount integerValue]]];
    [attStringB addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_DATE range:NSMakeRange(0,2)];
    cell.labelRest.attributedText=attStringB;

    CGFloat percent=(model.toAmount.floatValue -model.remainAmount.floatValue)/(model.toAmount.floatValue);
    cell.viewProgress.progress=percent;
    [cell.imageVGoods sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl]];
    cell.imageVSign.image = [UIImage imageNamed:@""];
    if ([model.areaAmount integerValue] > 0) {
        cell.imageVSign.image=[UIImage imageNamed:@"zhuanqu_a"];
    }
    cell.buttonAdd.tag = 500 +indexPath.row;
    [cell.buttonAdd addTarget:self action:@selector(clickButtonAdd:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.buttonAdd bk_whenTapped:^{
//        NSInteger row = cell.buttonAdd.tag - 500;
//        AppGoodsListModel *GoodM = _appGoodsList[row];
//        NSString * login = [[NSUserDefaults standardUserDefaults] objectForKey:LoginStatus];
//        if ([login isEqualToString:Success]) {
//#pragma mark 加入购物车 已登陆
//            self.issueId = GoodM.issueId;
//            [self joinShoppingCart];
//        }else{
//#pragma mark 加入购物车 未登陆
//            [ArchiveLocalData archiveLocalDataArrayWithGoodsModel:GoodM];
//            [SVProgressHUD showSuccessWithStatus:@"加入清单成功"];
//        }
//    }];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _appGoodsList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ADAPT_HEIGHT(200);
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail = [[DetailViewController alloc] init];
    AppGoodsListModel *model = _appGoodsList[indexPath.row];
    detail.goodsId = model.pid;
    detail.whichAPI = [NSNumber numberWithInteger:1];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)clickButtonAdd:(UIButton *)buttonAdd {
    NSInteger row = buttonAdd.tag - 500;
    AppGoodsListModel *GoodM = _appGoodsList[row];
    NSString * login = [[NSUserDefaults standardUserDefaults] objectForKey:LoginStatus];
    if ([login isEqualToString:Success]) {
#pragma mark 加入购物车 已登陆
        self.issueId = GoodM.issueId;
        [self joinShoppingCart];
    }else{
#pragma mark 加入购物车 未登陆
        [ArchiveLocalData archiveLocalDataArrayWithGoodsModel:GoodM];
        [SVProgressHUD showSuccessWithStatus:@"加入清单成功"];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
