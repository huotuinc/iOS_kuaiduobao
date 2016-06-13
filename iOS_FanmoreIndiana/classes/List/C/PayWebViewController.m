//
//  PayWebViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/4/20.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "PayWebViewController.h"

@interface PayWebViewController ()
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation PayWebViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
    
    [self createWebView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self createBarButtonItem];
}
-(void)createWebView{
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
    [self.view addSubview:_webView];
}
-(void)createBarButtonItem{
    UIBarButtonItem *buttonL=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_gray"] style:UIBarButtonItemStyleDone target:self action:@selector(clickButtonL)];
    self.navigationItem.leftBarButtonItem=buttonL;
    

}
- (void)clickButtonL {
    [self.navigationController popToRootViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
