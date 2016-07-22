//
//  LeftViewController.m
//  QQDemo
//
//  Created by qianfeng on 16/6/17.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftPushViewController.h"
#import "AppDelegate.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_arrary;
    NSArray *_urlPath;
}
@end
//http://www.jd.com
@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _urlPath = @[@"http://www.jd.com",
                 @"https://www.taobao.com",
                 @"http://www.xiaohongshu.com",
                 @"http://www.meilishuo.com",
                 @"http://www.yohobuy.com",
                 @"http://www.kaola.com"];
    //1.添加背景图
    [self addImageViewToBackground];
    //2.添加tableView
    [self addTableView];
}
- (void)addTableView{

    _arrary = @[@"京东",@"淘宝",@"小红书",@"美丽说",@"有货",@"网易考拉海购"];
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain ];
    tableView.delegate = self;
    tableView.dataSource = self;
    //隐藏分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //禁止滑动
//    tableView.scrollEnabled = NO;
//    [tableView setSectionHeaderHeight:80];
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 80)];
    tableView.rowHeight = 80;
    
    [self.view addSubview:tableView];
}
- (void)addImageViewToBackground{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageV.image = [UIImage imageNamed:@"timg.jpg"];
    [self.view addSubview:imageV];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrary.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    }
    cell.textLabel.text = _arrary[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftPushViewController *pushVc = [[LeftPushViewController alloc]init];
    AppDelegate *dele = [UIApplication sharedApplication].delegate;
    pushVc.urlString = _urlPath[indexPath.row];
    [dele.leftSliderVC closeLeftView];
    [dele.mainTabbar.selectedViewController pushViewController:pushVc animated:YES];
}
@end
