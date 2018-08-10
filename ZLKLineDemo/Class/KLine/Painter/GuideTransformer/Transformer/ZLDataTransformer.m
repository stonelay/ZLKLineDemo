//
//  ZLDataTransformer.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLDataTransformer.h"

@implementation ZLDataTransformer

- (instancetype)init {
    if (self = [super init]) {
        [self initDefault];
    }
    return self;
}

- (void)initDefault {}

- (ZLGuideDataPack *)transToGuideData:(NSArray *)chartDataArray
                           guideParam:(ZLGuideParam *)guideParam {
    return nil;
}

+ (ZLDataTransformer *)getTransformerWithGuideID:(NSString *)guideID {
    NSString *className = [NSString stringWithFormat:@"ZL%@Transformer", guideID];
    Class transformerClass = NSClassFromString(className);
    NSAssert(transformerClass, @"Invalid transformerClass.");
    return [[transformerClass alloc] init];
}

@end
