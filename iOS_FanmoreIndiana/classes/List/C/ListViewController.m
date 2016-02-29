//
//  ListViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/2/20.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"
#import "ListBottomCView.h"
#import "PayViewController.h"
#import "AppBalanceModel.h"
static NSString *cellLMain=@"cellLMain";
static NSInteger selectAllCount = 1;//用于判断buttonAll的选中状态 第一次点击为全选文字显示未全选 1为selected 2为unselected
@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cartList;//数据源数组
@property (strong, nonatomic)  ListBottomCView *bottomView;//结算视图
@property(nonatomic,strong)UIToolbar *toolbar;//完成视图
@property (nonatomic,strong) UIBarButtonItem *previousBarButton;//完成选项
@property (strong, nonatomic)  NSMutableArray *selectedArray; //选中商品的数组
@property (strong, nonatomic)  UIImageView *imageVBack; //选中商品的数组
@property (strong, nonatomic)  AppBalanceModel *balanceModel; //选中商品的数组

@end

@implementation ListViewController{
    BOOL isSelect;    //是否全选
    CGFloat _kbHeight;//键盘弹起高度
    NSString * _beginNumber;//textField输入前的number
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    
    [super viewWillAppear:animated];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    _selectedArray = [NSMutableArray array];
//    //每次进入购物车的时候把选择的置空
//    [_selectedArray removeAllObjects];
    isSelect = NO;
    _bottomView.buttonAll.selected = NO;
    _bottomView.labelMoney.text = [NSString stringWithFormat:@"总计: 0元"];
    [self createNavgationBarTitle];
    NSLog(@"*************1111");

    _cartList =[NSMutableArray array];
    NSString * login = [[NSUserDefaults standardUserDefaults] objectForKey:LoginStatus];
    if ([login isEqualToString:Success]) {
        NSLog(@"*************");

        [self getShoppingList];
    }else{
        NSLog(@"未登录");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    _cartList =[NSMutableArray array];

//    [self createCartList];
    [self loadNotificationCell];
}

-(void)createNavgationBarTitle{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:FONT_SIZE(32)];
    titleLabel.textColor = COLOR_TEXT_TITILE;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"清单";
    self.navigationItem.titleView = titleLabel;
}
- (void)setupRefresh
{
    
    
    MJRefreshNormalHeader * headRe = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getShoppingList)];
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
    
//    MJRefreshAutoNormalFooter * Footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreShoppingList)];
//    _tableView.mj_footer = Footer;
    
    //        [_tableView addFooterWithTarget:self action:@selector(getMoreGoodList)];
    
    
}

#pragma mark 网络请求购物车商品列表
/**
 *  下拉刷新
 */
- (void)getShoppingList{
    [SVProgressHUD show];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    
    [UserLoginTool loginRequestGet:@"getShoppingList" parame:nil success:^(id json) {
        
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            LWLog(@"%@",json[@"resultDescription"]);
            NSArray *temp = [CartModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
//            self.lastSort =json[@"resultData"][@"sort"];
            [self.cartList removeAllObjects];
            [self.cartList addObjectsFromArray:temp];
            
            
        }else{
            LWLog(@"%@",json[@"resultDescription"]);
        }
        [SVProgressHUD dismiss];
        if (_cartList.count == 0) {
            [self createImageVBack];
        }else {
            if (_tableView) {
                self.imageVBack.hidden = YES;
                [self.tableView reloadData];
                _bottomView.labelAll.text = @"全选";
                _bottomView.buttonAll.selected = NO;
                selectAllCount = 1;
            }else{
                [self createTableView];
            }
        }
        [_tableView.mj_header endRefreshing];

    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        LWLog(@"%@",error);
    }];
    
}

#pragma mark  网络删除商品

-(void)deleteShoppingCart {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"shoppingCartId"] = self.shoppingCartId;
    
    [UserLoginTool loginRequestPostWithFile:@"deleteShoppingCart" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            LWLog(@"%@",json[@"resultDescription"]);
        }else {
            LWLog(@"%@",json[@"resultDescription"]);
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        
        
    } withFileKey:nil];
    
    
}
#pragma mark 网络请求结算

