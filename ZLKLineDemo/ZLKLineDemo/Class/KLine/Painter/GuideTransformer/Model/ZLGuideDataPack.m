//
//  ZLGuideDataPack.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideDataPack.h"

@implementation ZLGuideDataPack

- (instancetype)initWithParams:(ZLGuideParam *)param {
    if (self = [super init]) {
        self.param = param;
    }
    return self;
}

@end
