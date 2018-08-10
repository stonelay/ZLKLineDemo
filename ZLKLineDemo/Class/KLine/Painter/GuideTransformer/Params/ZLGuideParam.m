//
//  ZLGuideParam.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideParam.h"

@implementation ZLGuideParam

- (instancetype)init {
    if (self = [super init]) {
        [self initDefault];
    }
    return self;
}

- (void)initDefault {}

+ (ZLGuideParam *)getDefaultParamByGuideID:(NSString *)guideID {
    NSString *className = [NSString stringWithFormat:@"ZL%@Param", guideID];
    Class guideParamClass = NSClassFromString(className);
    NSAssert(guideParamClass, @"Invalid guideParam Class.");
    return [[guideParamClass alloc] init];
}

@end
