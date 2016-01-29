//
//  DetailViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/25.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailAttendListMainTableViewCell.h"
#import "DCPicScrollView.h"
#import "DetailProgressCView.h"
#import "DetailNextTableViewCell.h"
#import "DetailAttendCountCView.h"
#import "DetailBottomCView.h"
#import "DetailWinnerCView.h"
#import "DetailTimeCView.h"
#import "AppGoodsDetailModel.h"
#import "DetailWebViewController.h"
static NSString *cellDNext=@"cellDNext";
static NSString * cellDTMain=@"cellDTMain";
@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView * headView;
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic)  DCPicScrollView *headScrollView;//头部视图-轮播视图
@property (strong, nonatomic) UIView * titleView;//标题视图
@property (strong, nonatomic) DetailProgressCView * progressView;//进度视图
@property (strong, nonatomic) DetailAttendCountCView * countView;//参加次数视图
@property (strong, nonatomic) DetailBottomCView * bottomView;//底部选项视图
@property (strong, nonatomic) DetailWinnerCView * winnerView;//获奖者
@property (strong, nonatomic) DetailTimeCView * timeView;//揭晓倒计时

@property (nonatomic, strong) NSMutableArray *goodsDetailList;
@property (nonatomic, strong) AppGoodsDetailModel *detailModel;

@end

@implementation DetailViewController{
    NSMutableArray * _arrURLString;
    NSMutableArray *_titleArray;
    UILabel *_titleStateLabel;//标题状态
    UILabel *_titleLabel;
    NSString *_titleString;//标题内容
    CGFloat _titleStrHeight;//标题高度
    NSInteger _titleLineCount;//标题行数
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden=YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self createBarButtonItem];
    _goodsDetailList=[NSMutableArray array];

    self.view.backgroundColor=[UIColor whiteColor];
//    _titleString=@"              Apple/苹果 iPhone6 全新未激活4.7寸美版 港版三网苹果6正品手机";

    [self getGoodsDetailList];
    [self createDataArray];
    [self createBottomView];
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
- (void)setupRefresh
{
    
    
    MJRefreshNormalHeader * headRe = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getGoodsDetailList)];
    _tableView.mj_header = headRe;
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(getNewData)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    //    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    //    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    //    self.tableView.headerRefreshingText = @"正在刷新最新数据,请稍等";
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    MJRefreshAutoNormalFooter * Footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreGoodsDetailList)];
    _tableView.mj_footer = Footer;
    
    //        [_tableView addFooterWithTarget:self action:@selector(getMoreGoodList)];
    
    
}
#pragma mark 网络请求商品列表
/**
 *  下拉刷新
 */
- (void)getGoodsDetailList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"goodsId"] = self.goodsId;
    [UserLoginTool loginRequestGet:@"getGoodsDetailByGoodsId" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            _detailModel = [AppGoodsDetailModel objectWithKeyValues:json[@"resultData"][@"data"]];
            
//            [self.goodsDetailList removeAllObjects];
//            [self.goodsDetailList addObject:model];
            [self createHeadView];
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
- (void)getMoreGoodsDetailList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"goodsId"] = self.goodsId;
    
    [UserLoginTool loginRequestGet:@"getGoodsDetailByGoodsId" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            AppGoodsDetailModel *model = [AppGoodsDetailModel objectWithKeyValues:json[@"resultData"][@"data"]];
            
            [self.goodsDetailList addObject:model];
            
            [_tableView reloadData];
        }
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog (@"%@",error);
    }];
    
}


-(void)createDataArray{
    _titleArray=[NSMutableArray arrayWithArray:@[@"图文详情",@"往期揭晓",@"晒单分享"]];
    _arrURLString=[NSMutableArray arrayWithArray:@[@"http://p1.qqyou.com/pic/UploadPic/2013-3/19/2013031923222781617.jpg",
                                                   @"http://cdn.duitang.com/uploads/item/201409/27/20140927192649_NxVKT.thumb.700_0.png",
                                                   @"http://img4.duitang.com/uploads/item/201409/27/20140927192458_GcRxV.jpeg",
                                                   @"http://cdn.duitang.com/uploads/item/201304/20/20130420192413_TeRRP.thumb.700_0.jpeg"]];
}
#pragma mark 构建头部视图
-(void)createHeadView{
    NSInteger num =[_detailModel.status integerValue];
    _titleStrHeight=[self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) font:[UIFont systemFontOfSize:FONT_SIZE(26)] string:[NSString stringWithFormat:@"              %@ %@",_detailModel.title,_detailModel.character]].height;
