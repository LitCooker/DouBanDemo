//
//  HotMovieTableViewCell.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/7.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotMovieModel.h"
#import "StarView/StarView.h"
@interface HotMovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *actorLale;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet StarView *starView;

@property (weak, nonatomic) IBOutlet UILabel *ratingLable;
@property (weak, nonatomic) IBOutlet UILabel *directorLable;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
- (IBAction)clickButton:(id)sender;

@property(nonatomic ,strong)HotMovieModel *model;
@end
