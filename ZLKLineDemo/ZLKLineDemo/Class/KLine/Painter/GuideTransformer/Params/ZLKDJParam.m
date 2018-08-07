//
//  ZLKDJParam.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/2.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLKDJParam.h"

// kdj
#define KDJDefaultNPeriod 9.0
#define KDJDefaultM1Period 3.0
#define KDJDefaultM2Period 3.0

#define KDJDefaultKColor        ZLHEXCOLOR(0x800080)
#define KDJDefaultDColor        ZLHEXCOLOR(0x9932CC)
#define KDJDefaultJColor        ZLHEXCOLOR(0x98FB98)

@implementation ZLKDJParam

- (void)initDefault {
    [super initDefault];
    self.kdjPeriod_N = KDJDefaultNPeriod;
    self.kdjPeriod_M1 = KDJDefaultM1Period;
    self.kdjPeriod_M2 = KDJDefaultM2Period;
    self.kColor = KDJDefaultKColor;
    self.dColor = KDJDefaultDColor;
    self.jColor = KDJDefaultJColor;
}

@end