- (void)goToPay {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableString *cartsString = [NSMutableString string];
    for ( int i =0 ; i<_selectedArray.count; i++) {
        CartModel *model = _selectedArray[i];
        if (i == _selectedArray.count - 1) {
            [cartsString appendFormat:@"{pid:%@,buyAmount:%@}",model.pid,model.buyAmount];
        }else{
            [cartsString appendFormat:@"{pid:%@,buyAmount:%@},",model.pid,model.buyAmount];
        }
    }
    [cartsString insertString:@"[" atIndex:0];
    [cartsString appendString:@"]"];
    dic[@"carts"] = cartsString;

    [UserLoginTool loginRequestPostWithFile:@"balance" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            LWLog(@"%@",json[@"resultDescription"]);
            _balanceModel = [AppBalanceModel mj_objectWithKeyValues:json[@"resultData"][@"data"]];
            PayViewController *pay = [[PayViewController alloc] init];
            pay.payModel = _balanceModel;
            [self.navigationController pushViewController:pay animated:YES];
        }else {
            [SVProgressHUD showInfoWithStatus:@"商品信息发生改变"];

            LWLog(@"%@",json[@"resultDescription"]);
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        
        
    } withFileKey:nil];
    
}

/**
 *  上拉加载更多
 */
//- (void)getMoreShoppingList {
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
////    dic[@"type"] = self.type;
////    dic[@"lastSort"]= self.lastSort;
//    
//    [UserLoginTool loginRequestGet:@"getGoodsListByIndex" parame:dic success:^(id json) {
//        
//        LWLog(@"%@",json);
//        
//        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
//            
//            NSArray *temp = [CartModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
//            
//            [self.cartList addObjectsFromArray:temp];
//            LWLog(@"%@",json[@"resultDescription"]);
//            
//            [_tableView reloadData];
//        }else{
//            LWLog(@"%@",json[@"resultDescription"]);
//            
//        }
//        [_tableView.mj_footer endRefreshing];
//    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
//        LWLog (@"%@",error);
//    }];
//    
//}

-(void)createCartList{
    for (int i = 0; i < 5; i++) {
        CartModel *model = [[CartModel alloc]init];
        if (i == 1) {
            model.title=[NSString stringWithFormat:@"%d%d%d",i,i,i];
            model.areaAmount=[NSNumber numberWithInteger:5];
            model.attendAmount=[NSNumber numberWithInteger:20];
            model.remainAmount=[NSNumber numberWithInteger:100];
            model.toAmount=[NSNumber numberWithInteger:200];
            model.pictureUrl=@"http://www.itouxiang.net/uploads/allimg/20151218/16500749163352.jpg";
            model.isSelect = NO;
            
        }else if (i == 3) {
            model.title=[NSString stringWithFormat:@"%d%d%d",i,i,i];
            model.areaAmount=[NSNumber numberWithInteger:10];
            model.attendAmount=[NSNumber numberWithInteger:50];
            model.remainAmount=[NSNumber numberWithInteger:20];
            model.toAmount=[NSNumber numberWithInteger:400];
            model.pictureUrl=@"http://dmimg.5054399.com/allimg/xyytuku/120518/a004.jpg";
            model.isSelect = NO;
            
            
        }else{
            model.title=[NSString stringWithFormat:@"%d%d%d",i,i,i];
            model.areaAmount=[NSNumber numberWithInteger:1];
            model.remainAmount=[NSNumber numberWithInteger:100+i*i];
            model.toAmount=[NSNumber numberWithInteger:200+i*i];
            model.attendAmount=[NSNumber numberWithInteger:i*i+1];
            model.pictureUrl=@"http://img009.hc360.cn/m2/M02/86/3A/wKhQclQnXySELH6LAAAAAHbVBoc180.jpg..210x210.jpg";
            model.isSelect = NO;
            
        }
        [_cartList addObject:model];
    }
    if (_tableView) {
        [self.tableView reloadData];
    }else{
        [self createTableView];
    }
    
    
}

