//
//  ClassViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/21.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassATableViewCell.h"
#import "ClassBTableViewCell.h"
#import "AppCategoryListModel.h"
#import "TenViewController.h"
static NSString *cellClassA=@"cellClassA";
static NSString *cellClassB=@"cellClassB";

@interface ClassViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *titleList;


@end

@implementation ClassViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleList = [NSMutableArray array];
    [self createBarButtonItem];
    // Do any additional setup after loading the view.
    [self getTitleList];
}
- (void)getTitleList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"lastId"] = @0;
    [UserLoginTool loginRequestGet:@"getCategoryList" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [AppCategoryListModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.titleList removeAllObjects];
            [self.titleList addObjectsFromArray:temp];
            if (_tableView) {
                [self createTableView];
            }else {
                [_tableView reloadData];
            }
        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    
}


-(void)createBarButtonItem{
    UIButton *buttonL=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [buttonL setBackgroundImage:[UIImage imageNamed:@"back_gray"] forState:UIControlStateNormal];
    [buttonL addTarget:self action:@selector(clickLightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiL=[[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem=bbiL;
}
-(void)clickLightButton{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void) createTitleArray{
//    _titleArray = [NSMutableArray arrayWithArray:@[@"全部商品",@"分类浏览",@"十元夺宝",@"手机平板",@"电脑办公",@"数码影音",@"女性时尚",@"美食天地",@"潮流新品",@"其它商品"]];
//
//}
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"ClassATableViewCell" bundle:nil]forCellReuseIdentifier:cellClassA];
    [_tableView registerNib:[UINib nibWithNibName:@"ClassBTableViewCell" bundle:nil]forCellReuseIdentifier:cellClassB];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}
#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ClassATableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellClassA forIndexPath:indexPath];
        cell.labelClass.text=@"全部商品";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 1) {
        ClassBTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellClassB forIndexPath:indexPath];
        cell.labelClassB.text=@"分类浏览";
        cell.labelClassB.font=[UIFont systemFontOfSize:FONT_SIZE(22)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row >1){
        ClassBTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellClassB forIndexPath:indexPath];
        AppCategoryListModel *model =_titleList[indexPath.row - 2];
        cell.labelClassB.text=model.title;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleList.count +1 ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ADAPT_HEIGHT(130);
    }else if (indexPath.row == 1) {
        return ADAPT_HEIGHT(70);
    }else{
        return ADAPT_HEIGHT(100);
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TenViewController *ten = [[TenViewController alloc]init];
    AppCategoryListModel *model = _titleList[indexPath.row];
    ten.step = model.pid;
    ten.whichAPI = 2;
    [self.navigationController pushViewController:ten animated:YES];
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
