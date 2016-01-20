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
@interface HomeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)  UICollectionView *collectionView;
@property (strong, nonatomic)  DCPicScrollView *headScrollView;//头部视图-轮播视图
@property (strong, nonatomic)  HomeFourBtnCView *fourBtnView;//头部视图-四个按钮
@property (strong, nonatomic)  UICollectionView *labelCollectionView;//头部视图-中奖信息
@property (strong, nonatomic)  UIImageView *imageVNotice;//头部视图-提醒
@property (strong, nonatomic)  UIView *headView;//头部视图
@property (strong, nonatomic)  UIView *clearView;//分割的View
@property (strong, nonatomic)  NSTimer *timer;//定时器

@property (strong, nonatomic)  UIImageView *imageV;//头部视图-提醒


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


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent=NO;
  }

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createArrURLString];
    [self createHeadView];

    self.view.backgroundColor = [UIColor whiteColor];

    
    XLPlainFlowLayout *flowLayout = [[XLPlainFlowLayout alloc] init];
    flowLayout.naviHeight = 0;
    flowLayout.minimumInteritemSpacing = 0.5;
    flowLayout.minimumLineSpacing = 1;
    flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
//
//    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 44) collectionViewLayout:flowLayout];
    self.collectionView.tag=100;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentify];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellHead];

    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identify];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:topIdentify];
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
    NSLog(@"%f",ADAPT_HEIGHT(280));
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

    
    _imageVNotice=[[UIImageView alloc]initWithFrame:CGRectMake(20, ADAPT_HEIGHT(440)+5, 30, 30)];
    _imageVNotice.image=[UIImage imageNamed:@"news"];
    
    [self createLableCollectionView];
    
    _clearView=[[UIView alloc]initWithFrame:CGRectMake(0, ADAPT_HEIGHT(440)+40, SCREEN_WIDTH, clearHeight)];
    _clearView.backgroundColor=[UIColor yellowColor];
    
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
            return 20;
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
            
            
            if (indexPath.row % 2) {
                
            }else {
                
            }
            
            return cell;
        }
    }
    else{
        labelCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:cellLabel forIndexPath:indexPath];
        cell.labelMain.text=_arrTitle[indexPath.row%10];
//        cell.userInteractionEnabled=NO;
        return cell;
        
    }
    
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 100) {
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentify forIndexPath:indexPath];
            view.backgroundColor = [UIColor blueColor];
            return view;
        }
        return nil;
    }
    else{
        return nil;
    }
    
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
