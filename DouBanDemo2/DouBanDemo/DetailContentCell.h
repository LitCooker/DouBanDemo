//
//  DetailContentCell.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/5.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationModel.h"

@interface DetailContentCell : UITableViewCell
@property (nonatomic ,assign)CGFloat cellHeight;
@property (nonatomic ,strong)LocationModel *model;

+ (CGFloat)getCellHeight:(LocationModel *)model;
@end
