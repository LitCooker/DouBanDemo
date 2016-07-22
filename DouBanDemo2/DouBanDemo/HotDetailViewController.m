//
//  HotDetailViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/7.
//  Copyright © 2016年 CL. All rights reserved.
//
#define LOOP 280
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#import "HotDetailViewController.h"
#import "SVProgressHUD/SVProgressHUD.h"
@interface HotDetailViewController ()<UIWebViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation HotDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    //展示网友
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.frame];
    //获取代理
    web.delegate = self;
    
    //2.获取url  包括本地路径
    NSURL *url = [NSURL URLWithString:self.urlString];
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
