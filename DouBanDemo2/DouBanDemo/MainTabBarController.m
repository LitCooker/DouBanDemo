//
//  MainTabBarController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/27.
//  Copyright © 2016年 CL. All rights reserved.
//
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#import "MainTabBarController.h"
#import "CLIntroduceView.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //1.
    [self addIntrodeuceView];
    //2.
    [self addViewControllerToTabBar];
}
- (void)addIntrodeuceView{
    NSArray *arrary = @[@"first",@"end",@"third"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [defaults objectForKey:@"INTRODUCEVIEW"];
    if (!str) {
        CLIntroduceView *introV = [[CLIntroduceView alloc]initWithImageNamesOfArray:arrary frame:self.view.frame];
        [self.view addSubview:introV];
    }
    
}
- (void)addViewControllerToTabBar{
    
    NSArray *titleArrary = @[@"同城",@"电影",@"个人"];
    NSArray *norImageArrary = @[@"tabbar_discover", @"tabbar_contacts",@"tabbar_me"];

   
    NSArray *seImageArrary = @[@"tabbar_discoverHL", @"tabbar_contactsHL",@"tabbar_meHL"];
    NSArray *VCArrary = @[@"LocalCityViewController",@"MovieViewController",@"PersonalViewController"];
    NSMutableArray *arraryM = [NSMutableArray array];
    for (int i = 0; i < titleArrary.count; i++) {
        Class cls = NSClassFromString(VCArrary[i]);
        UIViewController *viewC = [[cls alloc]init];
        viewC.tabBarItem.title = titleArrary[i];
        UINavigationController *naVc = [[UINavigationController alloc]initWithRootViewController:viewC];
        if (iOS7) {
            viewC.tabBarItem.image = [[UIImage imageNamed:norImageArrary[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            viewC.tabBarItem.selectedImage = [[UIImage imageNamed:seImageArrary[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else{
            viewC.tabBarItem.selectedImage = [[UIImage imageNamed:seImageArrary[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        [arraryM addObject:naVc];
    }
    self.viewControllers = arraryM;
}
@end
