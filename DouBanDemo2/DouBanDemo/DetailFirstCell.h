//
//  DetailFirstCell.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/5.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationModel.h"
@interface DetailFirstCell : UITableViewCell
@property (nonatomic ,strong)LocationModel *model;
+ (CGFloat)getCellHeightWithModel:(LocationModel *)model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
