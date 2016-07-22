//
//  InsideViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/29.
//  Copyright © 2016年 CL. All rights reserved.
//
#define TEXTFIELDH 64
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#import "InsideViewController.h"
#import "LocalCityTool.h"
#import "InsideTableViewCell.h"
#import "YLYTableViewIndexView.h"
#import "Masonry/Masonry.h"
@interface InsideViewController ()<UITableViewDataSource,UITableViewDelegate,YLYTableViewIndexDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_titleArraryM;
    NSMutableArray *_contentArraryM;

}
@property (nonatomic, strong) UILabel *flotageLabel;//显示视图
@end

@implementation InsideViewController
- (void)viewWillAppear:(BOOL)animated{
    
    //隐藏显示
    self.flotageLabel.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _titleArraryM = [NSMutableArray array];
    _contentArraryM = [NSMutableArray array];
    //1.
    [self requestChinaCityData];
    //2.
    [self builtTableView];
    
    //3.
    [self initIndexView];
    
}
- (void)initIndexView{
    //加载索引视图
    //indexView
    YLYTableViewIndexView *indexView = [[YLYTableViewIndexView alloc] initWithFrame:(CGRect){SCR_W - 20,0,20,SCR_H}];
    indexView.tableViewIndexDelegate = self;
    [self.view addSubview:indexView];
    
    CGRect rect = indexView.frame;
    rect.size.height = _titleArraryM.count * 25;
    rect.origin.y = (SCR_H - 2 * 64 - rect.size.height) / 2 + 2 * 64 ;
    indexView.frame = rect;

}
- (void)requestChinaCityData{
    [LocalCityTool getChinaCityInfo:^(NSDictionary *dict, NSArray *firstArray, NSArray *secondArray) {
        
        _titleArraryM = [NSMutableArray arrayWithArray:firstArray];
        _contentArraryM = [NSMutableArray arrayWithArray:secondArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_tableView reloadData];
        });
    }];
    
}
- (void)builtTableView{
   
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 2 * TEXTFIELDH) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return _titleArraryM.count  ;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return [_contentArraryM[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CITYNAME"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CITYNAME"];
    }
    NSDictionary *dict = _contentArraryM[indexPath.section][indexPath.row];
    cell.textLabel.text = [dict allKeys][0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = _titleArraryM[section];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor lightTextColor];
    return label;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = _contentArraryM[indexPath.section][indexPath.row];
    NSString *locationID =  [dict allKeys][0];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCityVC" object:locationID];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.hidesBottomBarWhenPushed = NO;
}

//代理方法
- (NSArray *)tableViewIndexTitle:(YLYTableViewIndexView *)tableViewIndex{
    
    return _titleArraryM;
}
- (void)tableViewIndex:(YLYTableViewIndexView *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title{
    
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
}
- (void)tableViewIndexTouchesBegan:(YLYTableViewIndexView *)tableViewIndex{
   
}
- (void)tableViewIndexTouchesEnd:(YLYTableViewIndexView *)tableViewIndex{
        
}
@end
