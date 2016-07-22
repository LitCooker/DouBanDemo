//
//  HotCityCell.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/1.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "HotCityCell.h"

@implementation HotCityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"HotCityCell";
    HotCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
@end
