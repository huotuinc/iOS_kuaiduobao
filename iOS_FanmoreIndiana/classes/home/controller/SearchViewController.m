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
static NSString *cellSearch= @"cellSearch";
static BOOL isExist = NO;//用于判断归档时有无该对象
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *searchKey;

@property (nonatomic, strong) NSMutableArray *searchList;

@property (nonatomic, strong) UITableView *tableView;

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
        [SVProgressHUD showSuccessWithStatus:@"加入购物车成功"];
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [SVProgressHUD showSuccessWithStatus:@"加入购物车失败"];
        
        
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
            
            if (_tableView) {
                [_tableView reloadData];
            }else {
                [self createTableView];
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
    AppGoodsListModel *model=[[AppGoodsListModel alloc]init];
    model=_searchList[indexPath.row];
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
    cell.imageVSign.image = [UIImage imageNamed:@"line_touming"];
    if ([model.areaAmount integerValue] > 0) {
        cell.imageVSign.image=[UIImage imageNamed:@"zhuanqu_a"];
    }
    cell.buttonAdd.tag = 500 + indexPath.row;
    [cell.buttonAdd bk_whenTapped:^{
        NSInteger row = cell.buttonAdd.tag - 500;
        AppGoodsListModel * joinModel = _searchList[row];
        //加入购物车
        NSString * login = [[NSUserDefaults standardUserDefaults] objectForKey:LoginStatus];
        if ([login isEqualToString:Success]) {
#pragma mark 加入购物车 已登陆
            self.issueId = joinModel.issueId;
            [self joinShoppingCart];
        }else{
#pragma mark 加入购物车 未登陆
            NSMutableArray *localArray = [NSMutableArray array];
            //                    localArray =nil;
            //未进行归档
            if ([self getLocalDataArray] == nil) {
                CartModel *cModel = [[CartModel alloc] init];
                cModel.areaAmount = joinModel.areaAmount;
                cModel.attendAmount = joinModel.attendAmount;
                cModel.isSelect = joinModel.isSelect;
                cModel.pictureUrl = joinModel.pictureUrl;
                cModel.remainAmount = joinModel.remainAmount;
                cModel.sid = joinModel.sid;
                cModel.stepAmount = joinModel.stepAmount;
                cModel.title = joinModel.title;
                cModel.toAmount = joinModel.toAmount;
                cModel.issueId = joinModel.issueId;
                cModel.userBuyAmount = joinModel.defaultAmount;
                cModel.pricePercentAmount = joinModel.pricePercentAmount;
                
                [localArray addObject:cModel];
            }
            //已进行
            else{
                localArray =[NSMutableArray arrayWithArray:[self getLocalDataArray]];
                //查看本地是否已有这期商品
                for (int i =0; i<localArray.count; i++) {
                    CartModel *cModel = localArray[i];
                    //有
                    if ([cModel.issueId isEqualToNumber:joinModel.issueId ]) {
                        NSInteger prcie;
                        prcie = [model.buyAmount integerValue] + [joinModel.stepAmount integerValue];
                        cModel.userBuyAmount = [NSNumber numberWithInteger:prcie];
                        isExist = YES;
                    }
                }
                if (!isExist) {
                    CartModel *cModel = [[CartModel alloc] init];
                    cModel.areaAmount = joinModel.areaAmount;
                    cModel.attendAmount = joinModel.attendAmount;
                    cModel.userBuyAmount = joinModel.defaultAmount;
                    cModel.isSelect = joinModel.isSelect;
                    cModel.pictureUrl = joinModel.pictureUrl;
                    cModel.remainAmount = joinModel.remainAmount;
                    cModel.sid = joinModel.sid;
                    cModel.stepAmount = joinModel.stepAmount;
                    cModel.title = joinModel.title;
                    cModel.toAmount = joinModel.toAmount;
                    cModel.issueId = joinModel.issueId;
                    cModel.pricePercentAmount = joinModel.pricePercentAmount;
                    
                    [localArray addObject:cModel];
                    isExist = NO;
                }
            }
            NSMutableData *data = [[NSMutableData alloc] init];
            //创建归档辅助类
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
            //编码
            [archiver encodeObject:localArray forKey:LOCALCART];
            //结束编码
            [archiver finishEncoding];
            NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString * filename = [[array objectAtIndex:0] stringByAppendingPathComponent:LOCALCART];
            //写入
            [data writeToFile:filename atomically:YES];
            [SVProgressHUD showSuccessWithStatus:@"加入购物车成功"];
            

        }
    }];

    
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
    NSLog(@"点击了搜索");
    self.searchTitle = searchBar.text;
    [self getSearchList];
}

#pragma mark 解归档
- (NSArray *)getLocalDataArray{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filename = [[array objectAtIndex:0] stringByAppendingPathComponent:LOCALCART];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    // 2.创建反归档对象
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // 3.解码并存到数组中
    NSArray *namesArray = [unArchiver decodeObjectForKey:LOCALCART];
    return namesArray;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
