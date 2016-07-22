//
//  HotMovieTableViewCell.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/7.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "HotMovieTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HotMovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(HotMovieModel *)model{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    _model = model;
    
    _titleLable.text = _model.title;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.images[@"large"]] placeholderImage:nil];
    CGFloat star = (CGFloat ) [_model.rating[@"average"] floatValue] / 10 *  5;
    [_starView setStar:star];
    if (star == 0) {
        _ratingLable.text = @"暂无评分";
    }else{
        NSDictionary *dict = _model.rating;
        NSNumber *num = dict[@"average"];
        _ratingLable.text = [NSString stringWithFormat:@"%@",num];
    }
    NSArray *direcArr  = _model.directors;
    NSString *str = [NSString string];
    for (int i = 0; i < direcArr.count; i++) {
        if (i == 0) {
            str = [NSString stringWithFormat:@"导演:%@",direcArr[0][@"name"]];
        }else{
            str = [NSString stringWithFormat:@"%@/%@",str,direcArr[i][@"name"]];
        }
    }
    _directorLable.text = str;
    NSArray *actArr = _model.casts;
    NSString *actStr = @"";
    for (int i = 0; i < actArr.count; i ++ ) {
        if (i == 0) {
            actStr = [NSString stringWithFormat:@"演员:%@",actArr[0][@"name"]];
        }else{
            actStr = [NSString stringWithFormat:@"%@/%@",actStr,actArr[i][@"name"]];
        }
        
    }
    
    _actorLale.text = actStr;
    
}
- (IBAction)clickButton:(id)sender {
    NSLog(@"预留接口");
    
    
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"暂不支持" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil] show];
}
@end
