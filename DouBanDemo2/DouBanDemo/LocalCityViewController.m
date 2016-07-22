  //
//  LocalCityViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/6/27.
//  Copyright © 2016年 CL. All rights reserved.
//
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#define LocaBtnH  50
#define valueDict [[NSDictionary alloc] initWithObjects:@[@"热门",@"音乐",@"戏剧",@"展览",@"讲座",@"聚会",@"运动",@"旅行",@"公益",@"电影"] forKeys:@[@"all",@"music",@"drama",@"exhibition",@"salon",@"party", @"sports", @"travel", @"commonweal",@"film"] ]
#define KeyDict [[NSDictionary alloc] initWithObjects:@[@"all",@"music",@"drama",@"exhibition",@"salon",@"party", @"sports", @"travel", @"commonweal",@"film"] forKeys:@[@"热门",@"音乐",@"戏剧",@"展览",@"讲座",@"聚会",@"运动",@"旅行",@"公益",@"电影"] ]

#import "LocalCityViewController.h"
#import "SelectCityViewController.h"
#import "AppDelegate.h"
#import "DXPopover/DXPopover.h"
#import "ActivityTypeView.h"
#import "LocalCityTool.h"
#import "RequestDataManager.h"
#import "LocalTableViewCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "LocationModel.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "LocationPushViewController.h"
//http://api.douban.com/v2/event/list?start=1&loc=nanjing&count=10&type=travel 
@interface LocalCityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_titleBtn;
    //类型
    NSString *_typeName;
    //
    NSString *_typeId;
    //ID
    NSString *_loactionID;
    
    NSString *_locationName;
    
    UIButton *_localIDBtn;
    
    NSInteger _page;
    
    UIButton *_topButton;
}
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray * tableArrary;
@property (nonatomic, strong) DXPopover *popover;
@end

@implementation LocalCityViewController
- (void)viewWillAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController.navigationBar setTranslucent:NO];
    _tableArrary = [NSMutableArray array];
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    _page = 1;
    //0.
    [self requestData];
    
    //1.
    [self builtUI];
    
    //2
    [self builtNavigationBar];
    
    //3.
    [self addBtnToNavc];
    
    //4
    [self addTopButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(typeButtonClick:) name:@"ActivityTypeView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LocalIDClick:) name:@"SelectCityVC" object:nil];
}
#pragma mark - 添加置顶按钮
- (void)addTopButton{
    CGFloat buttonW = 70.f;
    CGFloat buttonH = 40;
    CGFloat buttonX = SCR_W - buttonW;
    CGFloat buttonY = SCR_H - buttonH - 64 - LocaBtnH;
   
    _topButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
    [_topButton setImage:[UIImage imageNamed:@"回顶部"] forState:UIControlStateNormal];
    [_topButton addTarget:self action:@selector(cliclTopButton:) forControlEvents:UIControlEventTouchUpInside];
    _topButton.hidden = YES;
    [self.view addSubview:_topButton];
}
#pragma mark - 置顶按钮点击方法
- (void)cliclTopButton:(UIButton *)sender{
    if (_tableArrary.count == 0) {
        return;
    }
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
#pragma mark - 选择城市通知监听
- (void)LocalIDClick:(NSNotification *)sender{
    

    _locationName = sender.object;
    [_localIDBtn setTitle:[NSString stringWithFormat:@"当前城市:%@",_locationName ] forState:UIControlStateNormal];
    _loactionID =  [LocalCityTool getCityIDByName:_locationName];
    _titleBtn.selected = NO;
    [[NSUserDefaults standardUserDefaults]setObject:_locationName forKey:@"_locationName"];
    _page = 1;
    [_tableArrary removeAllObjects];
    [self requestData];
}

#pragma  mark - 选择类型通知监听
- (void)typeButtonClick:(NSNotification *)sender{
    [self.popover dismiss];
    _typeId = sender.object;
    _typeName  = valueDict[_typeId];
    [[NSUserDefaults standardUserDefaults] setObject:_typeName forKey:@"_typeName"];
    [_titleBtn setTitle:_typeName forState:UIControlStateNormal];
    _page = 1;
    [_tableArrary removeAllObjects];
    [self requestData];
}
#pragma  mark -搭建导航栏view
- (void)builtNavigationBar{
//    self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
    _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleBtn setTitle:_typeName forState:UIControlStateNormal];
    [_titleBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [_titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    [_titleBtn setImage:[UIImage imageNamed:@"arrow_net"] forState:UIControlStateNormal];
//    
//    [_titleBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateSelected];
    
    [_titleBtn addTarget:self action:@selector(titleShowPopover:) forControlEvents:UIControlEventTouchUpInside];
    _titleBtn.frame = CGRectMake(0, 0, 80, 40);

    self.navigationItem.titleView = _titleBtn;
}
#pragma mark － 
- (void)titleShowPopover:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.popover = [DXPopover new];
    self.popover.maskType = DXPopoverMaskTypeNone;
    self.popover.backgroundColor= [UIColor clearColor];
    ActivityTypeView *typeView = [[ActivityTypeView alloc] initWithFrame:CGRectMake(0, 0, 160, 300)];
//    typeView.backgroundColor = [UIColor lightGrayColor];
    
    UIView *titleView = self.navigationItem.titleView;
    CGPoint startPoint =
    CGPointMake(CGRectGetMidX(titleView.frame), CGRectGetMaxY(titleView.frame) + 20);

    [self.popover showAtPoint:startPoint
               popoverPostion:DXPopoverPositionDown
              withContentView:typeView
                       inView:self.tabBarController.view];
    __weak typeof(self) weakSelf = self;
    self.popover.didDismissHandler = ^{
        
        [weakSelf bounceTargetView:titleView];
    };

}
- (void)bounceTargetView:(UIView *)targetView {
    targetView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:0.3
                          delay:0.0
         usingSpringWithDamping:0.2
          initialSpringVelocity:5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         targetView.transform = CGAffineTransformIdentity;
                     }
                     completion:nil];
}

