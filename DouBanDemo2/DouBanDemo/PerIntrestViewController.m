//
//  PerIntrestViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/11.
//  Copyright © 2016年 CL. All rights reserved.
//我的收藏和多行删除


#import "PerIntrestViewController.h"
#import "LeftPushViewController.h"
@interface PerIntrestViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArraryM;
    
    UITableView *_tableView;
    
}
@end

@implementation PerIntrestViewController
- (instancetype)init{
    if (self = [super init]) {
        
        NSArray *arrary = [[NSUserDefaults standardUserDefaults]objectForKey:@"CollectArraryM"];
      
        _dataArraryM = [NSMutableArray arrayWithArray:arrary];
       
       
    }
    
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
   
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self builtUI];
    
}
- (void)builtUI{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArraryM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"PerIntrestViewController"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PerIntrestViewController"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _dataArraryM[indexPath.row][@"title"];
    cell.textLabel.numberOfLines = 0;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *path = _dataArraryM[indexPath.row][@"alt"];
    LeftPushViewController *leftPush = [[LeftPushViewController alloc]init];
    
    
    leftPush.urlString = path;
    [self.navigationController pushViewController:leftPush animated:YES];
    
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    [_tableView setEditing:editing animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete ) {
        
        [_dataArraryM removeObjectAtIndex:indexPath.row];
        
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [[NSUserDefaults standardUserDefaults]setObject:_dataArraryM forKey:@"CollectArraryM"];
    }
}
@end
