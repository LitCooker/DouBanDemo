//
//  SelectCityViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/28.
//  Copyright © 2016年 CL. All rights reserved.
//
#define TEXTFIELDH 64
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#import "SelectCityViewController.h"
#import "InsideViewController.h"
#import "OutsideViewController.h"
#import "SearchCityViewController.h"
@interface SelectCityViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *_childVCArraryM;
    UISegmentedControl *_segement;
    UISearchBar *_mySearchBar;
    
}
@property (nonatomic ,strong)UIScrollView *backScrollView;
@property (nonatomic ,strong)UIView *backView;
@end
@implementation SelectCityViewController
- (void)viewWillAppear:(BOOL)animated{
    
    
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    //1.
    [self addSegmentedControl];
    //2.
    [self addViewControllerToScrollView];
    //3.
    [self addSearchBar];
}
- (void)addSearchBar{
    _mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCR_W, TEXTFIELDH)];
    _mySearchBar.placeholder = @"输入城市名查询";
    _mySearchBar.userInteractionEnabled = YES;
    _mySearchBar.backgroundImage = [UIImage imageNamed:@"searchBarBackImage"];
    UITextField *txfSearchField = [_mySearchBar valueForKey:@"_searchField"];
    txfSearchField.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, SCR_W, TEXTFIELDH);
    [btn addTarget:self action:@selector(pushSearchViewController:) forControlEvents:UIControlEventTouchUpInside];
    [_mySearchBar addSubview:btn];
    [self.view addSubview:_mySearchBar];
}

- (void)pushSearchViewController:(UIButton* )sender{
    SearchCityViewController *searchVc = [[SearchCityViewController alloc]init];
    //隐藏返回按钮
    searchVc.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:searchVc animated:NO];
}
- (void)addSegmentedControl{
    NSArray *arrary = @[@"国内",@"国外"];
     _segement= [[UISegmentedControl alloc]initWithItems:arrary];
    _segement.frame = CGRectMake(0, 0, 150, 30);
    _segement.selectedSegmentIndex = 0;
    [_segement addTarget:self action:@selector(clickSegement:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segement;
}
#pragma  mark － 页面切换
- (void)clickSegement:(UISegmentedControl *)sender{
    
    NSInteger selectIndex = sender.selectedSegmentIndex;
    self.backScrollView.contentOffset = CGPointMake(SCR_W * selectIndex, 0);
}
- (void)addViewControllerToScrollView{
    InsideViewController *insideVc = [[InsideViewController alloc]init];
    OutsideViewController *outsideVc = [[OutsideViewController alloc]init];
    [self addChildViewController:insideVc];
    [self addChildViewController:outsideVc];
    _childVCArraryM = [NSMutableArray arrayWithObjects:insideVc,outsideVc,nil];
    
    //搭建SCrollView；
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.backView];
    
    self.backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 64)];
    
    _backScrollView.pagingEnabled = YES;
    _backScrollView.showsHorizontalScrollIndicator = NO;
    _backScrollView.delegate = self;
    _backScrollView.contentSize = CGSizeMake(_childVCArraryM.count * SCR_W, 0);
    _backScrollView.bounces = NO;
    [self.backView addSubview:_backScrollView];
    for (int i = 0; i < _childVCArraryM.count; i++) {
        UIViewController *viewC = _childVCArraryM[i];
        viewC.view.frame = CGRectMake(SCR_W * i, 0, SCR_W,_backScrollView.frame.size.height);
        [_backScrollView addSubview:viewC.view];
    }
    //设置默认页面
    _backScrollView.contentOffset = CGPointMake(0, 0);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger pageIndex = (NSInteger)scrollView.contentOffset.x/SCR_W;
    [_segement setSelectedSegmentIndex:pageIndex];
}
@end
