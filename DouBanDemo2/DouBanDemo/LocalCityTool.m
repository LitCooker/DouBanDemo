//
//  LocalCityTool.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/29.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "LocalCityTool.h"

@implementation LocalCityTool
+ (NSArray *)getAllCityName{
    NSString *allCityName = [[NSBundle mainBundle] pathForResource:@"AllCityName" ofType:@""];
    NSError *error = nil;
    NSString *name = [[NSString alloc] initWithContentsOfFile:allCityName encoding:NSUTF8StringEncoding error:&error];
    NSArray *cityNameArray = [name componentsSeparatedByString:@"city="];
    return cityNameArray;

}
+ (void)getChinaCityInfo:(CityInfoBlock)cityInfoBlock{
    
    //1.所有分区对应的字典
    NSString *inlandPlistURL = [[NSBundle mainBundle] pathForResource:@"inLandCityGroup" ofType:@"plist"];
    NSDictionary *cityGroupDic = [[NSDictionary alloc] initWithContentsOfFile:inlandPlistURL];
    
    //2.所有分区
    NSArray *sections = [cityGroupDic allKeys];
    sections = [sections sortedArrayUsingSelector:@selector(compare:)]; // 对该数组里边的元素进行升序排序
    //3.所有城市
    NSArray *indexs = [cityGroupDic objectsForKeys:sections notFoundMarker:@""];
    
    
    if (cityInfoBlock) {
        cityInfoBlock(cityGroupDic,sections,indexs);
    }
}

+ (void)getOverSeaCityInfo:(CityInfoBlock)cityInfoBlock{
    NSString *outlandCityPath = [[NSBundle mainBundle]pathForResource:@"outLandCityGroup" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:outlandCityPath];
    NSArray *titleArrary = [dict allKeys];

    titleArrary = [titleArrary sortedArrayUsingSelector:@selector(compare:)];
    NSArray *contentArrary = [dict objectsForKeys:titleArrary notFoundMarker:@""];
    if (cityInfoBlock) {
        cityInfoBlock(dict,titleArrary,contentArrary);
    }
}
//通过城市名字，返回城市对应的ID
+ (NSString *)getCityIDByName:(NSString *)cityName
{
    NSString *allCityName = [[NSBundle mainBundle] pathForResource:@"AllCityName" ofType:@""];
    NSError *error = nil;
    NSString *name = [[NSString alloc] initWithContentsOfFile:allCityName encoding:NSUTF8StringEncoding error:&error];
    
    NSString *allcityID = [[NSBundle mainBundle] pathForResource:@"AllCityID" ofType:@""];
    NSString *ID = [[NSString alloc] initWithContentsOfFile:allcityID encoding:NSUTF8StringEncoding error:&error];
    
    int cityID = -1;
    NSArray *cityNameArray = [name componentsSeparatedByString:@"city="];
    NSArray *cityIDArray = [ID componentsSeparatedByString:@"uid="];
    //通过城市名查找城市对应ID号
    for (int i = 0; i < [cityNameArray count]; i++) {
        if ([cityNameArray[i] isEqualToString:cityName]) {
            cityID = i;
            break;
        }
    }
    //如果不能发现城市ID，返回错误提示信息
    if (cityID == -1) {
        return @"不能发现城市ID,请检查输入的城市名字";
    }
    //返回找到的正确的城市ID
    return cityIDArray[cityID];
}

@end
