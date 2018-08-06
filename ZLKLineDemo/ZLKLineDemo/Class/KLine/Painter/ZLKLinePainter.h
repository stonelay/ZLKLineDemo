//
//  ZLKLinePainter.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/17.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZLKLinePainter <NSObject>

@required
- (void)draw;
- (void)clear;

@optional
// tap
- (void)tapAtPoint:(CGPoint)point;

// pan
- (void)panBeganPoint:(CGPoint)point;
- (void)panChangedPoint:(CGPoint)point;
- (void)panEndedPoint:(CGPoint)point;

// pinch
- (void)pinchBeganScale:(CGFloat)scale;
- (void)pinchChangedScale:(CGFloat)scale;
- (void)pinchEndedScale:(CGFloat)scale;

// longPress
- (void)longPressBeganLocation:(CGPoint)location;
- (void)longPressChangedLocation:(CGPoint)location;
- (void)longPressEndedLocation:(CGPoint)location;

@end