- (void)addBtnToNavc{
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [button setTitle:@"友情链接" forState:UIControlStateNormal];
    [button setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];

}
- (void)clickButton{
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *dele = (AppDelegate*)app.delegate;
       
    if ([dele.leftSliderVC closed]) {
        [dele.leftSliderVC openLeftView];
        
    }else{
        [dele.leftSliderVC closed];
    }
}

#pragma  mark - 请求数据
- (void)requestData{
   
    [SVProgressHUD show];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *str = [defaults objectForKey:@"FirstLoad"];

    if (!str) {//1.判断是否为第一次登陆
        
        [defaults setObject:@"FirstLoad" forKey:@"FirstLoad"];
         _locationName = @"北京";
        _typeName = @"热门";
        [defaults setObject:_locationName forKey:@"_locationName"];
        [defaults setObject:_typeName forKey:@"_typeName"];
        _typeId = KeyDict[_typeName];
        _loactionID = _loactionID =  [LocalCityTool getCityIDByName: _locationName];
    }else{
        _locationName = [defaults objectForKey:@"_locationName"];
        _typeName = [defaults objectForKey:@"_typeName"];
        
        _loactionID =  [LocalCityTool getCityIDByName: _locationName];
        _typeId = KeyDict[_typeName];
       
    }
    [RequestDataManager getDataWithStartPage:_page locationId:_loactionID typeId:_typeId completion:^(NSArray *arrary) {
        if (arrary.count == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                //1.
                UIAlertAction *alertActionOne = [UIAlertAction actionWithTitle:@"无更多数据" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertSheet addAction:alertActionOne];
                //2.
                UIAlertAction *alertActionTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertSheet addAction:alertActionTwo];
                
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                //completion  结束后需要执行的代码
                [delegate.window.rootViewController presentViewController:alertSheet animated:YES completion:nil];
                [SVProgressHUD dismiss];
                return ;

            });
           
           
        }
        
        if (_page == 1) {
            [_tableArrary removeAllObjects];
            [_tableArrary addObjectsFromArray:arrary];
        }else{
            [_tableArrary addObjectsFromArray:arrary];
        }
            dispatch_async(dispatch_get_main_queue(), ^{
          
            [_tableView.mj_footer endRefreshing];
            [_tableView.mj_header endRefreshing];
            [_tableView reloadData];
             [SVProgressHUD dismiss];
        });
        
    } error:^(NSError *errror) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
         [SVProgressHUD dismiss];
    }];

}
#pragma  mark - 搭建UI
- (void)builtUI{
    _localIDBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCR_W , LocaBtnH)];
    [_localIDBtn setTitle:[NSString stringWithFormat:@"当前城市:%@",_locationName ] forState:UIControlStateNormal];
    [_localIDBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _localIDBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    [_localIDBtn addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 44) style:UITableViewStylePlain];
    _tableView.tableHeaderView = _localIDBtn;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 200;

    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self requestData];
    }];
    
    //上拉加载
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        _page ++;
        [self requestData];
    }];

}
- (void)selectCity:(UIButton *)sender{
    SelectCityViewController *selectVc = [[SelectCityViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:selectVc animated:YES];
}
#pragma  mark - 组数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableArrary.count;
}
#pragma  mark - 定义Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LocalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Local"];
    if (cell == nil) {
       cell = [[NSBundle mainBundle]loadNibNamed:@"LocalTableViewCell" owner:nil options:nil][0];
    }
    LocationModel * model = _tableArrary[indexPath.row];
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
    //  切圆角
    cell.iconImageView.layer.cornerRadius = 10;
    //
    cell.iconImageView.layer.masksToBounds = YES;
    NSRange beginRange = NSMakeRange (0, 10);
    NSString *beginTime = [model.begin_time substringWithRange:beginRange];
    NSRange endRange = NSMakeRange (0, 10);
    NSString *endTime = [model.end_time substringWithRange:endRange];
    cell.timeLable.text = [NSString stringWithFormat:@"时间：%@ ~ %@",beginTime,endTime];

    cell.typeLable.text = model.category_name;
    cell.titleLable.text = model.title;
    NSString *finallyString = [model.address stringByReplacingOccurrencesOfString:model.loc_name withString:@""];
    NSString *addressString = [NSString stringWithFormat:@"地点:%@",finallyString];
    cell.locationLable.text = [NSString stringWithFormat:@"%@",addressString];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    
    if (tableView.contentOffset.y > SCR_H) {
        _topButton.hidden = NO;
        
    }else{
        _topButton.hidden = YES;
    }
    return cell;

}
//选择某个位置
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LocationPushViewController *pushVc = [[LocationPushViewController alloc]init];
    
    pushVc.model = _tableArrary[indexPath.row];
    [self.navigationController pushViewController:pushVc animated:YES];
    
}
#pragma mark - 销毁通知
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
