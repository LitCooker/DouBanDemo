//
//  RequestDataManager.h
//  DouBanDemo
//
//  Created by qianfeng on 16/6/27.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestDataManager : NSObject
/**
 *  数据请求
 *
 *  @param page            起始页面
 *  @param locatiionId     城市Id
 *  @param typeID          类型ID
 *  @param completionBlock 数据请求成功
 *  @param errorBlock      数据请求失败
 */
+ (void)getDataWithStartPage:(NSInteger)page locationId:(NSString *)locatiionId typeId:(NSString *)typeID completion:(void(^)(NSArray *arrary))completionBlock error:(void(^)(NSError *errror))errorBlock;
/**
 *  电影数据请求
 *
 *  @param movieType       电影类型
 *  @param page            起始页数
 *  @param completionBlock 数据请求成功
 *  @param errorBlock      数据请求失败
 */
+ (void)getHotMovieDataWithType:(NSString *)movieType startPage:(NSInteger)page completion:(void(^)(NSArray *arrary))completionBlock error:(void(^)(NSError *errror))errorBlock;
/**
 *  
 *
 *  @param movieType       <#movieType description#>
 *  @param page            <#page description#>
 *  @param completionBlock <#completionBlock description#>
 *  @param errorBlock      <#errorBlock description#>
 */
+ (void)getNewMovieDataWithType:(NSString *)movieType startPage:(NSInteger)page completion:(void(^)(NSArray *arrary))completionBlock error:(void(^)(NSError *errror))errorBlock;

/**
 *  <#Description#>
 *
 *  @param path            <#path description#>
 *  @param completionBlock <#completionBlock description#>
 *  @param errorBlock      <#errorBlock description#>
 */
+ (void)getHotCityDataWithPath:(NSString *)path completion:(void(^)(NSArray *arrary))completionBlock error:(void(^)(NSError *errror))errorBlock;
@end
