//
//  HomeController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/18.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "HomeController.h"
#import "XLPlainFlowLayout.h"
#import "HomeCollectionViewCell.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "HomeFourBtnCView.h"
#import "labelCollectionViewCell.h"
#import "HomeHeadCollectionViewCell.h"
#import "TenViewController.h"
#import "DetailViewController.h"
#import "ClassViewController.h"
#import "FL_Button.h"
#import "AppGoodsListModel.h"
@interface HomeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)  UICollectionView *collectionView;
@property (strong, nonatomic)  DCPicScrollView *headScrollView;//头部视图-轮播视图
@property (strong, nonatomic)  HomeFourBtnCView *fourBtnView;//头部视图-四个按钮
@property (strong, nonatomic)  UICollectionView *labelCollectionView;//头部视图-中奖信息
@property (strong, nonatomic)  UIImageView *imageVNotice;//头部视图-提醒
@property (strong, nonatomic)  UIView *headView;//头部视图
@property (strong, nonatomic)  UIView *clearView;//分割的View
@property (strong, nonatomic)  NSTimer *timer;//定时器
@property (strong , nonatomic) UIImageView *imageVRed;//中间四个选项 下划线
@property (strong , nonatomic) UIView *viewChoice;//中间四个选项
@property (strong, nonatomic)  UIImageView *imageV;//头部视图-提醒

@property (nonatomic, strong) NSMutableArray *appGoodsList;

@property (nonatomic, strong) NSNumber *lastSort;



@end

@implementation HomeController{
    NSMutableArray *_arrURLString;
    NSMutableArray *_arrTitle;

}


static NSString *identify = @"homeCellIdentify";
static NSString *headIdentify = @"homeCellHeadIdentify";
static NSString *topIdentify = @"homeCellTopIdentify";
static NSString *cellLabel = @"homeCellLabel";
static NSString *cellHead = @"homeCellHead";

static CGFloat labelHeight = 20;//中奖信息CollectionView高度
static CGFloat clearHeight = 10;//中奖信息CollectionView高度
static NSInteger num=0;//记录总需人数的点击次数


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = [NSNumber numberWithInteger:1];
    _appGoodsList=[NSMutableArray array];

    [self getGoodsList];
    
    [self createArrURLString];
    [self createHeadView];

    self.view.backgroundColor = [UIColor whiteColor];

    

}
-(void)createMainCollectionView{
    XLPlainFlowLayout *flowLayout = [[XLPlainFlowLayout alloc] init];
    flowLayout.naviHeight = 0;
    flowLayout.minimumInteritemSpacing = 0.5;
    flowLayout.minimumLineSpacing = 1;
    flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64) collectionViewLayout:flowLayout];
    self.collectionView.tag=100;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentify];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellHead];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identify];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:topIdentify];
    [self setupRefresh];
}
- (void)setupRefresh
{
    
    
    MJRefreshNormalHeader * headRe = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getGoodsList)];
    _collectionView.mj_header = headRe;
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(getNewData)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    //    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    //    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    //    self.tableView.headerRefreshingText = @"正在刷新最新数据,请稍等";
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    MJRefreshAutoNormalFooter * Footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreGoodsList)];
    _collectionView.mj_footer = Footer;
    
    //        [_tableView addFooterWithTarget:self action:@selector(getMoreGoodList)];
    
    
}
#pragma mark 网络请求商品列表
/**
 *  下拉刷新
 */
