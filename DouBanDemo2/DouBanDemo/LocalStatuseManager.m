//
//  LocalStatuseManager.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/30.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "LocalStatuseManager.h"
@import CoreLocation;
#import "SVProgressHUD/SVProgressHUD.h"
#import "CLLocation+Sino.h"
#import "LocalCityTool.h"
static LocalStatuseManager *manager;
@interface LocalStatuseManager ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locaManager;
}
@property (nonatomic ,strong)NSString *cityName;

@end
@implementation LocalStatuseManager
+ (LocalStatuseManager *)sharedOfLocation{
    //单利
    @synchronized(self){
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            manager = [[self alloc] init];
        });
    }
    return manager;
}
- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self initLocalManager];
    }
    return self;
}
- (void)initLocalManager{
    if ([CLLocationManager locationServicesEnabled]) {
        _locaManager = [[CLLocationManager alloc] init];
        _locaManager.delegate = self;
        _locaManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _locaManager.distanceFilter = 100;
//        [_locaManager startUpdatingLocation];
    }
}
- (void)currentLocation:(CityNameBlock)locationBlock{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    [self locationManager:_locaManager didChangeAuthorizationStatus:status];
    locationBlock(_cityName);
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusNotDetermined) { // 如果授权状态还没有被决定就弹出提示框
        if ([_locaManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locaManager requestAlwaysAuthorization];
        }
    } else if (status == kCLAuthorizationStatusDenied) { // 如果授权状态是拒绝就给用户提示
        [SVProgressHUD showErrorWithStatus:@"请前往设置-隐私-定位中打开定位服务"];
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) { // 如果授权状态可以使用就开始获取用户位置
        [_locaManager startUpdatingLocation];
    }

}

#pragma mark － 代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //停止定位服务
    [_locaManager stopUpdatingLocation];
    //获取用户最后的位置
    CLLocation *lastLocation = locations.lastObject;
    //天朝坐标
    CLLocation *marsLocation = [lastLocation locationBearPawFromMars ];
    
    CLGeocoder *gecoder = [[CLGeocoder alloc]init];
    [gecoder reverseGeocodeLocation:marsLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *mark in placemarks) {
            NSDictionary *dict = mark.addressDictionary;
            NSLog(@"%@",dict);
           
            
        }
        
    }];
}

@end
