//
//  RequestDataManager.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/27.
//  Copyright © 2016年 CL. All rights reserved.
//
//http://api.douban.com/v2/event/list?start=1&loc=nanjing&count=10&type=travel

#define MainUrl @"http://api.douban.com"
//1.获取最近一周内的某个城市的热点活动
#define Loaction_URL [NSString stringWithFormat:@"%@/v2/event/list",MainUrl]
#define Movie_HotURL [NSString stringWithFormat:@"%@/v2/movie/in_theaters",MainUrl]
#define Movie_ComingURL [NSString stringWithFormat:@"%@/v2/movie/coming_soon",MainUrl]

#import "RequestDataManager.h"
#import "BaseRequestWays.h"
#include "LocationModel.h"
#import "HotMovieModel.h"
@implementation RequestDataManager
+ (void)getDataWithStartPage:(NSInteger)page locationId:(NSString *)locatiionId typeId:(NSString *)typeID completion:(void (^)(NSArray *))completionBlock error:(void (^)(NSError *))errorBlock{
    NSString *path = [NSString stringWithFormat:@"%@?start=%ld&loc=%@&count=10&type=%@",Loaction_URL,page,locatiionId,typeID];
    NSLog(@"%@",path);
    [BaseRequestWays getRequestDataWithPath:path completion:^(NSData *data) {
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *arrary = dict[@"events"];
        NSMutableArray *arraryM = [LocationModel arrayOfModelsFromDictionaries:arrary];
        completionBlock(arraryM);
    } error:^(NSError *error) {
        
    }];
 
}

+ (void)getHotMovieDataWithType:(NSString *)movieType startPage:(NSInteger)page completion:(void (^)(NSArray *))completionBlock error:(void (^)(NSError *))errorBlock{
    NSString *path  = [NSString stringWithFormat:@"%@?count=10&start=%ld",Movie_HotURL,page];
 
    [BaseRequestWays getRequestDataWithPath:path completion:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *arrary = dict[@"subjects"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dc in arrary) {
             HotMovieModel *model = [[HotMovieModel alloc]initWithDict:dc];
            [arrM addObject:model];
        }
        completionBlock(arrM);
        
    } error:^(NSError *error) {
        
    }];
    
}
+ (void)getNewMovieDataWithType:(NSString *)movieType startPage:(NSInteger)page completion:(void (^)(NSArray *))completionBlock error:(void (^)(NSError *))errorBlock{
    NSString *path  = [NSString stringWithFormat:@"%@?count=10&start=%ld",Movie_ComingURL,page];
    [BaseRequestWays getRequestDataWithPath:path completion:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *arrary = dict[@"subjects"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dc in arrary) {
            HotMovieModel *model = [[HotMovieModel alloc]initWithDict:dc];
            [arrM addObject:model];
        }
        completionBlock(arrM);
        
    } error:^(NSError *error) {
        
    }];

}

+ (void)getHotCityDataWithPath:(NSString *)path completion:(void (^)(NSArray *))completionBlock error:(void (^)(NSError *))errorBlock{
    
    [BaseRequestWays getRequestDataWithPath:path completion:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *arrary = dict[@"locs"];
        NSMutableArray *arrrM = [NSMutableArray array];
        for (NSDictionary *locDic in arrary) {
            
            NSString *cityName = locDic[@"name"];
            [arrrM addObject:cityName];
            
        }
        
        completionBlock(arrrM);
    } error:^(NSError *error) {
        errorBlock(error);
    }];
    
}
@end
