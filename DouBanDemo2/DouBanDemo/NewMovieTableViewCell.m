//
//  NewMovieTableViewCell.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/7.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "NewMovieTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "HotMovieModel.h"
@implementation NewMovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(HotMovieModel *)model{
    _model = model;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_iconIamgeView sd_setImageWithURL:[NSURL URLWithString:model.images[@"large"]] placeholderImage:nil];
    _timeLable.text = [NSString stringWithFormat:@"上映时间: %@",_model.year];
    
    _titleLab.text = _model.title;
    NSDictionary *dict = _model.rating;
    NSNumber *num = dict[@"average"];
    if (![num isEqualToNumber:@0]) {
         _starLable.text = [NSString stringWithFormat:@"%@",num];
    }else{
        _starLable.text = @"暂无评分";
    }
   
    NSArray *actArr = _model.casts;
    NSString *actStr = @"";
    for (int i = 0; i < actArr.count; i ++ ) {
        if (i == 0) {
            actStr = [NSString stringWithFormat:@"演员: %@",actArr[0][@"name"]];
        }else{
            actStr = [NSString stringWithFormat:@"%@/%@",actStr,actArr[i][@"name"]];
        }
        
    }
    
    _actorLable.text =  actStr;
    
}
@end
