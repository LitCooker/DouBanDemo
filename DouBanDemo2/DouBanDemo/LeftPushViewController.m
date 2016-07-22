//
//  LeftPushViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/4.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "LeftPushViewController.h"
#import "SVProgressHUD.h"
@interface LeftPushViewController ()<UIWebViewDelegate>

@end

@implementation LeftPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    //展示网友
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.frame];
    //获取代理
    web.delegate = self;
    
    //2.获取url  包括本地路径
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.请求加载网址
    [web loadRequest:request];
    
    [web goForward];
    [web goBack];
    [web reload];
    //自适应大小
    [web setScalesPageToFit:YES];
    
    [self.view addSubview:web];
    
}
#pragma mark - 网页将要加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
    
}

#pragma mark - 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [SVProgressHUD dismiss];
}
- (void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];

}

@end
