//
//  DetailSecondCell.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/5.
//  Copyright © 2016年 CL. All rights reserved.
//
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#import "DetailSecondCell.h"

@interface DetailSecondCell ()
{
    UIImageView *_iconImageView;
    UILabel *_titleLable;
    UILabel *_contentLable;
}
@end
@implementation DetailSecondCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DetailSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailSecondCell"];
    if (cell == nil) {
        cell = [[DetailSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DetailSecondCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = YES;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:@"DetailSecondCell"];
    if (self) {
        [self builtUI];
    }
    
    return self;
}
- (void)builtUI{
    CGFloat magin = 40;
    CGFloat tmp = 10;
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, tmp , magin - 20, magin - 20)];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_iconImageView];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + tmp, 0, 100, magin)];
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_titleLable];
    
    _contentLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLable.frame), 0, SCREEN_W - CGRectGetMaxX(_titleLable.frame) - magin, magin)];
    _contentLable.textColor = [UIColor lightGrayColor];
    
    _contentLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_contentLable];
}
- (void)setTitle:(NSString *)title{
    
    if ([title isEqualToString:@"即时讨论"]) {
        _iconImageView.image = [UIImage imageNamed:@"free-60-icons-50"];
        _titleLable.text = title;
        _contentLable.textAlignment = NSTextAlignmentRight;
        _contentLable.text = [NSString stringWithFormat:@"%@人",_model.wisher_count];
    
    }else{
        _iconImageView.image = [UIImage imageNamed:@"location_607px_1200654_easyicon.net"];
        _titleLable.text = title;
        _contentLable.textAlignment = NSTextAlignmentLeft ;
        _contentLable.text = _model.address;
        
    }
    
}
+ (CGFloat)getCellHeight{
    
    return 50;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
