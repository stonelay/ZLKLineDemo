//
//  ZLGuideModel.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideModel.h"

@interface ZLGuideModel()

@end

@implementation ZLGuideModel

- (instancetype)init {
    if (self = [super init]) {
        [self initDefault];
    }
    return self;
}

- (void)initDefault {
    self.isNeedDraw = YES;
}

@end
