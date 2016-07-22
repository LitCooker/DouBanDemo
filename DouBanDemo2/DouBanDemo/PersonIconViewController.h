//
//  PersonIconViewController.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/11.
//  Copyright © 2016年 CL. All rights reserved.
//
#import "MainViewController.h"
typedef void(^SavePicBlock)(UIImage *);

@interface PersonIconViewController : MainViewController

@property (nonatomic ,strong)UIImage *image;
@property (nonatomic ,copy)SavePicBlock picBlock;
@end
