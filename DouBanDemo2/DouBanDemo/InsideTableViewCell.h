//
//  InsideTableViewCell.h
//  DouBanDemo
//
//  Created by qianfeng on 16/6/30.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsideTableViewCell : UITableViewCell
+ (CGFloat)getCellHeight;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
