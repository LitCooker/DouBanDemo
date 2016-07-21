//
//  ActivityOwnerModel.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/3.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "JSONModel.h"

@protocol ActivityOwnerModelDelegate <NSObject>



@end
@interface ActivityOwnerModel : JSONModel
//"name": "69cafe",
@property (nonatomic ,strong) NSString *name;
//"avatar": "http://img3.douban.com/view/site/small/public/42be2171e564590.jpg",
@property (nonatomic ,strong) NSString *avatar;
//"uid": "152181",
@property (nonatomic ,strong) NSString *uid;
//"alt": "https://site.douban.com/152181/",
@property (nonatomic ,strong) NSString *alt;
//"type": "site",
@property (nonatomic ,strong) NSString *type;
//"id": "152181",
@property (nonatomic ,strong) NSString *ID;
//"large_avatar": "http://img3.douban.com/f/
@property (nonatomic ,strong) NSString *large_avatar;



@end
