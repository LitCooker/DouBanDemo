//
//  OutsideViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/29.
//  Copyright © 2016年 CL. All rights reserved.
//
#define TEXTFIELDH 64
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#import "OutsideViewController.h"
#import "LocalCityTool.h"
@interface OutsideViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_contentArrary;
    NSArray *_titleArrary;
}
@end

@implementation OutsideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.
    [self builtUI];
    //2.
    [self requestData];
}
- (void)requestData{
    

    [LocalCityTool getOverSeaCityInfo:^(NSDictionary *dict, NSArray *firstArray, NSArray *secondArray) {
        
        _titleArrary = firstArray;
        _contentArrary = secondArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_tableView reloadData];
        });
    }];
}

- (void)builtUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H -  2 * TEXTFIELDH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 40;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_contentArrary[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArrary.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutsideViewController"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OutsideViewController"];
    }
    NSDictionary *dict = _contentArrary[indexPath.section][indexPath.row];
    cell.textLabel.text = [dict allKeys][0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc]init];
    label.text = _titleArrary[section];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor lightGrayColor];
    return label;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = _contentArrary[indexPath.section][indexPath.row];
    NSString *locationID =  [dict allKeys][0];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCityVC" object:locationID];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