- (void)getGoodsList {
    [SVProgressHUD show];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = self.type;
    dic[@"lastSort"]= @0;
    
    [UserLoginTool loginRequestGet:@"getGoodsListByIndex" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [AppGoodsListModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            self.lastSort =json[@"resultData"][@"sort"];
            [self.appGoodsList removeAllObjects];
            [self.appGoodsList addObjectsFromArray:temp];
            [self createMainCollectionView];
            [_collectionView reloadData];
        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
        [SVProgressHUD dismiss];
        [_collectionView.mj_header endRefreshing];
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
    dic[@"type"] = self.type;
    dic[@"lastSort"]= self.lastSort;
    
    [UserLoginTool loginRequestGet:@"getGoodsListByIndex" parame:dic success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            NSArray *temp = [AppGoodsListModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.appGoodsList addObjectsFromArray:temp];
            LWLog(@"%@",json[@"resultDescription"]);

            [_collectionView reloadData];
        }else{
            LWLog(@"%@",json[@"resultDescription"]);

        }
        [_collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog (@"%@",error);
    }];
    
}

-(void)createArrURLString{
    _arrURLString=[NSMutableArray arrayWithArray:@[@"http://p1.qqyou.com/pic/UploadPic/2013-3/19/2013031923222781617.jpg",
                                                   @"http://cdn.duitang.com/uploads/item/201409/27/20140927192649_NxVKT.thumb.700_0.png",
                                                   @"http://img4.duitang.com/uploads/item/201409/27/20140927192458_GcRxV.jpeg",
                                                   @"http://cdn.duitang.com/uploads/item/201304/20/20130420192413_TeRRP.thumb.700_0.jpeg"]];
    _arrTitle=[NSMutableArray arrayWithArray:@[@"恭喜000中了一等奖一等奖一等奖一等奖一等奖一等奖一等奖",
                                               @"恭喜111中了一等奖一等奖一等奖一等奖一等奖一等奖一等奖",
                                               @"恭喜222中了一等奖一等奖一等奖一等奖一等奖一等奖一等奖",
                                               @"恭喜333中了一等奖一等奖一等奖一等奖一等奖一等奖一等奖",
                                               @"恭喜444中了一等奖一等奖一等奖一等奖一等奖一等奖一等奖",
                                               @"恭喜555中了一等奖一等奖一等奖一等奖一等奖一等奖一等奖",
                                               @"恭喜666中了一等奖一等奖一等奖一等奖一等奖一等奖一等奖",
                                               @"恭喜777中了一等奖一等奖一等奖一等奖一等奖一等奖一等奖",
                                               @"恭喜888中了一等奖一等奖一等奖一等奖一等奖一等奖一等奖",
                                               @"恭喜999中了一等奖一等奖一等奖一等奖一等奖一等奖一等奖"]];
}
-(void)createHeadView{
    
    _imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(440)+labelHeight+clearHeight+10)];
    _imageV.image=[UIImage imageNamed:@"buy_fukuan_red"];
    
    _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(460)+labelHeight)];
    self.headScrollView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(280)) WithImageUrls:_arrURLString];
    //占位图片,你可以在下载图片失败处修改占位图片
    //        _headScrollView.placeImage = [UIImage imageNamed:@""];
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    [_headScrollView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("第%zd张图片\n",index);
    }];
    //default is 2.0f,如果小于0.5不自动播放
    _headScrollView.AutoScrollDelay = 2.0f;

    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"HomeFourBtnCView" owner:nil options:nil];
    _fourBtnView=[nib firstObject];
    _fourBtnView.frame=CGRectMake(0,ADAPT_HEIGHT(280), SCREEN_WIDTH, ADAPT_HEIGHT(160));
    for (int i =0; i<4; i++) {
        UIImageView *imageV=[_fourBtnView viewWithTag:200+i];
        imageV.userInteractionEnabled=YES;
    }
#pragma mark 分类
    [_fourBtnView.imageVClass bk_whenTapped:^{
        ClassViewController *class=[[ClassViewController alloc]init];
        [self.navigationController pushViewController:class animated:YES];
    }];
#pragma mark 10元专区
    [_fourBtnView.imageTen bk_whenTapped:^{
        TenViewController *ten=[[TenViewController alloc]init];
        [self.navigationController pushViewController:ten animated:YES];
    }];
#pragma mark 晒单
    [_fourBtnView.imageVShow bk_whenTapped:^{
        
    }];
    
    _imageVNotice=[[UIImageView alloc]initWithFrame:CGRectMake(20, ADAPT_HEIGHT(440)+5, 30, 30)];
    _imageVNotice.image=[UIImage imageNamed:@"news"];
    
    [self createLableCollectionView];
    
    _clearView=[[UIView alloc]initWithFrame:CGRectMake(0, ADAPT_HEIGHT(440)+40, SCREEN_WIDTH, clearHeight)];
    _clearView.backgroundColor=[UIColor yellowColor];
    _headView.backgroundColor=[UIColor clearColor];
    
    [_headView addSubview:_headScrollView];
    [_headView addSubview:_fourBtnView];
    [_headView addSubview:_imageVNotice];
    [_headView addSubview:_labelCollectionView];
    [_headView addSubview:_clearView];
