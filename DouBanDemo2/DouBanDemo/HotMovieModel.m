//
//  HotMovieModel.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/7.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "HotMovieModel.h"
/*
 @property (nonatomic ,strong)NSString *alt;
 @property (nonatomic ,strong)NSArray *casts;
 @property (nonatomic ,strong)NSString *collect_count;
 @property (nonatomic ,strong)NSArray *directors;
 @property (nonatomic ,strong)NSArray *genres;
 @property (nonatomic ,strong)NSString *id_list;
 @property (nonatomic ,strong)NSDictionary *images;
 @property (nonatomic ,strong)NSString * original_title;
 @property (nonatomic ,strong)NSDictionary *rating;
 @property (nonatomic ,strong)NSString *title;
 @property (nonatomic ,strong)NSString *subtype;
 @property (nonatomic ,strong)NSString *year;

 */
@implementation HotMovieModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self ) {
        _alt = dict[@"alt"];
        _title = dict[@"title"];
        _directors = dict[@"directors"];
        _casts = dict[@"casts"];
        _rating = dict[@"rating"];
        _images = dict[@"images"];
        _year = dict[@"year"];
    }
    
    return self;
}
@end
