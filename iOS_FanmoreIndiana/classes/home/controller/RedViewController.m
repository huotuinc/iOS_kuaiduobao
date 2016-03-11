//
//  RedViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/2.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RedViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "RedCountCView.h"
#import "RedGetCView.h"
#import "RedWaitCView.h"
#import "RedDisGetCView.h"
#import "AppRedPactketsDistributeSourceModel.h"
#import "AppWinningInfoModel.h"
@interface RedViewController (){
    CALayer *_layer;
    CAAnimationGroup *_animaTionGroup;
    CADisplayLink *_disPlayLink;
    AVPlayer* myplayer;
    NSInteger _statusNumber; //用于判断当前活动的状态0 已经开始 1还没开始 2没有活动

    
}
@property (nonatomic,retain) UIView *imgView;
@property(nonatomic,strong) CALayer *staticLayer;
@property(nonatomic,strong) CAGradientLayer *staticShadowLayer;
@property (nonatomic) double getAddressTime;
@property(nonatomic,strong)NSTimer *timer ;
@property (nonatomic, strong) UIImageView * backImageV;

@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, assign) NSInteger count;//点击次数
@property (nonatomic, assign) NSInteger redRestNumber;//红包个数

@property (nonatomic, strong) UIImageView *imageVReturn;
@property (nonatomic, strong) UIImageView *imageVXiu;
@property (nonatomic, strong) UIImageView *imageVTop;
@property (nonatomic, strong) UIImageView *imageVBack;
@property (nonatomic, strong) UIImageView *imageVBottom;
@property (nonatomic, strong) RedCountCView *countView;//剩余时间与红包个数
@property (nonatomic, strong) RedWaitCView *waitView;//活动未开始
@property (nonatomic, strong) RedDisGetCView *disGetView;//没有咻中
@property (nonatomic, strong) RedGetCView *getView;//咻中红包

@property (nonatomic, strong) AppRedPactketsDistributeSourceModel *distributeModel;
@property (nonatomic, strong) AppWinningInfoModel *winningModel;


@property (nonatomic, strong) NSTimer * timerWait;
@property (nonatomic, strong) NSTimer * timerEnd;
@property (nonatomic, strong) NSTimer * timerRedNumber;


@property (nonatomic, strong) NSMutableArray *redList;//用于接收当前xiuxiu红包
@property (nonatomic, strong) NSMutableArray *redPastList;//用于存放上次xiuxiu红包


@end

@implementation RedViewController
#pragma mark 懒加载
//未点击时的圈边
-(CALayer *)staticLayer{
    if (!_staticLayer) {
        self.staticLayer = [[CALayer alloc] init];
        self.staticLayer.cornerRadius = [UIScreen mainScreen].bounds.size.width/4;
        self.staticLayer.frame = CGRectMake(0, 0, self.staticLayer.cornerRadius*2 , self.staticLayer.cornerRadius*2);
        self.staticLayer.borderWidth = 2;
        self.staticLayer.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, ADAPT_HEIGHT(705) + ADAPT_HEIGHT(103));
        
        //        UIColor *color = [UIColor redColor];
        UIColor *color = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.6];
        self.staticLayer.borderColor =color.CGColor;
        
    }
    return _staticLayer;
}
//内圈
-(CAGradientLayer *)staticShadowLayer{
    if (!_staticShadowLayer) {
        self.staticShadowLayer = [[CAGradientLayer alloc] init];
        self.staticShadowLayer.cornerRadius = [UIScreen mainScreen].bounds.size.width/4;
        self.staticShadowLayer.frame = CGRectMake(0, 0, self.staticLayer.cornerRadius*2-1 , self.staticLayer.cornerRadius*2-1);
        //            layer1.borderWidth = 18;
        self.staticShadowLayer.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
        //        UIColor* backColor = [UIColor colorWithRed:100/255.0 green:46/255.0 blue:97/255.0 alpha:0.8];
        UIColor *backColor = [UIColor clearColor];
        
        self.staticShadowLayer.colors = [NSArray arrayWithObjects:(id)backColor.CGColor,[UIColor colorWithRed:59/255.0 green:46/255.0 blue:97/255.0 alpha:0.8].CGColor ,nil];
        
    }
    return _staticShadowLayer;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _count = 0;
//    self.view.backgroundColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:105/225.0 alpha:1];
    _redList = [NSMutableArray array];
    _redPastList = [NSMutableArray array];
    [self getDistuributeModel];

    
    //    self.imgView = [[MyView alloc]init];
    //    self.imgView.backgroundColor = [UIColor clearColor];
    //    self.imgView.frame=self.view.frame;
    //    [self.view addSubview:self.imgView];
    
}

