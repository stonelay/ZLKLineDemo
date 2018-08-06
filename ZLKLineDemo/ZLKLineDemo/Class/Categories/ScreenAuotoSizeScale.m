//
//  ScreenAuotoSizeScale.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/18.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ScreenAuotoSizeScale.h"
//#import "IosLayoutDefine.h"

static ScreenAuotoSizeScale *instance = nil;

@implementation ScreenAuotoSizeScale

@synthesize autoSizeScaleX;
@synthesize autoSizeScaleY;

+ (id)getInstance{
    if (instance == nil) {
        instance = [[ScreenAuotoSizeScale alloc] init];
    }
    return instance;
}

- (id)init{
    if (self = [super init]) {
        if (SCREENHEIGHT > 480) {
            autoSizeScaleX = SCREENWIDTH / 320.0f;
            autoSizeScaleY = SCREENHEIGHT / 568.0f;
        } else {
            autoSizeScaleX = 1.0f;
            autoSizeScaleY = 1.0f;
        }
    }
    return self;
}

+ (CGRect)CGAutoMakeRect:(CGRect)rect{
    return CGAutoMakeRect(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

+ (CGSize)CGAutoMakeSize:(CGSize)size{
    return CGAutoMakeSize(size.width, size.height);
}

+ (CGFloat)CGAutoMakeFloat:(CGFloat)_float{
    return CGAutoMakeFloat(_float);
}

CG_INLINE CGFloat CGAutoMakeFloat(CGFloat _float){
    ScreenAuotoSizeScale *autoUtil = [ScreenAuotoSizeScale getInstance];
    return _float * autoUtil.autoSizeScaleX;
}

CG_INLINE CGSize CGAutoMakeSize(CGFloat width, CGFloat height){
    ScreenAuotoSizeScale *autoUtil = [ScreenAuotoSizeScale getInstance];
    CGSize size;
    size.width = width * autoUtil.autoSizeScaleX;
    size.height = height * autoUtil.autoSizeScaleY;
    return size;
}

CG_INLINE CGRect CGAutoMakeRect(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
    ScreenAuotoSizeScale *autoUtil = [ScreenAuotoSizeScale getInstance];
    CGRect rect;
    rect.origin.x = x * autoUtil.autoSizeScaleX;
    rect.origin.y = y * autoUtil.autoSizeScaleY;
    rect.size.width = width * autoUtil.autoSizeScaleX;
    rect.size.height = height * autoUtil.autoSizeScaleY;
    return rect;
}

+ (void)printRect:(CGRect)rect{
    NSLog(@"x : %f", rect.origin.x);
    NSLog(@"y : %f", rect.origin.y);
    NSLog(@"w : %f", rect.size.width);
    NSLog(@"h : %f", rect.size.height);
}

@end
