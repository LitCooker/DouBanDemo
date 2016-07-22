//
//  CLIntroduceView.h
//  ChenLeiYouJi
//
//  Created by qianfeng on 16/6/23.
//  Copyright © 2016年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLIntroduceView : UIView

/**
 *  引导页
 *
 *  @param array 引导页图片名称的数组
 *  @param frame 当前引导页的大小
 *
 *  @return 返回一个引导页UIView对象
 */
- (instancetype) initWithImageNamesOfArray:(NSArray *)array frame:(CGRect )frame;

@end