- (void)createTimer {
    self.timerWait = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(AtimerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timerWait forMode:NSRunLoopCommonModes];
}
- (void)AtimerEvent {
    //开始
    if (_statusNumber == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RED_END object:nil];
        [_distributeModel countDownEnd];
    }
    if (_statusNumber == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RED_WAIT object:nil];
        [_distributeModel countDownWait];
    }

}


#pragma mark 判断活动是否开始
- (void)getDistuributeModel {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    [UserLoginTool loginRequestGet:@"whetherToStartDrawing" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            _distributeModel = [AppRedPactketsDistributeSourceModel mj_objectWithKeyValues:json[@"resultData"][@"data"]];
            _statusNumber = [json[@"resultData"][@"flag"] integerValue];

            
            [self createMainXiuView];


            //开始
            if (_statusNumber == 0) {
                [self startAnimation];

            }
            if (_statusNumber == 1) {
                [self createWaitView];

            }
            if (_statusNumber == 2) {
                [self createWaitView];
                
            }
            [self creatImageVReturn];
            [self createTimer];
            
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);

    }];
    
}
#pragma mark 剩余红包个数
- (void)getRedPocketRestNumber {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [UserLoginTool loginRequestGet:@"whetherToStartDrawing" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            _distributeModel = [AppRedPactketsDistributeSourceModel mj_objectWithKeyValues:json[@"resultData"][@"data"]];
            _redRestNumber = _distributeModel.amount;
            [self refreshRestRedPocketNumber];
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        
    }];
    
}
#pragma mark xiuxiu请求
- (void)getXiuXiuXiu {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [UserLoginTool loginRequestGet:@"xiuxiuxiu" parame:dic success:^(id json) {
        LWLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            NSArray *temp = [AppWinningInfoModel mj_objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            [self.redList removeAllObjects];
            [self.redList addObjectsFromArray:temp];
            if (_redPastList.count == 0) {
                [_redPastList addObject:temp];
                _winningModel = _redList[0];
            }else {
                _winningModel = [self getNewRedPocket];
            }
            //如果未中奖
            if (_winningModel.rId == nil) {
                [self createDisGetView];
            } else {
                [self createGetView];
            }

        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        
    }];
    
}
//刷新剩余红包个数
- (void)refreshRestRedPocketNumber {
    NSInteger A = _redRestNumber / 100000;
    NSInteger B = _redRestNumber / 10000 % 10;
    NSInteger C = _redRestNumber / 1000  % 10;
    NSInteger D = _redRestNumber / 100   % 10;
    NSInteger E = _redRestNumber / 10    % 10;
    NSInteger F = _redRestNumber / 1     % 10;
    
    _countView.labelA.text = [NSString stringWithFormat:@"%ld",A];
    _countView.labelA.text = [NSString stringWithFormat:@"%ld",B];
    _countView.labelA.text = [NSString stringWithFormat:@"%ld",C];
    _countView.labelA.text = [NSString stringWithFormat:@"%ld",D];
    _countView.labelA.text = [NSString stringWithFormat:@"%ld",E];
    _countView.labelA.text = [NSString stringWithFormat:@"%ld",F];

}
//遍历找出是否获得新的红包
- (AppWinningInfoModel *)getNewRedPocket {
    for (NSInteger i = _redList.count - 1; i >= 0; i--) {
        AppWinningInfoModel * redM = _redList[i];
        for (NSInteger j = _redPastList.count - 1; j >= 0; j--) {
            AppWinningInfoModel *redPastM = _redPastList[j];
            if (redM.rId == redPastM.rId) {
                [_redList removeObjectAtIndex:i];
            }
        }
    }
    if (_redList.count == 0) {
        return nil;
    }else {
        AppWinningInfoModel * newM = _redList[0];
        return newM;
    }
    
}
- (void)createGetView {
    if (_getView) {
        return;
    }else {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"RedGetCView" owner:nil options:nil];
        _getView = [nib firstObject];
        _getView.frame = CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT);
        [_getView.viewClear bk_whenTapped:^{
            LWLog(@"点击了clearV");
            [_getView removeFromSuperview];
        }];
        _getView.labelMoney.text = _winningModel.winningInfo;
        [self.view addSubview:_getView];
    }
}
- (void)createDisGetView {
    if (_disGetView) {
        return;
    }else {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"RedDisGetCView" owner:nil options:nil];
        _disGetView = [nib firstObject];
        _disGetView.frame = CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT);
        [_disGetView.viewClear bk_whenTapped:^{
            LWLog(@"点击了clearV");
            [_disGetView removeFromSuperview];
        }];
        _disGetView.labelMoney.text = _winningModel.winningInfo;
        [self.view addSubview:_disGetView];
    }
}
- (void)createMainXiuView {
    [self createImageVBack];
    [self createImageVTop];
    [self createImageVBottom];
    [self createImageVXiu];
    [self createCountView];
}



