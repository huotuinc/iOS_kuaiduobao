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

static NSString *cellLMain=@"cellLMain";

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cartList;
@property (strong, nonatomic)  ListBottomCView *bottomView;
@property(nonatomic,strong)UIToolbar *toolbar;//完成视图
@property (nonatomic,strong) UIBarButtonItem *previousBarButton;//完成选项

@end

@implementation ListViewController{
    NSMutableArray *selectGoods;
    //是否全选
    BOOL isSelect;
    CGFloat _kbHeight;//键盘弹起高度
    NSString * _beginNumber;//textField输入前的number
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    
    [super viewWillAppear:animated];
    //每次进入购物车的时候把选择的置空
    [selectGoods removeAllObjects];
    isSelect = NO;
    //    [self networkRequest];
    _bottomView.buttonAll.selected = NO;
    _bottomView.labelMoney.text = [NSString stringWithFormat:@"总计: 0元"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _cartList =[NSMutableArray array];
    selectGoods = [NSMutableArray array];
    //    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    //    [imageV sd_setImageWithURL:[NSURL URLWithString:@"http://dmimg.5054399.com/allimg/xyytuku/120518/a004.jpg"]];
    //    [self.view addSubview:imageV];
    
    
    [self createCartList];
    [self loadNotificationCell];
}
-(void)createCartList{
    for (int i = 0; i < 10; i++) {
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


-(void)createBottomView{

    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ListBottomCView" owner:nil options:nil];
    _bottomView=[nib firstObject];
    _bottomView.frame=CGRectMake(0, SCREEN_HEIGHT-ADAPT_HEIGHT(130) - 44 - 64, SCREEN_WIDTH, ADAPT_HEIGHT(130));
    _bottomView.buttonAll.userInteractionEnabled=YES;
    [_bottomView.buttonAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomView];
    
}

-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-ADAPT_HEIGHT(130)-64 -44 ) style:UITableViewStylePlain];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:cellLMain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    [self finshBarView];
    [self createBottomView];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellLMain forIndexPath:indexPath];
    
    cell.isSelected = isSelect;
    
    //是否被选中
    if ([selectGoods containsObject:[_cartList objectAtIndex:indexPath.row]]) {
        cell.isSelected = YES;
    }
    
    //选择回调
    cell.cartBlock = ^(BOOL isSelec){
        CartModel * model = _cartList[indexPath.row];
        
        if (isSelec) {
            model.isSelect = YES;
            [selectGoods addObject:[_cartList objectAtIndex:indexPath.row]];
        }
        else
        {
            model.isSelect = NO;
            [selectGoods removeObject:[_cartList objectAtIndex:indexPath.row]];
        }
        
        if (selectGoods.count == _cartList.count) {
            _bottomView.buttonAll.selected = YES;
        }
        else
        {
            _bottomView.buttonAll.selected = NO;
        }
        
        [self countPrice];
    };
    __block ListTableViewCell *weakCell = cell;
    cell.numAddBlock =^(){
        
        NSInteger count = [weakCell.textFNumber.text integerValue];
        CartModel *model = [_cartList objectAtIndex:indexPath.row];
        NSInteger addNumber = [model.areaAmount integerValue];
        count+= addNumber;
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        
        
        weakCell.textFNumber.text = numStr;
        model.attendAmount = [NSNumber numberWithInteger:count];
        NSLog(@"numStr --- %@   model.attendAmount --- %@",numStr,model.attendAmount);
        
        [_cartList replaceObjectAtIndex:indexPath.row withObject:model];
        if ([selectGoods containsObject:model]) {
            [selectGoods removeObject:model];
            [selectGoods addObject:model];
            [self countPrice];
        }
    };
    
    cell.numCutBlock =^(){
        
        NSInteger count = [weakCell.textFNumber.text integerValue];
        CartModel *model = [_cartList objectAtIndex:indexPath.row];
        NSInteger addNumber = [model.areaAmount integerValue];
        count-= addNumber;        if(count <= 0){
            return ;
        }
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        
        
        weakCell.textFNumber.text = numStr;
        
        model.attendAmount = [NSNumber numberWithInteger:count];
        NSLog(@"numStr --- %@   model.attendAmount --- %@",numStr,model.attendAmount);
        
        [_cartList replaceObjectAtIndex:indexPath.row withObject:model];
        
        //判断已选择数组里有无该对象,有就删除  重新添加
        if ([selectGoods containsObject:model]) {
            [selectGoods removeObject:model];
            [selectGoods addObject:model];
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
            
            CartModel *model = _cartList[indexPath.row];
            if (model.isSelect) {
                [selectGoods removeObjectAtIndex:indexPath.row];
            }
            [_cartList removeObjectAtIndex:indexPath.row];
            
            //            selectGoods = _cartList;
            //    删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self countPrice];
            
            //延迟0.5s刷新一下,否则数据会乱
            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
            
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
    //点击全选时,把之前已选择的全部删除
    [selectGoods removeAllObjects];
    
    button.selected = !button.selected;
    isSelect = button.selected;
    if (isSelect) {
        
        for (CartModel *model in _cartList) {
            model.isSelect = YES;
            [selectGoods addObject:model];
        }
    }
    else
    {
        [selectGoods removeAllObjects];
    }
    
    [self.tableView reloadData];
    [self countPrice];
}

/**
 *  @author LQQ, 16-02-18 11:02:16
 *
 *  计算已选中商品金额
 */
-(void)countPrice
{
    NSInteger totlePrice = 0;
    
    for (CartModel *model in selectGoods) {
        
        NSInteger price = [model.areaAmount integerValue];
        
        totlePrice += price*[model.attendAmount integerValue];
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
            
            sub.frame = CGRectMake(0, 0, sub.frame.size.width, SCREEN_HEIGHT-_toolbar.frame.size.height-rect.size.height - 44);
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
    
    self.tableView.frame=CGRectMake(0, 0, self.tableView.frame.size.width, SCREEN_HEIGHT-ADAPT_HEIGHT(130) - 44 );
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
    NSInteger areNumber = [model.areaAmount integerValue];
    if ([textField.text integerValue] % areNumber != 0 ) {
        textField.text = [NSString stringWithFormat:@"%@",_beginNumber];
    }
    if ([textField.text integerValue] > [model.remainAmount integerValue]) {
        textField.text = [NSString stringWithFormat:@"%@",model.remainAmount];
    }
    return YES;
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
