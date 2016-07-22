//
//  LocalStatuseManager.h
//  DouBanDemo
//
//  Created by qianfeng on 16/6/30.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CityNameBlock)(NSString *);
@interface LocalStatuseManager : NSObject

+ (LocalStatuseManager *)sharedOfLocation;

- (void) currentLocation:(CityNameBlock)locationBlock;

@end