//    [self.view addSubview:_headView];
}
-(void)createLableCollectionView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *viewlayout = [[UICollectionViewFlowLayout alloc]init];
    viewlayout.minimumLineSpacing = 0;
    viewlayout.minimumInteritemSpacing = 0;
    viewlayout.itemSize = CGSizeMake(SCREEN_WIDTH-_imageVNotice.frame.origin.x-_imageVNotice.frame.size.width-5-20, labelHeight);
    viewlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    viewlayout.scrollDirection =UICollectionViewScrollDirectionVertical;
    
    _labelCollectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(_imageVNotice.frame.origin.x+_imageVNotice.frame.size.width+5 , ADAPT_HEIGHT(440)+10, SCREEN_WIDTH-_imageVNotice.frame.origin.x-_imageVNotice.frame.size.width-5-20,labelHeight)collectionViewLayout:viewlayout];
    [_labelCollectionView registerNib:[UINib nibWithNibName:@"labelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellLabel];
//    _labelCollectionView.userInteractionEnabled=NO;
    
    _labelCollectionView.delegate = self;
    _labelCollectionView.dataSource = self;
    _labelCollectionView.pagingEnabled = YES;
    _labelCollectionView.showsVerticalScrollIndicator=NO;
    _labelCollectionView.showsHorizontalScrollIndicator = NO;
    _labelCollectionView.tag=101;
    
    //    _collectionView.contentSize=CGSizeMake(_collectionView.frame.size.width,100*_arr.count );
    
    //创建一个 cell 的注册方式 必须写上
    //  设置时钟动画 定时器
    //    _isDragging=NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
    //  将定时器添加到主线程
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

}
- (void)update:(NSTimer *)timer{
    CGPoint offSet = _labelCollectionView.contentOffset;
    offSet.y +=labelHeight;
    [_labelCollectionView setContentOffset:offSet animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag == 100) {
        return 2;
    }
    else{
        return 1;
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 100) {
        if (section == 0) {
            return 1;
        }else {
            return _appGoodsList.count;
        }
    }
    else{
        return 1000*1000;
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView.tag == 100) {
        if (indexPath.section == 0) {
            HomeHeadCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellHead forIndexPath:indexPath ];
            [cell addSubview:_headScrollView];
            [cell addSubview:_fourBtnView];
            [cell addSubview:_imageVNotice];
            [cell addSubview:_labelCollectionView];
            [cell addSubview:_clearView];
            return cell;
            
        }else {
            HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
            AppGoodsListModel *model=[[AppGoodsListModel alloc]init];
            model=_appGoodsList[indexPath.row];
            
            if ([model.areaAmount isEqualToNumber:[NSNumber numberWithInteger:5]]) {
                cell.imageVState.image=[UIImage imageNamed:@"zhuanqu_b"];
            }
            if ([model.areaAmount isEqualToNumber:[NSNumber numberWithInteger:10]]) {
                cell.imageVState.image=[UIImage imageNamed:@"zhuanqu_a"];
            }
            
            cell.labelName.text=model.title;
            CGFloat percent=(model.toAmount.floatValue -model.remainAmount.floatValue)/(model.toAmount.floatValue);
            cell.viewProgress.progress=percent;
            NSString *percentString = [NSString stringWithFormat:@"%.0f%%",percent*100];
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"开奖进度 %@",percentString]];
            [attString addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_TITILE range:NSMakeRange(0,4)];
            [attString addAttribute:NSForegroundColorAttributeName value:COLOR_SHINE_BLUE range:NSMakeRange(5,percentString.length)];
            cell.labelProgress.attributedText = attString;
            [cell.imageVGoods sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl]];
            
            if (indexPath.row % 2) {
                
            }else {
                
            }
            
            return cell;
        }
    }
    else{
        labelCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:cellLabel forIndexPath:indexPath];
        cell.labelMain.text=_arrTitle[indexPath.row%10];
        return cell;
        
    }
    
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 100) {
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentify forIndexPath:indexPath];
            NSArray *arr=@[@"人气",@"最新",@"进度",@"总需人次"];
            _viewChoice=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            for (int i=0; i<4; i++) {
                FL_Button *button = [FL_Button fl_shareButton];
                [button setTitle:arr[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                button.status = FLAlignmentStatusCenter;
                button.frame=CGRectMake(SCREEN_WIDTH/4*i, 0, SCREEN_WIDTH/4, 43);
                button.tag=100+i;
                if (i==3) {
                    [button setImage:[UIImage imageNamed:@"paixu"] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"paixu_b"] forState:UIControlStateSelected];
                }
                [button bk_whenTapped:^{
                    for (int i = 0; i< 4; i++) {
                        FL_Button *btn =[_viewChoice viewWithTag:100+i];
                        btn.selected=NO;
                    }
                    if (button.tag != 103) {
                        num =0;
                        FL_Button *buttonTotal=[_viewChoice viewWithTag:103];
                        [buttonTotal setImage:[UIImage imageNamed:@"paixu_b"] forState:UIControlStateSelected];
                        [UIView animateWithDuration:0.3f animations:^{
                            _imageVRed.center=CGPointMake(button.center.x,_imageVRed.center.y );
                        }];
#warning 人气点击方法
                        if (button.tag ==100) {
                            self.type = [NSNumber numberWithInteger:1];
                            [self getGoodsList];                        }
#warning 最新点击方法
                        if (button.tag ==101) {
                            self.type = [NSNumber numberWithInteger:2];
                            [self getGoodsList];
                        }
#warning 进度点击方法
                        if (button.tag ==102) {
                            self.type = [NSNumber numberWithInteger:3];
                            [self getGoodsList];                        }
                    }else{
#warning 总需人次第一次点击
                        //总需人次的第一次点击
                        button.selected=YES;
                        if (num %2 ==0) {
                            LWLog(@"总需人次的第一次点击");
                            [button setImage:[UIImage imageNamed:@"paixu_b"] forState:UIControlStateSelected];
                            self.type = [NSNumber numberWithInteger:4];
                            [self getGoodsList];                        }
#warning 总需人次第二次点击
                        //总需人次的第二次点击
                        else{
                            LWLog(@"总需人次的第二次点击");
                            [button setImage:[UIImage imageNamed:@"paixu_a"] forState:UIControlStateSelected];
                            self.type = [NSNumber numberWithInteger:5];
                            [self getGoodsList];
                        }
                        [UIView animateWithDuration:0.3f animations:^{
                            _imageVRed.center=CGPointMake(button.center.x,_imageVRed.center.y );
                        }];
                        num ++;
                        
                    }
                    
                }];
                
                [_viewChoice addSubview:button];
                

            }
            
            FL_Button *buttonSelected=[_viewChoice viewWithTag:100 + [self.type integerValue] - 1];
            buttonSelected.selected=YES;
            [UIView animateWithDuration:0.3f animations:^{
                _imageVRed.center=CGPointMake(buttonSelected.center.x,_imageVRed.center.y );
            }];
            
            UIImageView *imageVBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, _viewChoice.frame.size.height-1, SCREEN_WIDTH, 1)];
            imageVBack.image=[UIImage imageNamed:@"line_huise"];
            _imageVRed=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4-SCREEN_WIDTH/4*4/5)/2, _viewChoice.frame.size.height-1, SCREEN_WIDTH/4*4/5, 1)];
            _imageVRed.image=[UIImage imageNamed:@"line_red"];
            [_viewChoice addSubview:imageVBack];
            [_viewChoice addSubview:_imageVRed];
            [view addSubview:_viewChoice];
            view.backgroundColor=[UIColor whiteColor];
        
            return view;
        }
        return nil;
    }
    else{
        return nil;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        DetailViewController *detail=[[DetailViewController alloc]init];
        AppGoodsListModel *model=[[AppGoodsListModel alloc]init];
        model=_appGoodsList[indexPath.row];
        detail.goodsId=model.pid;
        [self.navigationController pushViewController:detail animated:YES];    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 100) {
        if (indexPath.section == 0) {
            return  CGSizeMake(SCREEN_WIDTH, ADAPT_HEIGHT(440)+40+clearHeight);
        }else {
            return CGSizeMake([UIScreen mainScreen].bounds.size.width / 2 - 0.5, [UIScreen mainScreen].bounds.size.width / 2 * 1.45);
        }
    }
    else{
        return CGSizeMake(SCREEN_WIDTH-_imageVNotice.frame.origin.x-_imageVNotice.frame.size.width-5-20, labelHeight);    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (collectionView.tag == 100) {
        if (section == 0) {
            return CGSizeZero;
        }else {
            
            return CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
        }
        
    }
    else{
        return CGSizeZero;

    }
    
    
}

@end
