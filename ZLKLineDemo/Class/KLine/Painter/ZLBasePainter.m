//
//  ZLBasePainter.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/17.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLBasePainter.h"

@interface ZLBasePainter()

@property (nonatomic, assign) UIEdgeInsets screenEdgeInsets;
@property (nonatomic, weak) UIView *paintView;

@end

@implementation ZLBasePainter

- (instancetype)initWithPaintView:(UIView *)paintView {
    if (self = [super init]) {
        self.paintView = paintView;
        [self p_initDefault];
    }
    return self;
}

#pragma mark - ZLKLinePainter
- (void)draw {
    [self p_haveDataSource];
    [self p_haveDelegate];
    [self p_havePaintView];
    
    self.screenEdgeInsets = [self.delegate edgeInsetsInPainter:self];
}

- (void)clear {
    [self p_clear];
}

// pan
- (void)panBeganPoint:(CGPoint)point {}
- (void)panChangedPoint:(CGPoint)point {}
- (void)panEndedPoint:(CGPoint)point {}

// pinch
- (void)pinchBeganScale:(CGFloat)scale {}
- (void)pinchChangedScale:(CGFloat)scale {}
- (void)pinchEndedScale:(CGFloat)scale {}

// longPress
- (void)longPressBeganLocation:(CGPoint)location {}
- (void)longPressChangedLocation:(CGPoint)location {}
- (void)longPressEndedLocation:(CGPoint)location {}

#pragma mark - private
- (void)p_initDefault {
    // abstract 子类实现
}

- (void)p_clear {
    // abstract 子类实现
}

- (CGRect)s_bounds {
    [self p_havePaintView];
    return self.paintView.bounds;
}

- (CGRect)s_frame {
    [self p_havePaintView];
    return self.paintView.frame;
}


- (CGFloat)p_left {
    [self p_havePaintView];
    return self.screenEdgeInsets.left;
}

- (CGFloat)p_top {
    [self p_havePaintView];
    return self.screenEdgeInsets.top;
}

- (CGFloat)p_bottom {
    [self p_havePaintView];
    return self.paintView.height - self.screenEdgeInsets.bottom;
}

- (CGFloat)p_right {
    [self p_havePaintView];
    return self.paintView.width - self.screenEdgeInsets.right;
}

- (CGFloat)p_height {
    [self p_havePaintView];
    return self.paintView.height - self.screenEdgeInsets.top - self.screenEdgeInsets.bottom;
}

- (CGFloat)p_width {
    [self p_havePaintView];
    return self.paintView.width - self.screenEdgeInsets.left - self.screenEdgeInsets.right;
}

- (CGRect)p_frame {
    [self p_havePaintView];
    return CGRectMake(self.p_left, self.p_top, self.p_width, self.p_height);
}

- (CGRect)p_bounds {
    [self p_havePaintView];
    return CGRectMake(0, 0, self.p_width, self.p_height);
}

- (void)p_addSublayer:(CALayer *)sublayer {
    [self p_havePaintView];
    [self.paintView.layer addSublayer:sublayer];
}

- (void)p_havePaintView {
    NSAssert(self.paintView, @"Invalidate paintView is nil.");
}

- (void)p_haveDataSource {
    NSAssert(self.dataSource, @"Invalid dataSource is nil.");
}
- (void)p_haveDelegate {
    NSAssert(self.delegate, @"Invalid delegate is nil.");
}

#pragma mark - sys
- (void)dealloc {
    [self p_clear];
}

@end