- (void) creatImageVReturn {
    _imageVReturn = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 25, 25)];
    _imageVReturn.image = [UIImage imageNamed:@"back"];
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    backV.userInteractionEnabled = YES;
    [backV bk_whenTapped:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:_imageVReturn];
    [self.view addSubview:backV];
    [self.view bringSubviewToFront:backV];
}
- (void) createCountView {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RedCountCView" owner:nil options:nil];
    _countView = [nib firstObject];
    _countView.frame = CGRectMake(0, ADAPT_HEIGHT(480), SCREEN_WIDTH, ADAPT_HEIGHT(100));
    [_countView defaultConfig];
    [_countView loadData:_distributeModel];
    if ([_countView.labelTime.text isEqualToString:@"本期活动已结束"]) {
        NSLog(@"_____本期活动已结束______");
        [self getDistuributeModel];
    }
    [self.view addSubview:_countView];
}
- (void)createWaitView {
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"RedWaitCView" owner:nil options:nil];
    _waitView = [nib firstObject];
    _waitView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_waitView defaultConfig];
    [_waitView loadData:_distributeModel];
    if ([_waitView.labelTime.text isEqualToString:@"本期本期活动已开始"]) {
        NSLog(@"_____本期活动已开始______");
        [self getDistuributeModel];
    }
    
    [self.view addSubview:_waitView];
    
}
- (void) createImageVXiu {
    self.imageVXiu = [[UIImageView alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2 - ADAPT_HEIGHT(103), ADAPT_HEIGHT(705), ADAPT_HEIGHT(206), ADAPT_HEIGHT(206))];
    _imageVXiu.image = [UIImage imageNamed:@"hb_d"];
    [self.view addSubview:_imageVXiu];
}