//已经结束
    if (num == 2) {
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_WIDTH(750)+_titleStrHeight)];
        
        _headScrollView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(390)) WithImageUrls:_detailModel.pictureUrl];
        [_headScrollView setImageViewDidTapAtIndex:^(NSInteger index) {
            printf("第%zd张图片\n",index);
        }];
        //default is 2.0f,如果小于0.5不自动播放
        _headScrollView.AutoScrollDelay = 0.0f;
        
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(10, ADAPT_HEIGHT(390), SCREEN_WIDTH-20, _titleStrHeight)];
        _titleView.backgroundColor=[UIColor whiteColor];
        [self createTitleLabel];
        [self createStateLabel];
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DetailWinnerCView" owner:nil options:nil];
        _winnerView= [nib firstObject];
        _winnerView.frame = CGRectMake(0, ADAPT_HEIGHT(390) + _titleStrHeight, SCREEN_WIDTH, ADAPT_HEIGHT(360));
        
        [_headView addSubview:_headScrollView];
        [_headView addSubview:_titleView];
        [_headView addSubview:_winnerView];
        
    }
//正在抽奖
    if (num == 1) {
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_WIDTH(610)+_titleStrHeight)];
        
        _headScrollView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(390)) WithImageUrls:_detailModel.pictureUrl];
        [_headScrollView setImageViewDidTapAtIndex:^(NSInteger index) {
            printf("第%zd张图片\n",index);
        }];
        //default is 2.0f,如果小于0.5不自动播放
        _headScrollView.AutoScrollDelay = 0.0f;
        
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(10, ADAPT_HEIGHT(390), SCREEN_WIDTH-20, _titleStrHeight)];
        _titleView.backgroundColor=[UIColor whiteColor];
        [self createTitleLabel];
        [self createStateLabel];
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DetailTimeCView" owner:nil options:nil];
        _timeView= [nib firstObject];
        _timeView.frame = CGRectMake(0, ADAPT_HEIGHT(390) + _titleStrHeight, SCREEN_WIDTH, ADAPT_HEIGHT(110));
        
        NSArray *nibA = [[NSBundle mainBundle]loadNibNamed:@"DetailAttendCountCView" owner:nil options:nil];
        _countView= [nibA firstObject];
        _countView.frame = CGRectMake(0, ADAPT_HEIGHT(500) + _titleStrHeight, SCREEN_WIDTH, ADAPT_HEIGHT(110));
        if (_titleArray.count > 0) {
            _countView.labelCount.hidden=NO;
            _countView.labelA.hidden=YES;
            _countView.labelB.hidden=YES;
            _countView.viewNext.hidden=YES;
        }else{
            _countView.labelCount.hidden=YES;
            _countView.labelA.hidden=NO;
            _countView.labelB.hidden=NO;
            _countView.viewNext.hidden=NO;
        }
        
        [_headView addSubview:_headScrollView];
        [_headView addSubview:_titleView];
        [_headView addSubview:_timeView];
        [_headView addSubview:_countView];
    }
