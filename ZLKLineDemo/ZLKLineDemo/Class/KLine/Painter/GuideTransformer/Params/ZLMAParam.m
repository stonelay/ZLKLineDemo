//
//  ZLMAParam.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLMAParam.h"

// ma
#define MA1DefaultPeriod 5.0
#define MA2DefaultPeriod 10.0
#define MA3DefaultPeriod 20.0
#define MA4DefaultPeriod 60.0
#define MA5DefaultPeriod 144.0

#define MA1DefaultColor         ZLHEXCOLOR(0xBA55D3)
#define MA2DefaultColor         ZLHEXCOLOR(0xF8F8FF)
#define MA3DefaultColor         ZLHEXCOLOR(0x00BFFF)
#define MA4DefaultColor         ZLHEXCOLOR(0x3CB371)
#define MA5DefaultColor         ZLHEXCOLOR(0xF0E68C)

@implementation ZLMAParam

+ (ZLMAParam *)initWithMADataKey:(NSString *)dataKey {
    ZLMAParam *param = [[ZLMAParam alloc] init];
    param.dataKey = dataKey;
    if ([dataKey isEqualToString:PKey_MADataID_MA1]) {
        param.maDataType = ZLMADataTypeSMA;
        param.period = MA1DefaultPeriod;
        param.maColor = MA1DefaultColor;
    } else if ([dataKey isEqualToString:PKey_MADataID_MA2]) {
        param.maDataType = ZLMADataTypeSMA;
        param.period = MA2DefaultPeriod;
        param.maColor = MA2DefaultColor;
    } else if ([dataKey isEqualToString:PKey_MADataID_MA3]) {
        param.maDataType = ZLMADataTypeSMA;
        param.period = MA3DefaultPeriod;
        param.maColor = MA3DefaultColor;
    } else if ([dataKey isEqualToString:PKey_MADataID_MA4]) {
        param.maDataType = ZLMADataTypeSMA;
        param.period = MA4DefaultPeriod;
        param.maColor = MA4DefaultColor;
    } else if ([dataKey isEqualToString:PKey_MADataID_MA5]) {
        param.maDataType = ZLMADataTypeSMA;
        param.period = MA5DefaultPeriod;
        param.maColor = MA5DefaultColor;
    }
    return param;
}

@end
