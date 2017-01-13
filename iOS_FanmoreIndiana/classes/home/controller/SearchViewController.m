//
//  SearchViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "SearchViewController.h"
#import "AppGoodsListModel.h"
#import "TenTableViewCell.h"
#import "DetailViewController.h"
#import "CartModel.h"
#import "ArchiveLocalData.h"
static NSString *cellSearch= @"cellSearch";
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *searchKey;

@property (nonatomic, strong) NSMutableArray *searchList;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *imageVNone;

@end

@implementation SearchViewController{
    UISearchBar * _search;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden=YES;
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchList = [NSMutableArray array];
    [self createSearchBar];
    [self createImageVNone];
    [self createTableView];
}
- (void)createImageVNone {
    _imageVNone = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _imageVNone.image = [UIImage imageNamed:@"wss"];
    [self.view addSubview:_imageVNone];
}
#pragma mark  网络加入购物车
-(void)joinShoppingCart {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"issueId"] = self.issueId;
    [UserLoginTool loginRequestPostWithFile:@"joinShoppingCart" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            LWLog(@"%@",json[@"resultDescription"]);
            [SVProgressHUD showSuccessWithStatus:@"加入清单成功"];
        }else {
            LWLog(@"%@",json[@"resultDescription"]);
            [SVProgressHUD showSuccessWithStatus:@"加入清单失败"];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    } withFileKey:nil];
}
#pragma mark 请求搜索结果列表
- (void)getSearchList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"title"] = self.searchTitle;
    [UserLoginTool loginRequestGet:@"searchGoods" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            NSArray *temp = [AppGoodsListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.searchList removeAllObjects];
            [self.searchList addObjectsFromArray:temp];
            if (self.searchList.count == 0) {
                _tableView.hidden = YES;
                _imageVNone.hidden =NO;
            }else {
                _imageVNone.hidden =YES;
                _tableView.hidden = NO;
                if (_tableView) {
                    [_tableView reloadData];
                } else {
                }
            }
            [_search resignFirstResponder];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
}
-(void)createSearchBar{
    _search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH , 44)];
    _search.placeholder=@"搜索";
    _search.delegate=self;
    _search.showsCancelButton=YES;
    [_search setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    _search.barTintColor = [UIColor whiteColor];
    for (UIView* subview in [[_search.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subview;
            [textField setBackgroundColor:COLOR_BACK_MAIN];      //修改输入框的颜色
        }
    }
    for(UIView *view in  [[[_search subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:COLOR_BACK_MAIN forState:UIControlStateNormal];
            cancel.titleLabel.font=[UIFont systemFontOfSize:FONT_SIZE(26)];
            [cancel setTitleColor:COLOR_TEXT_TITILE forState:UIControlStateNormal];
            [cancel addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    [_search becomeFirstResponder];
    [self.view addSubview:_search];
}
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64 -44) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TenTableViewCell" bundle:nil] forCellReuseIdentifier:cellSearch];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.view addSubview:_tableView];
}
-(void)clickLightButton{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickCancelButton{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellSearch forIndexPath:indexPath];
    AppGoodsListModel *model=_searchList[indexPath.row];;
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
    cell.buttonAdd.tag = 500 + indexPath.row;
    [cell.buttonAdd addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.buttonAdd bk_whenTapped:^{
//        NSInteger row = cell.buttonAdd.tag - 500;
//        AppGoodsListModel * joinModel = _searchList[row];
//        //加入购物车
//        NSString * login = [[NSUserDefaults standardUserDefaults] objectForKey:LoginStatus];
//        if ([login isEqualToString:Success]) {
//#pragma mark 加入购物车 已登陆
//            self.issueId = joinModel.issueId;
//            [self joinShoppingCart];
//        }else{
//#pragma mark 加入购物车 未登陆
//            [ArchiveLocalData archiveLocalDataArrayWithGoodsModel:joinModel];
//            [SVProgressHUD showSuccessWithStatus:@"加入清单成功"];
//        }
//    }];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchList == nil) {
        return 0;
    }else {
        return _searchList.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ADAPT_HEIGHT(200);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail = [[DetailViewController alloc] init];
    AppGoodsListModel *model = _searchList[indexPath.row];
    detail.goodsId = model.pid;
    detail.whichAPI = [NSNumber numberWithInteger:1];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark 搜索方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchTitle = searchBar.text;
    [self getSearchList];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    
}
- (void)clickAddButton:(UIButton *)buttonAdd {
    NSInteger row = buttonAdd.tag - 500;
    AppGoodsListModel * joinModel = _searchList[row];
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
