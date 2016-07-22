//
//  DetailContentCell.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/5.
//  Copyright © 2016年 CL. All rights reserved.
//
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#import "DetailContentCell.h"

@interface DetailContentCell ()
{
    UILabel *_titleLable;
    UILabel *_contentLable;
}
@end
@implementation DetailContentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width - 5, 30)];
        _titleLable.text = @"简介:";
        _titleLable.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_titleLable];
        _contentLable = [[UILabel alloc]init];
        _contentLable.numberOfLines = 0;
//        _contentLable.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:_contentLable];
    }
    return self;
}
- (void)setModel:(LocationModel *)model{
    _contentLable.text = model.content;
    _model = model;
    CGFloat lableW = [UIScreen mainScreen].bounds.size.width - 10;
    CGFloat lableX = 5;
    CGFloat lableY = CGRectGetMaxY(_titleLable.frame);
    CGRect rect = [_model.content boundingRectWithSize:CGSizeMake(lableW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    CGFloat lableH = rect.size.height;
    _contentLable.frame = CGRectMake(lableX, lableY, lableW, lableH);
    
       
}

+ (CGFloat)getCellHeight:(LocationModel *)model{
    
   
    CGRect rect = [model.content boundingRectWithSize:CGSizeMake(SCREEN_W, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    return 60 + rect.size.height;
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
