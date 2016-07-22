//
//  LocationPushViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/4.
//  Copyright © 2016年 CL. All rights reserved.
//
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#define ContenInsetH 250
#import "LocationPushViewController.h"
#import "DetailFirstCell.h"
#import "UIImageView+WebCache.h"
#import "DetailSecondCell.h"
#import "DetailContentCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "MapViewController.h"
@interface LocationPushViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIImageView *_expandZoomImageView;
}
@end

@implementation LocationPushViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //1.
    [self builtUI];
    
    //2.
    [self builtNavBarBtn];
}
- (void)builtNavBarBtn{
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setTitle:@"分享" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = barItem;
    
    
}
- (void)clickButton:(UIButton *)sender{
    
    NSArray *imageArrary = @[[UIImage imageNamed:@"shareImg"]];
    if (imageArrary) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容" images:imageArrary url:[NSURL URLWithString: @"http://mob.cn"] title:@"分享标题" type:SSDKContentTypeAuto ];

        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                        message:nil delegate:nil 
                        cancelButtonTitle:@"确定"
                        otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                        message:[NSString stringWithFormat:@"%@",error]
                    delegate:nil
                    cancelButtonTitle:@"OK"
                    otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                default:
                    break;
            }
         
        }];
    }
}
- (void)builtUI{
    _tableView =  [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 44) style:UITableViewStylePlain];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(ContenInsetH, 0, 0, 0);
    [self.view addSubview:_tableView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, - ContenInsetH, SCR_W, ContenInsetH)];
    view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
    [_tableView addSubview:view];
    //背景
    _expandZoomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.15 * SCR_W, ContenInsetH * 0.15, SCR_W * 0.7 , ContenInsetH * 0.7)];

    [view addSubview:_expandZoomImageView];
    NSURL *url = [NSURL URLWithString:_model.image];
    [_expandZoomImageView sd_setImageWithURL:url placeholderImage:nil];
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0) {
      DetailFirstCell *cell =  [DetailFirstCell cellWithTableView:tableView ];
        cell.model = _model;
        return cell;
        
    }else if (indexPath.row == 1 || indexPath.row == 2){
        
        DetailSecondCell *cell = [DetailSecondCell cellWithTableView:tableView];
       
        switch (indexPath.row) {
            case 1:
                cell.model = _model;
                cell.title = @"即时讨论";
                
                break;
            case 2:
                cell.model = _model;
                cell.title = @"定位";
                break;
            default:
                break;
        }
        return cell;
    }
    
    else{
        DetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailContentCell"];
        if (cell == nil) {
            cell = [[DetailContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetailContentCell"];
        }
        cell.model = _model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return [DetailFirstCell getCellHeightWithModel:_model];
    }else if (indexPath.row == 1 || indexPath.row == 2){
        return [DetailSecondCell getCellHeight];
    }else{
        return [DetailContentCell getCellHeight:_model];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        MapViewController *mapVc = [[MapViewController alloc]init];
        mapVc.address  = _model.address;
        mapVc.geo = _model.geo;
        mapVc.activityName = _model.title;
        
        [self.navigationController pushViewController:mapVc animated:YES];
    }
}
@end

