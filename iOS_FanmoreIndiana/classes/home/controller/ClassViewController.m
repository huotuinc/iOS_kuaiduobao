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
static NSString *cellClassA=@"cellClassA";
static NSString *cellClassB=@"cellClassB";

@interface ClassViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *titleArray;


@end

@implementation ClassViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarButtonItem];
    // Do any additional setup after loading the view.
    [self createTitleArray];
    [self createTableView];
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

-(void) createTitleArray{
    _titleArray = [NSMutableArray arrayWithArray:@[@"全部商品",@"分类浏览",@"十元夺宝",@"手机平板",@"电脑办公",@"数码影音",@"女性时尚",@"美食天地",@"潮流新品",@"其它商品"]];

}
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
        cell.labelClass.text=_titleArray[indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ClassBTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellClassB forIndexPath:indexPath];
        cell.labelClassB.text=_titleArray[indexPath.row];
        return cell;
    }
    
    
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count ;
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
