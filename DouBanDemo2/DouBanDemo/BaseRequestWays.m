//
//  BaseRequestWays.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/27.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "BaseRequestWays.h"

@implementation BaseRequestWays
+ (void)getRequestDataWithPath:(NSString *)path completion:(void (^)(NSData *))completionBlock error:(void (^)(NSError *))errorBlock{
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            completionBlock(data);
        }else{
            errorBlock(error);
        }
    }];
    [task resume];
}
#pragma mark - POST请求
+ (void)postReuqestWithPath:(NSString *)path httpBody:(NSString *)body sucess:(void (^)(NSData *))sucessBlock failure:(void (^)(NSError *))errorBlock{
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    request.HTTPMethod = @"POST";

    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            sucessBlock(data);
        }else {
            errorBlock(error);
        }
    }];
    [task resume];
}

@end
