//
//  RedViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/2.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "RedViewController.h"

@interface RedViewController (){
    CALayer *_layer;
    CAAnimationGroup *_animaTionGroup;
    CADisplayLink *_disPlayLink;
    
}
@property (nonatomic,retain) UIView *imgView;
@property(nonatomic,strong) CALayer *staticLayer;
@property(nonatomic,strong) CAGradientLayer *staticShadowLayer;
@property (nonatomic) double getAddressTime;
@property(nonatomic,strong)NSTimer *timer ;
@property (nonatomic, strong) UIImageView * backImageV;

@end

@implementation RedViewController
@synthesize imgView;

#pragma mark 懒加载
-(CALayer *)staticLayer{
    if (!_staticLayer) {
        self.staticLayer = [[CALayer alloc] init];
        self.staticLayer.cornerRadius = [UIScreen mainScreen].bounds.size.width/4;
        self.staticLayer.frame = CGRectMake(0, 0, self.staticLayer.cornerRadius*2 , self.staticLayer.cornerRadius*2);
        self.staticLayer.borderWidth = 1;
        self.staticLayer.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
        
        UIColor *color = [UIColor redColor];
        
        self.staticLayer.borderColor =color.CGColor;
        
    }
    return _staticLayer;
}

-(CAGradientLayer *)staticShadowLayer{
    if (!_staticShadowLayer) {
        self.staticShadowLayer = [[CAGradientLayer alloc] init];
        self.staticShadowLayer.cornerRadius = [UIScreen mainScreen].bounds.size.width/4;
        self.staticShadowLayer.frame = CGRectMake(0, 0, self.staticLayer.cornerRadius*2-1 , self.staticLayer.cornerRadius*2-1);
        //    layer1.borderWidth = 18;
        self.staticShadowLayer.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
        UIColor* backColor = [UIColor colorWithRed:100/255.0 green:46/255.0 blue:97/255.0 alpha:0.2];
        self.staticShadowLayer.colors = [NSArray arrayWithObjects:(id)backColor.CGColor,[UIColor colorWithRed:59/255.0 green:46/255.0 blue:97/255.0 alpha:0.2].CGColor ,nil];
        
    }
    return _staticShadowLayer;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden =YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBackImage];
//    self.view.backgroundColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:105/225.0 alpha:1];
    
//    self.imgView = [[MyView alloc]init];
//    self.imgView.backgroundColor = [UIColor clearColor];
//    self.imgView.frame=self.view.frame;
//    [self.view addSubview:self.imgView];
    [self startAnimation];
}

- (void)createBackImage{
    _backImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _backImageV.image = [UIImage imageNamed:@"xiuxiu"];
    [self.view addSubview:_backImageV];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
    
}

#pragma mark 动画
//开始动画
- (void)startAnimation
{
    [self.view.layer addSublayer:self.staticLayer];
    [self.view.layer addSublayer:self.staticShadowLayer];
    
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
    
    self.getAddressTime = [[NSDate date] timeIntervalSince1970];
    
    
    CALayer *layer = [[CALayer alloc] init];
    layer.cornerRadius = [UIScreen mainScreen].bounds.size.width;
    layer.frame = CGRectMake(0, 0, layer.cornerRadius*2 , layer.cornerRadius*2);
    layer.borderWidth = 1;
    layer.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    
    UIColor *color = [UIColor redColor];
    
    UIColor *backColor = [UIColor colorWithRed:59/255.0 green:46/255.0 blue:97/255.0 alpha:0.2];
    layer.borderColor =color.CGColor;
    [self.view.layer addSublayer:layer];
    
    
    CAGradientLayer *layer1 = [[CAGradientLayer alloc] init];
    layer1.cornerRadius = [UIScreen mainScreen].bounds.size.width;
    layer1.frame = CGRectMake(0, 0, layer.cornerRadius*2-1 , layer.cornerRadius*2-1);
    layer1.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    backColor = [UIColor colorWithRed:100/255.0 green:46/255.0 blue:97/255.0 alpha:0.2];
    layer1.colors = [NSArray arrayWithObjects:(id)backColor.CGColor,[UIColor colorWithRed:59/255.0 green:46/255.0 blue:97/255.0 alpha:0.2].CGColor ,nil];
    
    [self.view.layer addSublayer:layer1];
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    _animaTionGroup = [CAAnimationGroup animation];
    _animaTionGroup.delegate = self;
    _animaTionGroup.duration = 2;
    _animaTionGroup.removedOnCompletion = YES;
    _animaTionGroup.timingFunction = defaultCurve;
    
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.15;
    scaleAnimation.toValue = @1;
    scaleAnimation.duration = 2;
    
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration = 2;
    opencityAnimation.values = @[@0.6,@0.2,@0.2];
    opencityAnimation.keyTimes = @[@0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    
    
    NSArray *animations = @[scaleAnimation];
    
    _animaTionGroup.animations = animations;
    [layer addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
    [layer1 addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
    
    [self performSelector:@selector(removeLayer:) withObject:layer afterDelay:2];
    [self performSelector:@selector(removeLayer:) withObject:layer1 afterDelay:2];
    
    [self.view bringSubviewToFront:self.imgView];
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
    if (currentTime-self.getAddressTime>2) {
        [self startAnimation];
        [self.timer invalidate];
        self.timer = nil;
    }else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(action) userInfo:nil repeats:NO];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.staticShadowLayer removeFromSuperlayer];
    [self.staticShadowLayer removeAnimationForKey:@"groupAnnimation"];
    [self.staticLayer removeFromSuperlayer];
    [self.staticLayer removeAnimationForKey:@"groupAnnimation"];
    
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(click)];
    _disPlayLink.frameInterval = 40;
    [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)delayAnimation
{
    [self startAnimation];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view.layer removeAllAnimations];
    [_disPlayLink invalidate];
    _disPlayLink = nil;
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
