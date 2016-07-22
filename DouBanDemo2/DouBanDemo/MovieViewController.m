//
//  MovieViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/7.
//  Copyright © 2016年 CL. All rights reserved.
//

#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#define TextFieldH 44
#define Margin 15
#import "MovieViewController.h"
#import "HotFilmViewController.h"
#import "NewFilmViewController.h"
@interface MovieViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    
    NSInteger _selBtnTag;
}
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //0.
    [self setNavigationBar];
    //1.
    [self builtUI];
  
    
}
#pragma mark - 设置导航栏
- (void)setNavigationBar{
    [self.navigationController.navigationBar setTranslucent:NO];
    
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, TextFieldH)];
    
    title.text = @"电影";
    title.font = [UIFont systemFontOfSize:20];
    title.textAlignment = NSTextAlignmentCenter;
    
    title.textColor = [UIColor blackColor];
    
    self.navigationItem.titleView = title;
}
#pragma  mark - 搭建UI
- (void)builtUI{
    //点击按钮
    NSArray *arrary = @[@"正在热映",@"即将上映"];
    CGFloat buttonX = (SCR_W - 3 * Margin)/ 2;
    for (NSInteger i = 0; i < arrary.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX * i + Margin * (i + 1), Margin, buttonX, TextFieldH)];
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        button.tag = 100 + i;
        [button setTitle:arrary[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button  addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 8;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 1;
        button.layer.masksToBounds = YES;
        if (i == 0) {
            button.selected = YES;
            _selBtnTag = button.tag;
            button.layer.borderColor = [UIColor orangeColor].CGColor;
            
        }
        [self.view addSubview:button];
    }
    //滑动ScrollView
    HotFilmViewController *hotVc = [[HotFilmViewController alloc]init];
    [self addChildViewController:hotVc];
    
    NewFilmViewController *newVc  = [[NewFilmViewController alloc]init];
    [self addChildViewController:newVc];
    NSMutableArray *childVCArraryM = [NSMutableArray arrayWithObjects:hotVc,newVc, nil];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, TextFieldH + 2 * Margin, SCR_W, SCR_H - 2 * TextFieldH - 2* Margin)];
       _scrollView.contentSize = CGSizeMake(SCR_W * arrary.count, 0);
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < childVCArraryM.count; i++) {
        UIViewController *viewC = childVCArraryM[i];
        viewC.view.frame = CGRectMake(SCR_W * i, 0, SCR_W,_scrollView.frame.size.height);
        [_scrollView addSubview:viewC.view];
    }

}
#pragma mark －点击方法
- (void)clickButton:(UIButton *)sender{
    if (sender.tag == _selBtnTag) {
        return;
    }
    UIButton *button = [self.view viewWithTag:_selBtnTag];
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.selected = NO;
    sender.selected = YES;
    sender.layer.borderColor = [UIColor orangeColor].CGColor;
    _selBtnTag = sender.tag;
    
    if (sender.tag == 100) {
        
        _scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        _scrollView.contentOffset = CGPointMake(SCR_W, 0);
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger pageIndex = (NSInteger)scrollView.contentOffset.x/SCR_W;
    if (pageIndex + 100 == _selBtnTag) {
        return;
    }
    
    UIButton *lastButton = [self.view viewWithTag:pageIndex + 100];
    [self clickButton:lastButton];
}


@end
