//
//  ZLGridePainter.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/24.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLBasePainter.h"
#import "KLineModel.h"

typedef NS_OPTIONS(NSInteger, ZLGridePaintShowOp) {
    ZLGridePaintShowNone            = 0,
    ZLGridePaintShowLatitude        = 1 << 0,
    ZLGridePaintShowLatitudeTitle   = 1 << 1,
    ZLGridePaintShowLongitude       = 1 << 2,
    ZLGridePaintShowLongitudeTitle  = 1 << 3,
    
    ZLGridePaintShowAll             = 0xFF,
};

@interface ZLGridePainter : ZLBasePainter

@property (nonatomic, assign) ZLGridePaintShowOp paintOp;

- (void)addLongitudeWithPrice:(CGFloat)price positionY:(CGFloat)positionY;
- (void)addTrackingCrossLayerWithCrossPoint:(CGPoint)crossPoint edgeInsets:(UIEdgeInsets)edgeInsets;

- (void)drawLatitudeLines;
- (void)drawLongittueLines;
- (void)drawBorder;
- (void)drawTrackingCross;

@end
