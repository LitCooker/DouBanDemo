//
//  AppDelegate.h
//  DouBanDemo
//
//  Created by qianfeng on 16/6/27.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"
#import "LeftSlideViewController.h"
#import "MainTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic ,retain) MainTabBarController *mainTabbar;
@property (nonatomic ,retain)LeftSlideViewController *leftSliderVC;

@end

