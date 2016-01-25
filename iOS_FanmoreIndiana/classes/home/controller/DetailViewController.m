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
static NSString * cellDTMain=@"cellDTMain";
@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong , nonatomic) UIView * headView;
@property (strong , nonatomic) UITableView * tableView;
@property (strong, nonatomic)  DCPicScrollView *headScrollView;//头部视图-轮播视图
@property (strong , nonatomic) UIView * titleView;//标题视图

@end

@implementation DetailViewController{
    NSMutableArray * _arrURLString;
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    _titleString=@"          但那是肯定那是靠近的那首多少级啊客户的撒空间互动大时间快点哈萨fcjbvcxvbcxvjbcxbvsdhfgds发的设计开发的时间回复的事发生的卡号发克";
    _titleStrHeight=[self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20-20, MAXFLOAT) font:[UIFont systemFontOfSize:FONT_SIZE(22)] string:_titleString].height;
    [self createDataArray];
    [self createHeadView];
    [self createTableView];
}
-(void)createDataArray{
    _arrURLString=[NSMutableArray arrayWithArray:@[@"http://p1.qqyou.com/pic/UploadPic/2013-3/19/2013031923222781617.jpg",
                                                   @"http://cdn.duitang.com/uploads/item/201409/27/20140927192649_NxVKT.thumb.700_0.png",
                                                   @"http://img4.duitang.com/uploads/item/201409/27/20140927192458_GcRxV.jpeg",
                                                   @"http://cdn.duitang.com/uploads/item/201304/20/20130420192413_TeRRP.thumb.700_0.jpeg"]];
}
-(void)createHeadView{
    _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_WIDTH(765))];
    
    _headScrollView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(390)) WithImageUrls:_arrURLString];
    [_headScrollView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("第%zd张图片\n",index);
    }];
    //default is 2.0f,如果小于0.5不自动播放
    _headScrollView.AutoScrollDelay = 2.0f;
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, ADAPT_HEIGHT(390), SCREEN_WIDTH, _titleStrHeight)];
    LWLog(@"%f",_titleStrHeight);
    [self createTitleLabel];
    [self createStateLabel];
    [_headView addSubview:_titleView];
    [_headView addSubview:_headScrollView];
}
-(void)createStateLabel{
    _titleStateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _titleStrHeight/_titleLineCount*3,_titleStrHeight/_titleLineCount)];
    _titleStateLabel.text=@"进行中";
    _titleStateLabel.textAlignment=NSTextAlignmentCenter;
    _titleStateLabel.font=[UIFont systemFontOfSize:FONT_SIZE(22)];
    _titleStateLabel.backgroundColor=[UIColor orangeColor];
    _titleStateLabel.layer.borderWidth=1;
    _titleStateLabel.layer.borderColor=[UIColor redColor].CGColor;
    _titleStateLabel.layer.masksToBounds=YES;
    _titleStateLabel.layer.cornerRadius=3;
    [_titleView addSubview:_titleStateLabel];
}
-(void)createTitleLabel{
    
    _titleLabel=[[UILabel alloc ]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, _titleStrHeight)];
    _titleLabel.text=_titleString;
    _titleLabel.font=[UIFont systemFontOfSize:FONT_SIZE(22)];
    _titleLabel.backgroundColor=[UIColor greenColor];
    _titleLabel.numberOfLines=0;
    
    _titleLineCount =(NSInteger)[self lineCountForLabel:_titleLabel];
    NSLog(@"%ld",(long)_titleLineCount);
    [_titleView addSubview:_titleLabel];
}
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"DetailAttendListMainTableViewCell" bundle:nil] forCellReuseIdentifier:cellDTMain];
    _tableView.tableHeaderView=_headView;
    _tableView.backgroundColor=[UIColor cyanColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailAttendListMainTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellDTMain forIndexPath:indexPath];
//    DetailAttendListMainTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellDTMain forIndexPath:indexPath];
    //    cell.labelTitle.text=_titleArray[indexPath.row];
    //    if (indexPath.row == 0) {
    //        cell.labelAdvice.text=@"建议wifi下查看";
    //    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
