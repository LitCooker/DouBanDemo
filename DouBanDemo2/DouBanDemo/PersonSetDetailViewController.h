//
//  PersonSetDetailViewController.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/11.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "MainViewController.h"
typedef void(^SaveBlock)(NSString *);


@interface PersonSetDetailViewController : MainViewController
@property (nonatomic ,copy)SaveBlock block;
@property (nonatomic ,strong)NSString *contenstr;
@end
