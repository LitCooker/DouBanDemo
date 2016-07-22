//
//  LoadViewController.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/8.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "MainViewController.h"

typedef void(^LoadSucess)(NSString *);
@interface LoadViewController : MainViewController

@property (nonatomic ,copy)LoadSucess loadBlock;
@end
