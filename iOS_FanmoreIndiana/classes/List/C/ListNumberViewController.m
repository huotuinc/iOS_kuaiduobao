//
//  ListNumberViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/3.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ListNumberViewController.h"
#import "ListNumberHeadCView.h"
#import "ListNumberBottomCView.h"
#import "ListNumberTopTableViewCell.h"
#import "ListNumberMainTableViewCell.h"
static NSString * cellLNTop = @"cellLNTop";
static NSString * cellLNMain = @"cellLNMain";
@interface ListNumberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ListNumberHeadCView *headView;
@property (nonatomic,strong) ListNumberBottomCView *footerView;

@end

@implementation ListNumberViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden=YES;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.view.backgroundColor=[UIColor whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBarButtonItem];
    [self createHeadView];
    [self createFooterView];
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
-(void)createHeadView{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ListNumberHeadCView" owner:nil options:nil];
    _headView=[nib firstObject];
    _headView.frame=CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(300));
    [_headView.buttonGo bk_whenTapped:^{
        
    }];
    [_headView.buttonLook bk_whenTapped:^{
        
    }];
    
}
- (void)createFooterView{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ListNumberBottomCView" owner:nil options:nil];
    _footerView=[nib firstObject];
    _footerView.frame=CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(50));

}
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ListNumberTopTableViewCell" bundle:nil] forCellReuseIdentifier:cellLNTop];
    [_tableView registerNib:[UINib nibWithNibName:@"ListNumberMainTableViewCell" bundle:nil] forCellReuseIdentifier:cellLNTop];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableHeaderView=_headView;
    _tableView.tableFooterView=_footerView;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}
#pragma mark UITableViewDelegate
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        ListNumberTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellLNTop forIndexPath:indexPath];
//        
//    }
//    
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    return cell;
//    
//    
//}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//    
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return (_numberArray.count/5 +1);
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ADAPT_HEIGHT(190);
    }else {
        return ADAPT_HEIGHT(50);
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
