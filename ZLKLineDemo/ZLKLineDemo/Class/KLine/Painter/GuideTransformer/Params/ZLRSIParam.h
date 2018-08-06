//
//  ZLRSIParam.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/6.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideParam.h"

@interface ZLRSIParam : ZLGuideParam

@property (nonatomic, assign) CGFloat longPeriod;
@property (nonatomic, assign) CGFloat shortPeriod;

@property (nonatomic, strong) UIColor *longColor;
@property (nonatomic, strong) UIColor *shortColor;

@end
