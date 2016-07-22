//
//  ActivityTypeView.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/1.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "ActivityTypeView.h"

@interface ActivityTypeView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataArray;
    NSArray *_nameArray;;
}
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation ActivityTypeView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initTableView:frame];
        
        
        _dataArray = [[NSArray alloc] initWithObjects:@"热门",@"音乐",@"戏剧",@"展览",@"讲座",@"聚会",@"运动",@"旅行",@"公益",@"电影", nil];
        _nameArray = [[NSArray alloc] initWithObjects:@"type-meet",@"type-polaroid-socialmatic",@"type-radio-4",@"type-sharpner",@"type-support",@"type-sunglasses",@"type-nike-dunk",@"type-snowman",@"power-plant",@"type-pan", nil];
        
        [_tableView reloadData];
    }
    return self;
}
-(void)initTableView:(CGRect)frame{
    _tableView                 = [[UITableView alloc] initWithFrame:frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 40;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Type"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Type"];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[_nameArray objectAtIndex:indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title = [_dataArray objectAtIndex:indexPath.row];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[@"all",@"music",@"drama",@"exhibition",@"salon",@"party", @"sports", @"travel", @"commonweal",@"film"] forKeys:@[@"热门",@"音乐",@"戏剧",@"展览",@"讲座",@"聚会",@"运动",@"旅行",@"公益",@"电影"] ];
    
    NSString *type = [dict objectForKey:title];
    
    [[NSUserDefaults standardUserDefaults] setObject:type forKey:@"ActivityTypeView"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ActivityTypeView" object:type];    
    
}

@end
