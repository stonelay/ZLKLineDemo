//
//  ZLKDJParam.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/2.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideParam.h"

@interface ZLKDJParam : ZLGuideParam

@property (nonatomic, assign) CGFloat kdjPeriod_N;  // kdj default n  9
@property (nonatomic, assign) CGFloat kdjPeriod_M1; // kdj default m1 3
@property (nonatomic, assign) CGFloat kdjPeriod_M2; // kdj default m2 3

@property (nonatomic, strong) UIColor *kColor;
@property (nonatomic, strong) UIColor *dColor;
@property (nonatomic, strong) UIColor *jColor;

@end