-(void)loadNotificationCell
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
}

-(void)finshBarView
{
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-ADAPT_HEIGHT(130) - 44 - 64, SCREEN_WIDTH, 44)];
    // _toolbar.frame = CGRectMake(0, 0, APPScreenWidth, 44);
    [_toolbar setBarStyle:UIBarStyleDefault];
//    _toolbar.backgroundColor = COLOR_BUTTON_ORANGE;
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.previousBarButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(previousButtonIsClicked:)];
//    NSDictionary * attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Heiti SC" size:ADAPT_HEIGHT(50)]};
//    [self.previousBarButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSArray *barButtonItems = @[flexBarButton,self.previousBarButton];
    _toolbar.items = barButtonItems;
    [self.view addSubview:_toolbar];
}

- (void) previousButtonIsClicked:(id)sender
{
    [self.view endEditing:YES];
}

-(void) createImageVBack{
    _tableView.hidden = YES;
    _toolbar.hidden =YES;
    _bottomView.hidden =YES;
    _tableView = nil;
    if (_imageVBack) {
        _imageVBack.hidden =NO;
    }else {
        _imageVBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44)];
        _imageVBack.image = [UIImage imageNamed:@"kk"];
        [self.view addSubview:_imageVBack];
    }
    
}

-(void)createBottomView{

    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ListBottomCView" owner:nil options:nil];
    _bottomView=[nib firstObject];
    _bottomView.frame=CGRectMake(0, SCREEN_HEIGHT-ADAPT_HEIGHT(130) - 44 - 64, SCREEN_WIDTH, ADAPT_HEIGHT(130));
    _bottomView.buttonAll.userInteractionEnabled=YES;
    [_bottomView.buttonAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView.buttonGo bk_whenTapped:^{
        if (_selectedArray.count != 0) {
            [self goToPay];
        } else {
            [SVProgressHUD showInfoWithStatus:@"没有选中商品"];
        }
    }];
    [self.view addSubview:_bottomView];
    
}

