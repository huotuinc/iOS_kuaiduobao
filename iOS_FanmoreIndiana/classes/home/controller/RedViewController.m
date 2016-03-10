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
@interface RedViewController (){
    CALayer *_layer;
    CAAnimationGroup *_animaTionGroup;
    CADisplayLink *_disPlayLink;
    AVPlayer* myplayer;

    
}
@property (nonatomic,retain) UIView *imgView;
@property(nonatomic,strong) CALayer *staticLayer;
@property(nonatomic,strong) CAGradientLayer *staticShadowLayer;
@property (nonatomic) double getAddressTime;
@property(nonatomic,strong)NSTimer *timer ;
@property (nonatomic, strong) UIImageView * backImageV;

@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) UIImageView *imageVReturn;
@property (nonatomic, strong) UIImageView *imageVXiu;
@property (nonatomic, strong) UIImageView *imageVTop;
@property (nonatomic, strong) UIImageView *imageVBack;
@property (nonatomic, strong) UIImageView *imageVBottom;
@property (nonatomic, strong) RedCountCView *countView;


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
    [self createImageVBack];
    [self createImageVTop];
    [self createImageVBottom];
    [self createImageVXiu];
    [self createCountView];
    [self creatImageVReturn];
    
    //    self.imgView = [[MyView alloc]init];
    //    self.imgView.backgroundColor = [UIColor clearColor];
    //    self.imgView.frame=self.view.frame;
    //    [self.view addSubview:self.imgView];
    [self startAnimation];
    
}
- (void) creatImageVReturn {
    _imageVReturn = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 25, 25)];
    _imageVReturn.image = [UIImage imageNamed:@"back"];
    _imageVReturn.userInteractionEnabled =YES;
    [_imageVReturn bk_whenTapped:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:_imageVReturn];
}
- (void) createCountView {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RedCountCView" owner:nil options:nil];
    _countView = [nib firstObject];
    _countView.frame = CGRectMake(0, ADAPT_HEIGHT(480), SCREEN_WIDTH, ADAPT_HEIGHT(100));
    [self.view addSubview:_countView];
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
}

@end
