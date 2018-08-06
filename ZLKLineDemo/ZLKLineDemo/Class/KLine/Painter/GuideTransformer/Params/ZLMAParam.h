//
//  ZLMAParam.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideParam.h"

static NSString * const PKey_MADataID_MA1    = @"MA1";
static NSString * const PKey_MADataID_MA2    = @"MA2";
static NSString * const PKey_MADataID_MA3    = @"MA3";
static NSString * const PKey_MADataID_MA4    = @"MA4";
static NSString * const PKey_MADataID_MA5    = @"MA5";

typedef NS_ENUM(int, ZLMADataType) {
    ZLMADataTypeSMA       = 1,        //简单移动平均线
    ZLMADataTypeEMA       = 2,        //指数移动平均线
    ZLMADataTypeWMA       = 3,        //带权移动平均线
};

@interface ZLMAParam : ZLGuideParam

@property (nonatomic, assign) ZLMADataType maDataType;
@property (nonatomic, assign) CGFloat period; // MA的周期

@property (nonatomic, strong) UIColor *maColor;

@end