-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-ADAPT_HEIGHT(130)-64 -44 ) style:UITableViewStylePlain];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:cellLMain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
//self.tableView.tableFooterView=[[UIView alloc]init];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self setupRefresh];
    if (_cartList == nil) {
        LWLog(@"购物车为空");
    }else {
        [self finshBarView];
        [self createBottomView];
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellLMain forIndexPath:indexPath];
    
    //是否被选中
    if ([_selectedArray containsObject:[_cartList objectAtIndex:indexPath.row]]) {
        cell.isCellSelect = YES;
    }
    
    //选择回调
    cell.cartBlock = ^(BOOL isSelec){
        CartModel * model = _cartList[indexPath.row];
        //选中
        if (isSelec) {
            model.isSelect = YES;
            [_selectedArray addObject:[_cartList objectAtIndex:indexPath.row]];
        }
        else
        {
            model.isSelect = NO;
            [_selectedArray removeObject:[_cartList objectAtIndex:indexPath.row]];
            _bottomView.labelAll.text = @"全选";
            _bottomView.buttonAll.selected = NO;
            selectAllCount = 1;//点击buttonALL 进入selected状态
        }
        
        if (_selectedArray.count == _cartList.count) {
            _bottomView.buttonAll.selected = YES;
            _bottomView.labelAll.text = @"取消全选";
            selectAllCount = 2;
        }
        else
        {

        }
        
        //选中商品为0 相当于click一次buttonAll操作
        if (_selectedArray.count == 0) {
            selectAllCount = 1;
        }
        
        [self countPrice];
    };
    __block ListTableViewCell *weakCell = cell;
    cell.numAddBlock =^(){
        NSLog(@"*******");

        NSInteger count = [weakCell.textFNumber.text integerValue];
        CartModel *model = [_cartList objectAtIndex:indexPath.row];
        NSInteger addNumber;
        if ([model.areaAmount integerValue] == 0) {
            addNumber = 1;
        }else {
            addNumber = [model.areaAmount integerValue];
        }
        count+= addNumber;
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        
        
        weakCell.textFNumber.text = numStr;
        model.buyAmount = [NSNumber numberWithInteger:count];
        
        [_cartList replaceObjectAtIndex:indexPath.row withObject:model];
        if ([_selectedArray containsObject:model]) {
            [_selectedArray removeObject:model];
            [_selectedArray addObject:model];
            [self countPrice];
        }
    };
    
    cell.numCutBlock =^(){
        NSLog(@"*******");
        NSInteger count = [weakCell.textFNumber.text integerValue];
        CartModel *model = [_cartList objectAtIndex:indexPath.row];
        NSInteger addNumber;
        if ([model.areaAmount integerValue] == 0) {
            addNumber = 1;
        }else {
            addNumber = [model.areaAmount integerValue];
        }        count-= addNumber;
        if(count <= 0){
            return ;
        }
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        
        
        weakCell.textFNumber.text = numStr;
        
        model.buyAmount = [NSNumber numberWithInteger:count];
        
        [_cartList replaceObjectAtIndex:indexPath.row withObject:model];
        
        //判断已选择数组里有无该对象,有就删除  重新添加
        if ([_selectedArray containsObject:model]) {
            [_selectedArray removeObject:model];
            [_selectedArray addObject:model];
            [self countPrice];
        }
        //
    };
    cell.textFNumber.delegate=self;
    _kbHeight = cell.keyBoardHeight;
    [cell loadData:_cartList[indexPath.row] indexPath:indexPath];
    //    [cell reloadDataWith:[_cartList objectAtIndex:indexPath.row]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            CartModel *model = [_cartList objectAtIndex:indexPath.row];
            
            [_cartList removeObjectAtIndex:indexPath.row];
            
            
            
            //    删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            self.shoppingCartId = model.pid;
            [self deleteShoppingCart];
            
            
            //判断是否选择
            if ([_selectedArray containsObject:model]) {
                //从已选中删除,重新计算价格
                [_selectedArray removeObject:model];
                [self countPrice];
            }
            
            if (_cartList.count == _selectedArray.count) {
                _bottomView.labelAll.text = @"取消全选";
                _bottomView.buttonAll.selected = YES;
                selectAllCount= 2;//buttonAll再次点击进入 unselected状态
            }else{
                _bottomView.labelAll.text = @"全选";
                _bottomView.buttonAll.selected = NO;
                selectAllCount = 1;
            }
            
            if (_cartList.count == 0) {
                [self createImageVBack];
            }else{
                //延迟0.5s刷新一下,否则数据会乱
                [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
            }
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)reloadTable
{
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cartList.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ADAPT_HEIGHT(275);
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}


-(void)selectAllBtnClick:(UIButton*)button
{
    //全选中
    if (selectAllCount  == 1) {
        _bottomView.labelAll.text = @"取消全选";
        _bottomView.buttonAll.selected = YES;
        [_selectedArray removeAllObjects];
        for (CartModel *model in _cartList) {
            model.isSelect = YES;
            [_selectedArray addObject:model];
        }
        [self.tableView reloadData];
        [self countPrice];
        selectAllCount = 2;
        return;
    }
    //未选中
    if (selectAllCount == 2) {
        _bottomView.labelAll.text = @"全选";
        _bottomView.buttonAll.selected = NO;
        [_selectedArray removeAllObjects];
        for (CartModel *model in _cartList) {
            model.isSelect = NO;
        }
        [self.tableView reloadData];
        [self countPrice];
        selectAllCount = 1;
        return;
        
    }
}

#pragma mark 计算价格
-(void)countPrice
{
    NSInteger totlePrice = 0;
    
    for (CartModel *model in _selectedArray) {
        NSInteger price = 1;
//        if ([model.areaAmount integerValue] == 0) {
//            price =1;
//        }else {
//            price = [model.areaAmount integerValue];
//        }
        totlePrice += price*[model.buyAmount integerValue];

    }
    _bottomView.labelMoney.text = [NSString stringWithFormat:@"总计%ld元",totlePrice];
}


