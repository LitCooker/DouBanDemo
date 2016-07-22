//
//  HotCityModel.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/1.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "HotCityModel.h"

@implementation HotCityModel
- (id)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.ID = dic[@""];
    }
    return self;
}
@end
