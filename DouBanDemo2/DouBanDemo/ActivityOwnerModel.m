//
//  ActivityOwnerModel.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/3.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "ActivityOwnerModel.h"

@implementation ActivityOwnerModel
+ (JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ID"}];
}
@end