//正在进行
    if (num == 0) {
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_WIDTH(610)+_titleStrHeight)];
        
        _headScrollView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(390)) WithImageUrls:_detailModel.pictureUrl];
        [_headScrollView setImageViewDidTapAtIndex:^(NSInteger index) {
            printf("第%zd张图片\n",index);
        }];
        //default is 2.0f,如果小于0.5不自动播放
        _headScrollView.AutoScrollDelay = 2.0f;
        
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(10, ADAPT_HEIGHT(390), SCREEN_WIDTH-20, _titleStrHeight)];
        _titleView.backgroundColor=[UIColor whiteColor];
        
        [self createTitleLabel];
        [self createStateLabel];
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DetailProgressCView" owner:nil options:nil];
        _progressView= [nib firstObject];
        _progressView.frame = CGRectMake(0, ADAPT_HEIGHT(390) + _titleStrHeight, SCREEN_WIDTH, ADAPT_HEIGHT(110));
        NSMutableAttributedString *attString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"剩余: %@",_detailModel.remainAmount]];
        [attString addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_CONTENT range:NSMakeRange(0, 3)];
        _progressView.labelRest.attributedText=attString;
        _progressView.labelTotal.text=[NSString stringWithFormat:@"总需: %@人次",_detailModel.toAmount];
        _progressView.labelTerm.text=[NSString stringWithFormat:@"期号: %@",_detailModel.issueId];
        CGFloat percent=(_detailModel.toAmount.floatValue -_detailModel.remainAmount.floatValue)/(_detailModel.toAmount.floatValue);
        _progressView.viewProgress.progress=percent;
        
        NSArray *nibA = [[NSBundle mainBundle]loadNibNamed:@"DetailAttendCountCView" owner:nil options:nil];
        _countView= [nibA firstObject];
        _countView.frame = CGRectMake(0, ADAPT_HEIGHT(500) + _titleStrHeight, SCREEN_WIDTH, ADAPT_HEIGHT(110));
        if (_detailModel.numbers.count > 0) {
            NSMutableAttributedString *attString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"您参与了%ld人次",_detailModel.numbers.count]];
            [attString addAttribute:NSForegroundColorAttributeName value:COLOR_SHINE_RED range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",_detailModel.numbers.count].length)];
            _countView.labelA.attributedText=attString;
            _countView.labelB.text=@"点击查看号码";
            _countView.labelCount.hidden=YES;
            _countView.labelA.hidden=NO;
            _countView.labelB.hidden=NO;
            _countView.viewNext.hidden=NO;
            [_countView.viewNext bk_whenTapped:^{
                LWLog(@"0000000");
            }];
        }else{
            _countView.labelCount.hidden=NO;
            _countView.labelA.hidden=YES;
            _countView.labelB.hidden=YES;
            _countView.viewNext.hidden=YES;
        }
        [_headView addSubview:_countView];
        [_headView addSubview:_progressView];
        [_headView addSubview:_titleView];
        [_headView addSubview:_headScrollView];
    }
        
    
    
    
}
#pragma mark 底部选项
-(void)createBottomView{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"DetailBottomCView" owner:nil options:nil];
    _bottomView=[nib firstObject];
    _bottomView.frame=CGRectMake(0, SCREEN_HEIGHT-ADAPT_HEIGHT(100)-64, SCREEN_WIDTH, ADAPT_HEIGHT(100));
    [self.view addSubview:_bottomView];
}
-(void)createStateLabel{
    _titleStateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _titleStrHeight/_titleLineCount*3,_titleStrHeight/_titleLineCount)];
    if ([_detailModel.status isEqualToNumber:[NSNumber numberWithInteger:0]]) {
        _titleStateLabel.text=@"进行中";
    }
    if ([_detailModel.status isEqualToNumber:[NSNumber numberWithInteger:12]]) {
        _titleStateLabel.text=@"已揭晓";
    }
    _titleStateLabel.textAlignment=NSTextAlignmentCenter;
    _titleStateLabel.font=[UIFont systemFontOfSize:FONT_SIZE(26)];
    _titleStateLabel.layer.borderWidth=1;
    _titleStateLabel.layer.borderColor=[UIColor redColor].CGColor;
    _titleStateLabel.layer.masksToBounds=YES;
    _titleStateLabel.layer.cornerRadius=3;
    [_titleView addSubview:_titleStateLabel];
}
-(void)createTitleLabel{
    
    _titleLabel=[[UILabel alloc ]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, _titleStrHeight)];
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"              %@ %@",_detailModel.title,_detailModel.character]];
    [attString addAttribute:NSForegroundColorAttributeName value:COLOR_SHINE_RED range:NSMakeRange(14+_detailModel.title.length+1,_detailModel.character.length)];
    _titleLabel.attributedText=attString;
    _titleLabel.font=[UIFont systemFontOfSize:FONT_SIZE(26)];
    _titleLabel.numberOfLines=0;
    
    _titleLineCount =(NSInteger)[self lineCountForLabel:_titleLabel];
    NSLog(@"%ld",(long)_titleLineCount);
    [_titleView addSubview:_titleLabel];
}
#pragma mark 创建tableView
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-ADAPT_HEIGHT(100)) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailAttendListMainTableViewCell" bundle:nil] forCellReuseIdentifier:cellDTMain];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailNextTableViewCell" bundle:nil] forCellReuseIdentifier:cellDNext];
    _tableView.tableHeaderView=_headView;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    [self setupRefresh];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailNextTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellDNext forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.labelTitle.text=_titleArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.labelAdvice.text=@"建议wifi下查看";
        }
    }else{
        cell.labelTitle.text=@"所有参与记录";
        cell.labelAdvice.text=@"(2016 - 10 - 12 16 : 50 :47 开始)";
    
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        if (indexPath.row == 0) {
            DetailWebViewController *web=[[DetailWebViewController alloc]init];
            web.webURL=_detailModel.link;
            [self.navigationController pushViewController:web animated:YES];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ADAPT_HEIGHT(50);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ADAPT_HEIGHT(120);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
 *  计算label行数
 *
 *  @param label <#label description#>
 *
 *  @return <#return value description#>
 */
- (int)lineCountForLabel:(UILabel *)label {
    CGSize constrain = CGSizeMake(label.bounds.size.width, FLT_MAX);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
    
    return ceil(size.height / label.font.lineHeight);
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
