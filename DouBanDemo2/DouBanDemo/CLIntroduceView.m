//
//  CLIntroduceView.m
//  ChenLeiYouJi
//
//  Created by qianfeng on 16/6/23.
//  Copyright © 2016年 CL. All rights reserved.
//
#define VIEW_W self.frame.size.width
#define VIEW_H self.frame.size.height
#import "CLIntroduceView.h"

@interface CLIntroduceView ()<UIScrollViewDelegate>
{
    NSArray *_arrayOfImageNames;// 图片名称
    UIScrollView *_scrollView; // 展示图片
    UIPageControl *_pageControl; // 分页
}
@end
@implementation CLIntroduceView
- (instancetype)initWithImageNamesOfArray:(NSArray *)array frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 1. 设置引导页大小
        self.frame = frame;
        
        // 2. 获取引导页图片名称
        _arrayOfImageNames = array;
        
        // 3. 添加UISCrollView
        [self addScroView];
        
        // 4. 添加分页控制器
        [self addPageControl];
        
        // 5. 添加进入app的按钮
        [self addEnterButton];
    }
    return self;
}

- (void)addEnterButton
{
    
    CGFloat btnX = (_arrayOfImageNames.count - 1) * VIEW_W;
    CGFloat btnH = 80;
    CGFloat btnW = VIEW_W;
    CGFloat btnY = VIEW_H - 2* btnH;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    [btn setTitle:@"Welcome To APP" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:30];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickEnterButton) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btn];
}

- (void)clickEnterButton
{
    // 3.存储
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"INTRODUCEVIEW" forKey:@"INTRODUCEVIEW"];
    
    [UIView animateWithDuration:2.0 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformScale(self.transform, 2.0, 2.0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)addScroView
{
    // 1. 获取滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.contentSize = CGSizeMake(VIEW_W * _arrayOfImageNames.count, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    // 2. 添加图片
    for (int i = 0; i < _arrayOfImageNames.count; i ++) {
        // 2.1 获取图片
        UIImage *image = [UIImage imageNamed:_arrayOfImageNames[i]];
        // 2.2 获取图片视图
        CGFloat imageViewX = VIEW_W * i;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, 0, VIEW_W, VIEW_H)];
        imageView.image = image;
        // 2.3 把图片添加到滚动视图
        [_scrollView addSubview:imageView];
    }
    
    // 3. 把滚动视图添加到View
    [self addSubview:_scrollView];
}

- (void)addPageControl
{
    // 1. 获取去分页控制器对象
    CGFloat pageControlX = 0;
    CGFloat pageControlW = VIEW_W;
    CGFloat pageControlH = 60;
    CGFloat pageControlY = VIEW_H - pageControlH;
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH)];
    
    // 2. 设置属性
    _pageControl.numberOfPages = _arrayOfImageNames.count;
    _pageControl.userInteractionEnabled = NO;
    
    // 3. 添加到界面
    [self addSubview:_pageControl];
}

#pragma mark - 建立滚动视图和分页控制器的关联
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger numOfPage = offSetX / VIEW_W;
    //    NSInteger numOfPage = offSetX / _scrollView.frame.size.width;
    _pageControl.currentPage = numOfPage;
    
}
@end
