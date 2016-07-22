//
//  LocalCityTool.h
//  DouBanDemo
//
//  Created by qianfeng on 16/6/29.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CityInfoBlock)(NSDictionary *diction,NSArray *firstArray,NSArray *secondArray);

@interface LocalCityTool : NSObject

+ (NSArray *)getAllCityName;

/**
 *  获取中国城市信息
 *
 *  @param cityInfoBlock 从本地获取的城市信息
 */
+ (void)getChinaCityInfo:(CityInfoBlock)cityInfoBlock;
/**
 *  获取国外城市信息
 *
 *  @param cityInfoBlock 从本地获取信息
 */
+ (void)getOverSeaCityInfo:(CityInfoBlock)cityInfoBlock;
/**
 *  汉字拼音转换
 *
 *  @param cityName 城市名称
 *
 *  @return <#return value description#>
 */
+ (NSString *)getCityIDByName:(NSString *)cityName;
@end
