//
//  LocalTableViewCell.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/4.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locationLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;

@end
