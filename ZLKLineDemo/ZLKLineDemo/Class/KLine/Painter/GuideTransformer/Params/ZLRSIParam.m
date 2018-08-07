//
//  ZLRSIParam.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/6.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLRSIParam.h"

// rsi
#define RSIDefaultLPeriod 14.0
#define RSIDefaultSPeriod 7.0

#define RSIDefaultLColor        ZLHEXCOLOR(0x98FB98)
#define RSIDefaultSColor        ZLHEXCOLOR(0x800080)

@implementation ZLRSIParam

- (void)initDefault {
    [super initDefault];
    self.longPeriod = RSIDefaultLPeriod;
    self.shortPeriod = RSIDefaultSPeriod;
    self.longColor = RSIDefaultLColor;
    self.shortColor = RSIDefaultSColor;
}

@end
