//
//  LocationModel.h
//  DouBanDemo
//
//  Created by qianfeng on 16/7/3.
//  Copyright © 2016年 CL. All rights reserved.
//

#import "JSONModel.h"
#import "ActivityOwnerModel.h"

@interface LocationModel : JSONModel

/** 活动类型 */
//@property (nonatomic ,strong) NSString *subcategory_name;
/** 活动开始时间 */
@property (nonatomic ,strong) NSString *begin_time;
/** 活动图片URL */
@property (nonatomic ,strong) NSString *image;
/** 活动URL */
@property (nonatomic ,strong) NSString *adapt_url;
/** 活动创建者 */
@property (nonatomic ,strong) ActivityOwnerModel<ActivityOwnerModelDelegate> *owner;
/** 活动所属城市名字 */
@property (nonatomic ,strong) NSString *loc_name;
/** alt */
@property (nonatomic ,strong) NSString *alt;
/** 活动ID */
@property (nonatomic ,strong) NSString *ID;
/** category */
@property (nonatomic ,strong) NSString *category;
/** 标题 */
@property (nonatomic ,strong) NSString *title;
/** 喜欢数 */
@property (nonatomic ,strong) NSString *wisher_count;
/** 是否售罄 */
@property (nonatomic ,assign) BOOL has_ticket;
/** 内容 */
@property (nonatomic ,strong) NSString *content;
/** 是否可邀请 */
@property (nonatomic ,strong) NSString *can_invite;
/**  */
@property (nonatomic ,strong) NSString *album;
/** 参与者数量 */
@property (nonatomic ,strong) NSString *participant_count;
/** 活动大图 */
@property (nonatomic ,strong) NSString *image_hlarge;
/** 活动地址 */
@property (nonatomic ,strong) NSString *address;
/** 地理坐标 */
@property (nonatomic ,strong) NSString *geo;
/** 作者截图 */
@property (nonatomic ,strong) NSString *image_lmobile;
/** 扩展名 */
@property (nonatomic ,strong) NSString *category_name;
/** 所属城市ID */
@property (nonatomic ,strong) NSString *loc_id;
/** 结束时间 */
@property (nonatomic ,strong) NSString *end_time;

/** tags*/
@property (nonatomic ,strong)NSString *tags;

/** pcei*/
@property (nonatomic ,strong)NSString *price_range;
@end
