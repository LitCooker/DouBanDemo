//
//  AppDelegate.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/27.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"

//weibo App Key：4077157118
//      App Secret：5922e2c4ff342f9c5ad32b2fee408cad

//APP ID 1105449493APP KEY 7gimRoRuaiVhY8Db
#define WeiBoAppKey @"4077157118"
#define WeiBoAppSecret @"5922e2c4ff342f9c5ad32b2fee408cad"
#define QQAppID @"1105449493 "
#define QQAppKey @"7gimRoRuaiVhY8Db"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _mainTabbar = [[MainTabBarController alloc]init];
    LeftViewController *leftVC = [[LeftViewController alloc]init];
    _leftSliderVC = [[LeftSlideViewController alloc]initWithLeftView:leftVC andMainView:_mainTabbar];
    self.window.rootViewController = _leftSliderVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    //Register
    [ShareSDK registerApp:@"14979136b6f60"
        activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                          @(SSDKPlatformTypeWechat),
                          @(SSDKPlatformTypeQQ)]
        onImport:^(SSDKPlatformType platformType) {
        switch (platformType) {
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        
        switch (platformType) {
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:QQAppID appKey:QQAppKey authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey: WeiBoAppKey appSecret:WeiBoAppSecret redirectUri:@"http://www.sinaweibosso.4077157118.cn" authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx535980b0bfc6061e" appSecret:@"b7143edaaafe32ef9ef63454e49ac919"];
                break;
            default:
                break;

        }
    }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
