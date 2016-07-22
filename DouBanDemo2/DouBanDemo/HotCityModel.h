//
//  HotCityModel.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/1.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotCityModel : NSObject
@property (nonatomic ,strong) NSString *ID;
/** 城市名字 */
@property (nonatomic ,strong) NSString *name;
/** 城市英文名 */
@property (nonatomic ,strong) NSString *uid;
- (id)initWithDictionary:(NSDictionary *)dic;
@end
