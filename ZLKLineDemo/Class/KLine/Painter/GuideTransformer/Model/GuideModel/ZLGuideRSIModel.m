//
//  ZLGuideRSIModel.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/6.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideRSIModel.h"

@implementation ZLGuideRSIModel

- (void)initDefault {
    [super initDefault];
    self.name = kGUIDE_ID_RSI;
}

- (CGFloat)maxData {
    return MAX(self.longData, self.shortData);
}

- (CGFloat)minData {
    return MIN(self.longData, self.shortData);
}

@end
