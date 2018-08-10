//
//  ZLBOLLParam.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLBOLLParam.h"

// boll
#define BOLLDefaultPeriod 20.0
#define BOLLDefaultK 2.0

#define BOLLDefaultUpColor      ZLHEXCOLOR(0x800080)
#define BOLLDefaultMidColor     ZLHEXCOLOR(0x8A2BE2)
#define BOLLDefaultLowColor     ZLHEXCOLOR(0x98FB98)
#define BOLLDefaultBandColor    ZLHEXCOLOR_a(0xCD5C5C, 0.1)

@implementation ZLBOLLParam

- (void)initDefault {
    [super initDefault];
    
    self.period = BOLLDefaultPeriod; // default
    self.k = BOLLDefaultK;
    self.upColor = BOLLDefaultUpColor;
    self.midColor = BOLLDefaultMidColor;
    self.lowColor = BOLLDefaultLowColor;
    self.bandColor = BOLLDefaultBandColor;
}

@end
