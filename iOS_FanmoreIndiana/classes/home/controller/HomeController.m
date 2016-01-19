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

@interface HomeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)  UICollectionView *collectionView;

@end

@implementation HomeController


static NSString *identify = @"identify";
static NSString *headIdentify = @"headIdentify";
static NSString *topIdentify = @"topIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];

    
    XLPlainFlowLayout *flowLayout = [[XLPlainFlowLayout alloc] init];
    flowLayout.naviHeight = 64;
    flowLayout.minimumInteritemSpacing = 0.5;
    flowLayout.minimumLineSpacing = 1;
    flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 44) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentify];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identify];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:topIdentify];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
        return 20;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        UICollectionViewCell *view = [collectionView dequeueReusableCellWithReuseIdentifier:topIdentify forIndexPath:indexPath];
        view.backgroundColor = [UIColor lightGrayColor];
        return view;
        
    }else {
        HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        
        
        if (indexPath.row % 2) {
            //            cell.backgroundColor = [UIColor redColor];
        }else {
            //            cell.backgroundColor = [UIColor greenColor];
        }
        
        return cell;
    }
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentify forIndexPath:indexPath];
        view.backgroundColor = [UIColor blueColor];
        return view;
    }
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  CGSizeMake([UIScreen mainScreen].bounds.size.width, 160);
    }else {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width / 2 - 0.5, [UIScreen mainScreen].bounds.size.width / 2 * 1.45);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }else {
        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
    }
    
    
}

@end
