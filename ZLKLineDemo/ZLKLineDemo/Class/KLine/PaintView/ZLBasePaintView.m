//
//  ZLBasePaintView.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/26.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLBasePaintView.h"
#import "ZLBasePainter.h"

@interface ZLBasePaintView()

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture; //
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;       //
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;   //
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;//

@end

@implementation ZLBasePaintView

- (void)initDefault {
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self addGestureRecognizer:self.tapGesture];
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:self.panGesture];
    
    self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [self addGestureRecognizer:self.pinchGesture];
    
    self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [self addGestureRecognizer:self.longPressGesture];
}


#pragma mark - gesture
- (void)tapGesture:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:gesture.view];
    [self tapAtPoint:point];
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture translationInView:gesture.view];
    switch (gesture.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            break;
        case UIGestureRecognizerStateChanged: {
            [self panChangedPoint:point];
        }
            break;
        case UIGestureRecognizerStateBegan: {
            [self panBeganPoint:point];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            [self panEndedPoint:point];
        }
            break;
        default:
            break;
    }
}

- (void)pinchGesture:(UIPinchGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            break;
        case UIGestureRecognizerStateChanged: {
            [self pinchChangedScale:gesture.scale];
        }
            break;
        case UIGestureRecognizerStateBegan: {
            [self pinchBeganScale:gesture.scale];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            [self pinchEndedScale:gesture.scale];
        }
            break;
        default:
            break;
    }
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self];
    switch (gesture.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            break;
        case UIGestureRecognizerStateChanged: {
            [self longPressChangedLocation:point];
        }
            break;
        case UIGestureRecognizerStateBegan: {
            [self longPressBeganLocation:point];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            [self longPressEndedLocation:point];
        }
            break;
        default:
            break;
    }
}

#pragma mark - override
- (void)draw {}
- (void)clear {}

#pragma mark - control
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
}


@end
