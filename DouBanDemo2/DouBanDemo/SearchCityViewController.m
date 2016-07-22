//
//  SearchCityViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/29.
//  Copyright © 2016年 CL. All rights reserved.
//
#define TEXTFIELDH 60
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#import "SearchCityViewController.h"
#import "LocalCityTool.h"
#import "RequestDataManager.h"
/**
 *
 */
@interface SearchCityViewController ()<UITableViewDataSource,UISearchBarDelegate,UITableViewDelegate>
{
    UITableView *_tableView;
    UITextField *_textField;
    NSMutableArray *_searchResultArraryM;
    UIView *_hotView;
    NSArray *_dataArrary;
   
}
@property (nonatomic ,strong)NSMutableArray *dataArrayM;
@end

@implementation SearchCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏的颜色
     self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self requestData];
    //1.
    [self builtTableView];
    //2.
    [self builtSearchBar];
}
- (void)requestData{
    NSString *path = @"http://api.douban.com/v2/loc/list";
    [RequestDataManager getHotCityDataWithPath:path completion:^(NSArray *arrary) {
        
        _dataArrary = arrary;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self builtHotCityView:_hotView];
        
        });
        
    } error:^(NSError *errror) {
        
    }];
    
}
- (void)builtTableView{
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 44 - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50;
    //设置属性
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //拖拽时隐藏键盘
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    _hotView = [[UIView alloc]initWithFrame:CGRectMake(0, - 200, SCR_W, 200)];
 
    [_tableView addSubview:_hotView];
    [self.view addSubview:_tableView];
    [self builtHotCityView:_hotView];
    
}
- (void)builtHotCityView:(UIView *)view{
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10,20, 100, 20)];
    titleLable.font = [UIFont systemFontOfSize:20];
    titleLable.text = @"热门城市：";
    titleLable.textColor = [UIColor blackColor];
    [view addSubview:titleLable];
    CGFloat magin = 10;
    CGFloat buttonY = CGRectGetMaxY(titleLable.frame);
    CGFloat buttonX =  0;
    CGFloat buttonW = (SCR_W - 6 * magin)/ 5;
    CGFloat buttonH = (200 - buttonY - 5 *magin)/4;
    for (int i = 0;  i < _dataArrary.count; i++) {
        int x = i % 5;
        int y = i / 5;
        buttonX = buttonW * x + magin *(x + 1);
        buttonY = buttonH * y + magin * (y + 1) + CGRectGetMaxY(titleLable.frame);
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button addTarget:self action:@selector(clickHotCityButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 2000 + i;
        [button setTitle:_dataArrary[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [view addSubview:button];
        
    }
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5;
    view.layer.borderWidth = 2;
    view.layer.borderColor = [UIColor orangeColor].CGColor;
    
}
- (void)clickHotCityButton:(UIButton *)sender{
    
    NSString *cityName = _dataArrary[sender.tag - 2000];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCityVC" object:cityName userInfo:nil];
    });
    
    [self clickCancelButton];
}

- (void)builtSearchBar{
    //1.
    CGFloat searchViewW = SCR_W;
    CGFloat searchViewH = 44;
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, searchViewW, searchViewH)];
    self.navigationItem.titleView = searchView;
    
    //2.导航条的搜索条
    UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f,0.0f,SCR_W - 60,44.0f)];
    searchBar.delegate = self;
    searchBar.layer.masksToBounds = YES;
    searchBar.layer.cornerRadius = 10;
    searchBar.layer.borderColor = [UIColor orangeColor].CGColor;
    searchBar.layer.borderWidth = 2;
    [searchBar setPlaceholder:@"输入城市名查询"];
    [searchView addSubview:searchBar];
    
    //3.
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(SCR_W - 55, 0, 44, 44)];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:cancelButton];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    NSString *resultStr = searchText;
    _searchResultArraryM = [NSMutableArray array];
    NSArray *cityNameArrary = [LocalCityTool getAllCityName];
    for (NSString *cityName in cityNameArrary) {
        NSRange range = [cityName rangeOfString:resultStr];
        if (range.length > 0) {
            [_searchResultArraryM addObject:cityName];
        }
    }
    
    if (_searchResultArraryM.count ==  0) {
        _dataArrayM = nil;
        [_tableView reloadData];
        return;
    }
    _dataArrayM = _searchResultArraryM;
    [_tableView reloadData];
    
}
#pragma  - 点击按钮
- (void)clickCancelButton{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [_textField resignFirstResponder];
}
#pragma mark - 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArrayM.count;
}
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CITY"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CITY"];
    }
    cell.textLabel.text = _searchResultArraryM[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self clickCancelButton];
    NSString *cityName = _searchResultArraryM[indexPath.row];

   
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCityVC" object:cityName userInfo:nil];
    });
}

@end
