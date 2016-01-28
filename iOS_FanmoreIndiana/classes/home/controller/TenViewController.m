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


static NSString *cellTenMain=@"cellTenMain";

@interface TenViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *appGoodsList;

@end

@implementation TenViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.view.backgroundColor=[UIColor whiteColor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self createBarButtonItem];
    _appGoodsList=[NSMutableArray array];
    [self getAppGoodsList];
}
#pragma mark 网络请求专区商品列表
/**
 *  下拉刷新
 */
- (void)getAppGoodsList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"step"] = @10;
    
    [UserLoginTool loginRequestGet:@"getGoodsListByArea" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [AppGoodsListModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.appGoodsList removeAllObjects];
            [self.appGoodsList addObjectsFromArray:temp];
            [self createTableView];
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
    AppGoodsListModel *model = [self.appGoodsList lastObject];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"step"] = @10;
    
    [UserLoginTool loginRequestGet:@"getGoodsListByArea" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            NSArray *temp = [AppGoodsListModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.appGoodsList addObjectsFromArray:temp];
            
            [_tableView reloadData];
        }
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog (@"%@",error);
    }];
    
}
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TenTableViewCell" bundle:nil] forCellReuseIdentifier:cellTenMain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
}

-(void)createBarButtonItem{
    UIButton *buttonL=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
    [buttonL setBackgroundImage:[UIImage imageNamed:@"back_gray"] forState:UIControlStateNormal];
    [buttonL addTarget:self action:@selector(clickLightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiL=[[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem=bbiL;
    
//    UIButton *buttonR=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
//    [buttonR setBackgroundImage:[UIImage imageNamed:@"common_title_top_more"]forState:UIControlStateNormal];
//    [buttonR addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *bbiR=[[UIBarButtonItem alloc]initWithCustomView:buttonR];
//    self.navigationItem.rightBarButtonItem=bbiR;
}
-(void)clickLightButton{
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellTenMain forIndexPath:indexPath];
    AppGoodsListModel *model=[[AppGoodsListModel alloc]init];
    model=_appGoodsList[indexPath.row];
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
    if ([model.areaAmount isEqualToNumber:[NSNumber numberWithInteger:5]]) {
        cell.imageVSign.image=[UIImage imageNamed:@"zhuanqu_b"];
    }
    if ([model.areaAmount isEqualToNumber:[NSNumber numberWithInteger:10]]) {
        cell.imageVSign.image=[UIImage imageNamed:@"zhuanqu_a"];
    }
    
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

@end
