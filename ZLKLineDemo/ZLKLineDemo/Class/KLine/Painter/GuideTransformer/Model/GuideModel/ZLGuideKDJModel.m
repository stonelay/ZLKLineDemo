//
//  ZLGuideKDJModel.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/2.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideKDJModel.h"

@implementation ZLGuideKDJModel

- (void)initDefault {
    [super initDefault];
    self.name = kGUIDE_ID_KDJ;
}

- (CGFloat)maxData {
    return MAX(self.kData, MAX(self.dData, self.jData));
}

- (CGFloat)minData {
    return MIN(self.kData, MIN(self.dData, self.jData));
}

@end
