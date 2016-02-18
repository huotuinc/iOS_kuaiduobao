//
//  DetailNumberViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/1.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "DetailNumberViewController.h"
#import "DetailNumberHeadCView.h"
#import "DetailNumberTableViewCell.h"

static NSString *cellDNumbers=@"cellDNumbers";

@interface DetailNumberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) DetailNumberHeadCView *headView;

@end

@implementation DetailNumberViewController

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
//中奖号码
-(void)createHeadView{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"DetailNumberHeadCView" owner:nil options:nil];
    _headView=[nib firstObject];
    _headView.frame=CGRectMake(0, 64, SCREEN_WIDTH, ADAPT_HEIGHT(180));
    _headView.labelTitle.text=self.goodsName;
    _headView.labelItem.text = [NSString stringWithFormat:@"期号: %@",self.issueId];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"参与了%ld人次, 以下是所有夺宝号码:",self.numberArray.count]];
    [attString addAttribute:NSForegroundColorAttributeName value:COLOR_SHINE_RED range:NSMakeRange(3, [NSString stringWithFormat:@"%ld",self.numberArray.count].length)];
    _headView.labelAttend.attributedText=attString;
    
}
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];

    [_tableView registerNib:[UINib nibWithNibName:@"DetailNumberTableViewCell" bundle:nil] forCellReuseIdentifier:cellDNumbers];
    _tableView.delegate=self;
    _tableView.dataSource=self;
        _tableView.tableHeaderView=_headView;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}
#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDNumbers forIndexPath:indexPath];

    if (_numberArray.count > (indexPath.row + 1) *5 ) {
        for (int i =0 ; i<5; i++) {
            UILabel *label=[cell viewWithTag:100+i];
            label.text=[NSString stringWithFormat:@"%@",_numberArray[indexPath.row*5 + i]];
        }
    }else{
        int rest = (int)(_numberArray.count -indexPath.row *5);
        for (int j =0; j< rest; j++) {
            UILabel *label=[cell viewWithTag:100+j];
            label.text=[NSString stringWithFormat:@"%@",_numberArray[indexPath.row *5 + j]];
        }
        for (int j =rest; j< 5; j++) {
            UILabel *label=[cell viewWithTag:100+j];
            label.text=@"";
        }
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (_numberArray.count/5 +1);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return ADAPT_HEIGHT(50);
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
