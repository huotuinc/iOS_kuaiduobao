//
//  DetailWebViewController.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/1/28.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "DetailWebViewController.h"

@interface DetailWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation DetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createWebView];
}
-(void)createWebView{
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
    [self.view addSubview:_webView];
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
