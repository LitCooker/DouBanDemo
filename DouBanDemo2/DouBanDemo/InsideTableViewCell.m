//
//  InsideTableViewCell.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/30.
//  Copyright © 2016年 CL. All rights reserved.
//

#define MAGIN 10;
#define HotBtnH 50;
#import "InsideTableViewCell.h"
#import "LocalStatuseManager.h"

@interface InsideTableViewCell ()

{
     UIButton *_locationBtn;
    
}
@property (nonatomic ,strong)NSString *cityName;
@end
@implementation InsideTableViewCell



+ (CGFloat)getCellHeight{
   
    return 70;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    InsideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"INSIDE"];
    if (!cell) {
        cell = [[InsideTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"INSIDE"];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self builtCell];
        //定位当前城市
      LocalStatuseManager *mangaer =  [LocalStatuseManager sharedOfLocation];
//        __weak InsideTableViewCell *weekSelf = self;
        [mangaer currentLocation:^(NSString * cityName) {
          
            
        }];
    
    
    }
    return self;
}
- (void)builtCell{
    //定位到的城市
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _locationBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _locationBtn.layer.borderWidth = 0.4;
    _locationBtn.layer.cornerRadius = 5;
    _locationBtn.backgroundColor = [UIColor whiteColor];
    [_locationBtn setTitle:@"定位中" forState:UIControlStateNormal];
    _locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [_locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_locationBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_locationBtn setImage:[UIImage imageNamed:@"AlbumLocationIconHL"] forState:UIControlStateNormal];
    [_locationBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_locationBtn];
    
}
- (void)clickButton:(UIButton *)sender{
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
