//
//  DetailFirstCell.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/5.
//  Copyright © 2016年 CL. All rights reserved.
//
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define Margin 20
#import "DetailFirstCell.h"
#import "PerIntrestViewController.h"
@interface DetailFirstCell ()
{
    UILabel *_titleLable;
    UILabel *_timeLable;
    UILabel *_inJoinLable;
    UIButton *_interestedBtn;
    
}
@end
@implementation DetailFirstCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DetailFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailFirstCell"];
    if (cell == nil) {
        cell = [[DetailFirstCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DetailFirstCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self builtUI];
    }
    
    return self;
}
- (void)builtUI{
    CGFloat lableX = Margin;
    CGFloat lableY = Margin;
    CGFloat lableW = SCREEN_W - 2 * Margin;
    CGFloat lableH = 60;
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(lableX, lableY, lableW, lableH)];
    
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.backgroundColor = [UIColor clearColor];
    _titleLable.font = [UIFont boldSystemFontOfSize:20.f];
    _titleLable.numberOfLines = 0;
    [self.contentView addSubview:_titleLable];
    
    _inJoinLable = [[UILabel alloc]initWithFrame:CGRectMake(Margin, CGRectGetMaxY(_titleLable.frame), lableW, 20)];
    _inJoinLable.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_inJoinLable];
    _interestedBtn = [[UIButton alloc]initWithFrame:CGRectMake(Margin, CGRectGetMaxY(_inJoinLable.frame) + Margin, lableW, 40)];

    _interestedBtn.layer.cornerRadius = 8;
    _interestedBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _interestedBtn.layer.borderWidth = 1;
    _interestedBtn.layer.masksToBounds = YES;
    [_interestedBtn setTitle:@"感兴趣" forState:UIControlStateNormal];
    [_interestedBtn setTitle:@"已感兴趣" forState:UIControlStateSelected];
    [_interestedBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_interestedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [_interestedBtn addTarget:self action:@selector(interestedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_interestedBtn];
   
    
}
- (void)interestedBtnAction:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _interestedBtn.layer.cornerRadius = 8;
        _interestedBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _interestedBtn.layer.borderWidth = 1;
        _interestedBtn.layer.masksToBounds = YES;
    }else{
        _interestedBtn.layer.cornerRadius = 8;
        _interestedBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _interestedBtn.layer.borderWidth = 1;
        _interestedBtn.layer.masksToBounds = YES;
    }

    if (_interestedBtn.selected) {
   
        NSDictionary *dict = @{@"ID":_model.ID,
                               @"alt":_model.alt,
                               @"title":_model.title
                               };
        
        NSArray *arrary = [[NSUserDefaults standardUserDefaults]objectForKey:@"CollectArraryM"];
        NSMutableArray *arraryM = [NSMutableArray arrayWithArray:arrary];
        NSInteger index = 0;
        for (NSDictionary *dic in arraryM) {

            if ([dict[@"ID"] isEqualToString:dic[@"ID"]]) {
                index = 1;
                return;
            }
        }
        if (index == 0) {
            [arraryM addObject:dict];
            [[NSUserDefaults  standardUserDefaults] setObject:arraryM forKey:@"CollectArraryM"];
        }
        
    }else{
         NSDictionary *dict = @{@"ID":_model.ID,
                                 @"alt":_model.alt,
                                 @"title":_model.title
                                 };
        NSArray *arrary = [[NSUserDefaults standardUserDefaults]objectForKey:@"CollectArrary"];
        NSMutableArray *arraryM = [NSMutableArray arrayWithArray:arrary];
        NSInteger index = 0;
        NSInteger tmp = 0;
        for (NSDictionary *dic in arraryM) {
            index ++;
            if ([dict[@"ID"] isEqualToString:dic[@"ID"]]) {
                
                tmp = index - 1;
            }
        }
        if (index ) {
            [arraryM removeObjectAtIndex:tmp];
            [[NSUserDefaults  standardUserDefaults] setObject:arraryM forKey:@"CollectArraryM"];
        }
        
       
    }
    
}
- (void)setModel:(LocationModel *)model{
    _model = model;
    _titleLable.text =_model.title;

    _inJoinLable.text = [NSString stringWithFormat:@"%@人感兴趣/%@人参加",_model.wisher_count,_model.participant_count];
  
}

+ (CGFloat)getCellHeightWithModel:(LocationModel *)model{
    
    CGFloat totalHeight = 2 * Margin + 60 + 30 + 40;
    return totalHeight;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
