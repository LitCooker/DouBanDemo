//
//  PesrsonSetViewController.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/9.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "MainViewController.h"

typedef void(^ReturnPicBlock)(UIImage *);
@interface PesrsonSetViewController : MainViewController
@property (nonatomic ,strong)UIImage *image;
@property (nonatomic ,copy)ReturnPicBlock returnPicBlock;
@end
