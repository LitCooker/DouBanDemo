//
//  DetailSecondCell.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/5.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationModel.h"
@interface DetailSecondCell : UITableViewCell
@property (nonatomic ,strong)LocationModel *model;
@property (nonatomic ,strong)NSString *title;
+ (CGFloat)getCellHeight;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