- (void) createImageVTop {
    self.imageVTop = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, ADAPT_HEIGHT(540))];
    _imageVTop.image = [UIImage imageNamed:@"hb_a"];
    [self.view addSubview:_imageVTop];
}
- (void) createImageVBack {
    self.imageVBack = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _imageVBack.image = [UIImage imageNamed:@"hb_c"];
    [self.view addSubview:_imageVBack];
}
- (void) createImageVBottom {
    self.imageVBottom = [[UIImageView alloc] initWithFrame: CGRectMake(0, SCREEN_HEIGHT-ADAPT_HEIGHT(250), SCREEN_WIDTH, ADAPT_HEIGHT(250))];
    _imageVBottom.image = [UIImage imageNamed:@"hb_b"];
    [self.view addSubview:_imageVBottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
#pragma mark 动画
//开始动画
- (void)startAnimation
{
    [self.view.layer addSublayer:self.staticLayer];
    //    [self.view.layer addSublayer:self.staticShadowLayer];
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    _animaTionGroup = [CAAnimationGroup animation];
    _animaTionGroup.delegate = self;
    _animaTionGroup.duration = 1;
    _animaTionGroup.removedOnCompletion = YES;
    _animaTionGroup.timingFunction = defaultCurve;
    
    _animaTionGroup.autoreverses = YES;
    _animaTionGroup.repeatCount = MAXFLOAT;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.7;
    scaleAnimation.toValue = @0.8;
    scaleAnimation.duration = 1;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.autoreverses = YES;
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration = 1;
    opencityAnimation.values = @[@0.6,@0.2,@0.2];
    opencityAnimation.keyTimes = @[@0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    opencityAnimation.autoreverses = YES;
    opencityAnimation.repeatCount = MAXFLOAT;
    
    NSArray *animations = @[scaleAnimation];
    
    _animaTionGroup.animations = animations;
    [self.staticLayer addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
    [self.staticShadowLayer addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
    
    
    [self.view bringSubviewToFront:self.imgView];
}

//点击事件的动画
-(void)click{
    
    
    if (self.isFirst) {
        self.getAddressTime = [[NSDate date] timeIntervalSince1970];
        
        
        CALayer *layer = [[CALayer alloc] init];
        layer.cornerRadius = ADAPT_HEIGHT(320);
        layer.frame = CGRectMake(0, 0, layer.cornerRadius*2 , layer.cornerRadius*2);
        layer.borderWidth = 5;
        layer.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, ADAPT_HEIGHT(705) + ADAPT_HEIGHT(103));
        UIColor *color = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//        UIColor *backColor = [UIColor colorWithRed:59/255.0 green:46/255.0 blue:97/255.0 alpha:0.5];
        layer.borderColor =color.CGColor;
        //点击后扇形的边
        [self.view.layer addSublayer:layer];
        
        
//        CAGradientLayer *layer1 = [[CAGradientLayer alloc] init];
//        layer1.cornerRadius = [UIScreen mainScreen].bounds.size.width/2;
//        layer1.frame = CGRectMake(0, 0, layer.cornerRadius*2-1 , layer.cornerRadius*2-1);
//        layer1.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
//        backColor = [UIColor colorWithRed:100/255.0 green:46/255.0 blue:97/255.0 alpha:0.8];
//        layer1.colors = [NSArray arrayWithObjects:(id)backColor.CGColor,[UIColor colorWithRed:59/255.0 green:46/255.0 blue:97/255.0 alpha:0.8].CGColor ,nil];
        //扇形内的颜色
        //        [self.view.layer addSublayer:layer1];
        
        CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        _animaTionGroup = [CAAnimationGroup animation];
        _animaTionGroup.delegate = self;
        _animaTionGroup.duration = 2;
        _animaTionGroup.removedOnCompletion = YES;
        _animaTionGroup.timingFunction = defaultCurve;
        
        
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
        scaleAnimation.fromValue = @0.0;
        scaleAnimation.toValue = @1;
        scaleAnimation.duration = 2;
        
        
        CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opencityAnimation.duration = 2;
        opencityAnimation.values = @[@0.8,@0.4,@0.0];
        opencityAnimation.keyTimes = @[@0,@0.5,@1];
        opencityAnimation.removedOnCompletion = YES;
        
        
        NSArray *animations = @[scaleAnimation,opencityAnimation];
        
        _animaTionGroup.animations = animations;
        [layer addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
//        [layer1 addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
        
        [self performSelector:@selector(removeLayer:) withObject:layer afterDelay:1.5f];
//        [self performSelector:@selector(removeLayer:) withObject:layer1 afterDelay:1.f];
        
        [self.view bringSubviewToFront:self.imgView];
    }
    self.isFirst = NO;
    
    
    
}


- (void)removeLayer:(CALayer *)layer
{
    [layer removeFromSuperlayer];
    [layer removeAnimationForKey:@"groupAnnimation"];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(action) userInfo:nil repeats:NO];
    
}

//点击事件结束2秒后开始执行startAnimation
-(void)action{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];;
    if (currentTime-self.getAddressTime>1.5f) {
        [self startAnimation];
        [self.timer invalidate];
        self.timer = nil;
    }else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(action) userInfo:nil repeats:NO];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.view];
    
    CGFloat x = SCREEN_WIDTH/2 - ADAPT_HEIGHT(103);
    CGFloat y = ADAPT_HEIGHT(705);
    CGFloat xw =  SCREEN_WIDTH/2 + ADAPT_HEIGHT(103);
    CGFloat yh = ADAPT_HEIGHT(705) + ADAPT_HEIGHT(206);
    
    if (point.x > x && point.x < xw && point.y > y && point.y < yh) {
        //移除未点击时的动画
        [self.staticShadowLayer removeFromSuperlayer];
        [self.staticShadowLayer removeAnimationForKey:@"groupAnnimation"];
        [self.staticLayer removeFromSuperlayer];
        [self.staticLayer removeAnimationForKey:@"groupAnnimation"];
        //点击次数
        NSLog(@"**** %ld ****",(long)_count);
        //百分之一的概率 发送请求
        int luckNumber = arc4random() % 100;
        if (luckNumber == 77) {
            [self getXiuXiuXiu];
        }
        //开始xiu动画
        _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(click)];
        _disPlayLink.frameInterval = 40;
        [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        //播放音效
//        [self soundComeOut];
        self.isFirst = YES;
    }
    
    
    //    [self.staticShadowLayer removeFromSuperlayer];
    //    [self.staticShadowLayer removeAnimationForKey:@"groupAnnimation"];
    //    [self.staticLayer removeFromSuperlayer];
    //    [self.staticLayer removeAnimationForKey:@"groupAnnimation"];
    
    //    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(click)];
    //    _disPlayLink.frameInterval = 40;
    //    [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)delayAnimation
{
    [self startAnimation];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    [self.view.layer removeAllAnimations];
    //    [_disPlayLink invalidate];
    //    _disPlayLink = nil;
    
    [super touchesEnded:touches withEvent:event];
    [self cancle];
}

- (void)cancle {
    self.isFirst = NO;
    [self.view.layer removeAllAnimations];
    [_disPlayLink invalidate];
    _disPlayLink = nil;
    _count++;
}
//播放音效
-(void)soundComeOut{
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"xiuVoice" ofType:@"mp3"];
    NSURL *audioUrl = [NSURL fileURLWithPath:audioPath];
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:audioUrl];
    myplayer = [[AVPlayer alloc]initWithPlayerItem:item];
    [myplayer play];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =YES;
    [_timerWait setFireDate:[NSDate distantFuture]];
}

@end
