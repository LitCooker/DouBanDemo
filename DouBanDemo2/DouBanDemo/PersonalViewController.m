//
//  PersonalViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/27.
//  Copyright © 2016年 CL. All rights reserved.
//
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#define LOOP 200
#import "PersonalViewController.h"
#import "LoadViewController.h"
#import "AppDelegate.h"
#import "PesrsonSetViewController.h"
#import "PerIntrestViewController.h"
#import "PerAdviceViewController.h"
#import "SDWebImage/SDImageCache.h"
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *_tableView;
    UIImageView *_expandZoomImageView;
    NSArray *_titleArrary;
    UIButton *_loadButton;
    UIButton *_canceButton;
    UILabel *_loadLable;
    UIImage *_iconImage;
    
    float sumSize_M;
}
@end

@implementation PersonalViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [self getCacheSize];
    [_tableView reloadData];
    
}
- (void)getCacheSize{
    long long sumSize_B = 0;
    sumSize_M = 0.0;
    //1.
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    //2.
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:cacheFilePath]) {
        NSArray *subPaths = [manager subpathsAtPath:cacheFilePath];
        for (NSString *subPath in subPaths) {
            NSString *filePath = [cacheFilePath stringByAppendingFormat:@"/%@",subPath];
            long long size = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
            sumSize_B += size;
        }
        
//        sumSize_B = [[SDImageCache sharedImageCache]getSize ];
    }
    
    sumSize_M = sumSize_B / (1000.0 * 1000.0) * 1.0;
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArrary = @[@"个人设置",@"我的订单",@"我的收藏",@"缓存",@"意见反馈"];
    _iconImage = [UIImage imageNamed:@"smiling_128px"];
    //1.
    [self builtUI];
    
    //
    [self builtNavigationBarButton];
    
}

- (void)builtNavigationBarButton{
    
    _canceButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_canceButton setTitle:@"注销" forState:UIControlStateNormal];
    [_canceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:_canceButton];
    [_canceButton addTarget:self action:@selector(clickCanclButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = bar;
    _canceButton.hidden = YES;
    _loadLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    _loadLable.text = @"未登录";
    _loadLable.textColor = [UIColor blackColor];
    _loadLable.font = [UIFont systemFontOfSize:20];
    UIBarButtonItem *barri = [[UIBarButtonItem alloc]initWithCustomView:_loadLable];
    
    self.navigationItem.leftBarButtonItem = barri;

}
- (void)clickCanclButton:(UIButton *)sender{
    _iconImage = [UIImage imageNamed:@"smiling_128px"];
    [_loadButton setImage:_iconImage forState:UIControlStateNormal];
    _loadLable.hidden = NO;
    _canceButton.hidden = YES;
    NSString *content = @"注销成功";
    [self popTitle:content];
}
- (void)builtUI{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.rowHeight = 70;
    _tableView.contentInset = UIEdgeInsetsMake(LOOP, 0, 0, 0);
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _expandZoomImageView = [[UIImageView alloc] init];
    _expandZoomImageView.frame = CGRectMake(0, - LOOP, SCR_W, LOOP);
    _expandZoomImageView.userInteractionEnabled = YES;
  
    _expandZoomImageView.image = [UIImage imageNamed:@"detail_defultImage.png"];
    CGFloat buttonW = 100;
    CGFloat buttonX = (SCR_W - 100)/2;
    CGFloat buttonY = (LOOP - 100)/2;
    _loadButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonW)];
    [_expandZoomImageView addSubview:_loadButton];
    _loadButton.backgroundColor = [UIColor whiteColor];
    _loadButton.layer.cornerRadius = 8;
    _loadButton.layer.borderColor = [UIColor redColor].CGColor;
    _loadButton.layer.borderWidth = 2;
    [_loadButton setImage:_iconImage forState:UIControlStateNormal];
    _loadButton.layer.masksToBounds = YES;
   
    [_loadButton addTarget:self action:@selector(clickLoadButton:) forControlEvents:UIControlEventTouchUpInside];

    [_tableView addSubview: _expandZoomImageView];
    
}
- (void)clickLoadButton:(UIButton *)sender{
    
    if (!_canceButton.hidden) {
        NSString *content = @"请先注销登录";
        [self popTitle:content];
        return;
    }
    LoadViewController *load = [[LoadViewController alloc] init];
    load.loadBlock = ^(NSString *user){
        
            dispatch_async(dispatch_get_main_queue(), ^{
                _loadLable.hidden = YES;
                [_loadButton setTitle:user forState:UIControlStateNormal];
                _canceButton.hidden = NO;
                [_canceButton setNeedsDisplay];
            });
        
        
    };
    [self.navigationController pushViewController:load animated:YES];
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _titleArrary.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalViewController"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PersonalViewController"];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _titleArrary[indexPath.row];

    if (indexPath.row == 3) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",sumSize_M];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //缓存
    if (indexPath.row == 3) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"缓存清除" message:@"确定清除缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alertView show];
        
        return;
    }

    if (!_loadLable.hidden) {
        NSString *title = @"请先登录";
        [self popTitle:title];
        
        return;
    }
    if (indexPath.row == 0) {
        
        //设置个人信息
        PesrsonSetViewController * persSet = [[PesrsonSetViewController alloc]init];
        persSet.image = _iconImage;
        persSet.returnPicBlock = ^(UIImage *image){
            _iconImage = image;
            [_loadButton setImage:image forState:UIControlStateNormal];
        };
        [self.navigationController pushViewController:persSet animated:YES];
    }
    //订单
    if (indexPath.row == 1) {
        return;
        
    }
    //收藏
    if (indexPath.row == 2) {
        PerIntrestViewController *per = [[PerIntrestViewController alloc]init];
        
        
        [self.navigationController pushViewController:per animated:YES];
        return;
    }
       //意见反馈
    if (indexPath.row == 4) {
        
        PerAdviceViewController *perAdvice = [[PerAdviceViewController alloc]init];
        
        [self.navigationController pushViewController:perAdvice animated:YES];
        
        return;
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
        if ([fileManager fileExistsAtPath:cacheFilePath]) {
            NSArray *childFiles = [fileManager subpathsAtPath:cacheFilePath];
            for (NSString *fileName in childFiles) {
                 NSString *filePath = [cacheFilePath stringByAppendingFormat:@"/%@",fileName];
                [fileManager removeItemAtPath:filePath error:nil];
            }
            
        }
        
        [self getCacheSize];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    }
}
- (void)popTitle:(NSString *)content{
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //1.
    UIAlertAction *alertActionOne = [UIAlertAction actionWithTitle:content style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertSheet addAction:alertActionOne];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //completion  结束后需要执行的代码
    [delegate.window.rootViewController presentViewController:alertSheet animated:YES completion:nil];
}

@end
