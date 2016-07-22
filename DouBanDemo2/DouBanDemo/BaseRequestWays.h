//
//  BaseRequestWays.h
//  DouBanDemo
//
//  Created by qianfeng on 16/6/27.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequestWays : NSObject
/**
 *  get请求
 *
 *  @param path            请求路径
 *  @param completionBlock 数据请求成功回调
 *  @param errorBlock      数据请求失败回调
 */
+ (void)getRequestDataWithPath:(NSString *)path completion:(void(^)(NSData *data))completionBlock error:(void(^)(NSError *error))errorBlock;
/**
 *  post请求
 *
 *  @param path        请求路径
 *  @param body        请求体
 *  @param sucessBlock 数据请求成功回调
 *  @param errorBlock  数据请求失败回调
 */
+ (void)postReuqestWithPath:(NSString *)path httpBody:(NSString *)body sucess:(void (^)(NSData *data))sucessBlock failure:(void (^)(NSError *error))errorBlock;

@end