- (void)keyboardWillShow:(NSNotification *)notif {
    if (self.view.hidden == YES) {
        return;
    }
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.origin.y;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    NSArray *subviews = [self.view subviews];
    for (UIView *sub in subviews) {
        CGFloat maxY = CGRectGetMaxY(sub.frame);
        if ([sub isKindOfClass:[UITableView class]]) {
            // -22
            sub.frame = CGRectMake(0, 0, sub.frame.size.width, SCREEN_HEIGHT-_toolbar.frame.size.height-rect.size.height - 44 -22);
            sub.center = CGPointMake(CGRectGetWidth(self.view.frame)/2.0, (sub.frame.size.height)/2);
            
        }else{
            if (maxY > y - 2) {
//                if ([sub isKindOfClass:[ListBottomCView class]]) {
//                    sub.center = CGPointMake(CGRectGetWidth(self.view.frame)/2.0, sub.center.y  - maxY + y - ADAPT_HEIGHT(130));
//                }
                if ([sub isKindOfClass:[UIToolbar class]]) {
                    sub.center = CGPointMake(CGRectGetWidth(self.view.frame)/2.0, sub.center.y  - maxY + y - ADAPT_HEIGHT(130));
                }
                
            }
        }
    }
//     _toolbar.frame=CGRectMake(0, SCREEN_HEIGHT -ADAPT_HEIGHT(130) - 44, SCREEN_WIDTH, ADAPT_HEIGHT(130));
    [UIView commitAnimations];
}

- (void)keyboardShow:(NSNotification *)notif {
    if (self.view.hidden == YES) {
        return;
    }
}

- (void)keyboardWillHide:(NSNotification *)notif {
    if (self.view.hidden == YES) {
        return;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    NSArray *subviews = [self.view subviews];
    for (UIView *sub in subviews) {
        if (sub.center.y < CGRectGetHeight(self.view.frame)/2.0) {
            sub.center = CGPointMake(CGRectGetWidth(self.view.frame)/2.0, CGRectGetHeight(self.view.frame)/2.0);
        }
    }
    _toolbar.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, _toolbar.frame.size.height);
    _bottomView.frame = CGRectMake(0, self.view.frame.size.height-_bottomView.frame.size.height - 44, SCREEN_WIDTH, _bottomView.frame.size.height);
    //-44
    self.tableView.frame=CGRectMake(0, 0, self.tableView.frame.size.width, SCREEN_HEIGHT-ADAPT_HEIGHT(130) - 44 -44);
    [UIView commitAnimations];
}

- (void)keyboardHide:(NSNotification *)notif {
    if (self.view.hidden == YES) {
        return;
    }
}

#pragma UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"tf开始编辑");
    _beginNumber = textField.text;


    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"tf取消编辑");
    NSInteger row = textField.tag -300;
    CartModel * model = _cartList[row];
    //倍数值
    NSInteger areNumber;
    if ([model.areaAmount integerValue] == 0) {
        areNumber = 1 ;
    }else {
        areNumber = [model.areaAmount integerValue];
    }
    if ([textField.text integerValue] % areNumber != 0 ) {
        textField.text = [NSString stringWithFormat:@"%@",_beginNumber];
//        model.buyAmount = [NSNumber numberWithInteger:[textField.text integerValue]];
        [self countPrice];

        return YES;
    }
    if ([textField.text integerValue] > [model.remainAmount integerValue]) {
        textField.text = [NSString stringWithFormat:@"%@",model.remainAmount];

        model.buyAmount = [NSNumber numberWithInteger:[textField.text integerValue]];
        [self countPrice];

        return YES;
    }
    model.buyAmount = [NSNumber numberWithInteger:[textField.text integerValue]];
    //判断已选择数组里有无该对象,有就删除  重新添加
    if ([_selectedArray containsObject:model]) {
        [_selectedArray removeObject:model];
        [_selectedArray addObject:model];
        [self countPrice];
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_imageVBack removeFromSuperview];
    _imageVBack =nil;

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
