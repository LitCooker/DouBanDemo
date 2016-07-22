//
//  PerAdviceViewController.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/11.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "MainViewController.h"

typedef void(^AdviceBlock)(NSString *);
@interface PerAdviceViewController : MainViewController
@property (nonatomic ,copy)AdviceBlock adviceBlock;
@end
