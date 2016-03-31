//
//  DetailShareNextViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/24.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "DetailShareNextViewController.h"
#import "DetailShareNextHeadTableViewCell.h"
#import "DetailShareNextContentTableViewCell.h"
#import "DetailShareNextImageVTableViewCell.h"
#import "AppShareOrderDetailModel.h"
static NSString *cellDNHead = @"cellDNHead";
static NSString *cellDNContent = @"cellDNContent";
static NSString *cellDNimageV = @"cellDNimageV";

@interface DetailShareNextViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * detailList;
@property (nonatomic,strong) AppShareOrderDetailModel * shareModel;
@property (nonatomic,strong) UIView * bottomView;


@end

@implementation DetailShareNextViewController{

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationItem changeNavgationBarTitle:@"晒单详情"];
    [self getDetailShareList];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBarButtonItem];
    [self createTableView];
}


- (void)setupRefresh
{
    
    
    MJRefreshNormalHeader * headRe = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDetailShareList)];
    _tableView.mj_header = headRe;

    
    
}
-(void)createBarButtonItem{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:COLOR_NAV_BACK];
    

}


#pragma mark 网络请求晒单列表

- (void)getDetailShareList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"id"] = self.shareId;
    
    [UserLoginTool loginRequestGet:@"getShareOrderDetail" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            _shareModel = [AppShareOrderDetailModel mj_objectWithKeyValues:json[@"resultData"][@"data"]];
            
            [_tableView reloadData];

        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
        [_tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    
}

- (void)createBottomView{
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_WIDTH(50))];
}
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailShareNextHeadTableViewCell" bundle:nil] forCellReuseIdentifier:cellDNHead];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailShareNextContentTableViewCell" bundle:nil] forCellReuseIdentifier:cellDNContent];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailShareNextImageVTableViewCell" bundle:nil] forCellReuseIdentifier:cellDNimageV];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self setupRefresh];
    
}


#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        DetailShareNextHeadTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellDNHead forIndexPath:indexPath];
        
        cell.labelTitle.text = _shareModel.shareOrderTitle;
        cell.labelName.text = _shareModel.nickName;
        cell.labelDate.text = [self changeTheTimeStamps:_shareModel.time andTheDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        cell.labelGoods.text = _shareModel.title;
        cell.labelIssued.text =_shareModel.issueNo;
        NSMutableAttributedString *attendString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人次",_shareModel.attendAmount]];
        [attendString addAttribute:NSForegroundColorAttributeName value:COLOR_TEN_RED range:NSMakeRange(0, [NSString stringWithFormat:@"%@",_shareModel.attendAmount].length)];
        cell.labelAttend.attributedText=attendString;
        cell.labelNumber.text = [NSString stringWithFormat:@"%@",_shareModel.luckNumber];
        cell.labelAnncounedTime.text = [self changeTheTimeStamps:_shareModel.lotteryTime andTheDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1) {
        DetailShareNextContentTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellDNContent forIndexPath:indexPath];
        cell.labelContent.text= _shareModel.content;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        DetailShareNextImageVTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellDNimageV forIndexPath:indexPath];
        if (indexPath.row != _shareModel.pictureUrls.count + 1) {
            cell.imageVLine.hidden =YES;
        }
        [cell.imageVGoods sd_setImageWithURL:[NSURL URLWithString:_shareModel.pictureUrls[indexPath.row - 2]] placeholderImage:[UIImage imageNamed:@"mrtx"]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2 + _shareModel.pictureUrls.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ADAPT_HEIGHT(340) + 10.f;
    }else if (indexPath.row == 1) {
        return [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, MAXFLOAT) font:[UIFont systemFontOfSize:FONT_SIZE(22)] string:_shareModel.content].height +1.0f;
            }else {
        return ADAPT_HEIGHT(500);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_WIDTH(50))];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return ADAPT_HEIGHT(50);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/**
 *  计算label高度
 *
 *  @param size <#size description#>
 *  @param font <#font description#>
 *  @param str  <#str description#>
 *
 *  @return <#return value description#>
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont *)font string:(NSString *)str
{
    NSDictionary *attribute = @{NSFontAttributeName : font};
    CGSize retSize = [str boundingRectWithSize:size
                                       options:
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize;
}
/**
 *  13位时间戳转为正常时间(可设置样式)
 *
 *  @param time 时间戳
 *
 *  @return
 */
-(NSString *)changeTheTimeStamps:(NSNumber *)time andTheDateFormat:(NSString *)dateFormat{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:dateFormat];
    //将13位时间戳转为正常时间格式
    NSString * str = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[time doubleValue] / 1000]];
    return str;
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
