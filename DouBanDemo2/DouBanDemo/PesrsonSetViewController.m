//
//  PesrsonSetViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/9.
//  Copyright © 2016年 CL. All rights reserved.
//个人信息设置

#import "PesrsonSetViewController.h"
#import "FirstDetailTableViewCell.h"
#import "PersonSetDetailViewController.h"
#import "PersonIconViewController.h"
@interface PesrsonSetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    
    NSMutableArray  *_dataArrary;
    
    NSString * _contentStr;
    
    NSArray *_titleArrary;
    
    UIImage *_iconIamge;
}
@end

@implementation PesrsonSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    _iconIamge = self.image;
    _contentStr = @"请设置";
    _dataArrary = [NSMutableArray arrayWithArray: @[@"请设置",@"请设置",@"请设置",@"请设置",@"请设置"]];
    _titleArrary = @[@"名字",@"昵称",@"公司",@"学校",@"简介"];
    //1.设置个人信息
    [self builtUI];


}
- (void)builtUI{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return _dataArrary.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FirstDetailTableViewCell *cell = [[NSBundle  mainBundle]loadNibNamed:@"FirstDetailTableViewCell" owner:nil options:nil][0];
        cell.iconImageView.image = _iconIamge;
        cell.iconImageView.layer.borderWidth = 1;
        cell.iconImageView.layer.cornerRadius = 4;
        cell.iconImageView.layer.masksToBounds = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PesrsonSetViewController"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PesrsonSetViewController"];
    }
   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _titleArrary[indexPath.row];
    cell.detailTextLabel.text = _dataArrary [indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 80;
    }else{
        
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        PersonSetDetailViewController *person = [[PersonSetDetailViewController alloc]init];
        person.contenstr = _dataArrary[indexPath.row];
        person.block = ^(NSString *contentInfo){
            
            _contentStr = contentInfo;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
                [_dataArrary replaceObjectAtIndex:indexPath.row withObject:_contentStr ];
            });
        };
        [self.navigationController pushViewController:person animated:YES];
    }
    
    
    if (indexPath.section == 0) {
        PersonIconViewController *personIcon = [[PersonIconViewController alloc]init];
        personIcon.image = _iconIamge;
        personIcon.picBlock = ^(UIImage *image){
            
            _iconIamge = image;
            self.returnPicBlock (image);
            dispatch_async(dispatch_get_main_queue(), ^{
                 [_tableView reloadData];
            });
           
        
        };
        [self.navigationController pushViewController:personIcon animated:YES];
    }
}
@end
