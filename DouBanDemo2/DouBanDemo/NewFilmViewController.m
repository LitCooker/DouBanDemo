//
//  NewFilmViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/7.
//  Copyright © 2016年 CL. All rights reserved.
//
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#define TextFieldH 44
#define Margin 15
#import "NewFilmViewController.h"
#import "RequestDataManager.h"
#import "NewMovieTableViewCell.h"
#import "MJRefresh.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "HotDetailViewController.h"
@interface NewFilmViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArraryM;
    
    NSInteger _page;
}
@end

@implementation NewFilmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArraryM = [NSMutableArray array];
    _page = 1;
    [self requestData];
    [self builtUI];
 
}
- (void)requestData{
    [SVProgressHUD show];
    [RequestDataManager getNewMovieDataWithType:nil startPage:0 completion:^(NSArray *arrary) {
        if (_page == 1) {
           [_dataArraryM addObjectsFromArray:arrary];
        }else{
            [_dataArraryM addObjectsFromArray:arrary];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            [_tableView.mj_footer endRefreshing];
            [_tableView.mj_header endRefreshing];
            [SVProgressHUD dismiss];
        });
    } error:^(NSError *errror) {
        //预留接口
        
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
}
- (void)builtUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 2 * Margin - 2 * TextFieldH - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 150;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [_dataArraryM removeAllObjects];
        [self requestData];
        
    }];
    
    //上拉加载
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        _page ++;
        [self requestData];
    }];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArraryM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewFilmViewController"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"NewMovieTableViewCell" owner:nil options:nil][0];
    }
    HotMovieModel *model = _dataArraryM[indexPath.row];
    cell.model  = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HotDetailViewController *hotDetailVc = [[HotDetailViewController alloc]init];
    [self.navigationController pushViewController:hotDetailVc animated:YES];
    
    hotDetailVc.urlString = [_dataArraryM[indexPath.row] alt];
}

@end
