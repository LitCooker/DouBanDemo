//
//  NewMovieTableViewCell.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/7.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotMovieModel.h"
@interface NewMovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *starLable;
@property (weak, nonatomic) IBOutlet UILabel *actorLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UIImageView *iconIamgeView;

@property (nonatomic ,strong)HotMovieModel *model;
@end
