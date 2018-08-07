//
//  ZLGuideMAModel.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/2.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideMAModel.h"

@implementation ZLGuideMAModel

- (void)initDefault {
    [super initDefault];
    self.name = kGUIDE_ID_MA;
}

- (CGFloat)minData {
    return self.data;
}

- (CGFloat)maxData {
    return self.data;
}

@end
