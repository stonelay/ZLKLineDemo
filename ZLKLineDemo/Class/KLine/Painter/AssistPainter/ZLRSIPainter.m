//
//  ZLRSIPainter.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/6.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLRSIPainter.h"

#import "ZLRSIParam.h"
#import "ZLGuideRSIModel.h"

#define RSITitleFontSize 12

@interface ZLRSIPainter()

@property (nonatomic, strong) CAShapeLayer *rsiLayer;
@property (nonatomic, strong) CAShapeLayer *rsiInforLayer;
@property (nonatomic, strong) CAShapeLayer *trackingCrosslayer;

@property (nonatomic, strong) CATextLayer *rsiSublayer;
@property (nonatomic, strong) CATextLayer *longSublayer;
@property (nonatomic, strong) CATextLayer *shortSublayer;

@end

@implementation ZLRSIPainter

- (void)p_initDefault {
    [super p_initDefault];
}

#pragma mark - override
- (void)draw {
    [super draw];
    [self drawRSI];
    [self drawRSIInfor];
}

// tap
- (void)tapAtPoint:(CGPoint)point {}

// pan
- (void)panBeganPoint:(CGPoint)point {}
- (void)panChangedPoint:(CGPoint)point {
    [self drawRSI];
    [self drawRSIInfor];
}
- (void)panEndedPoint:(CGPoint)point {}

// pinch
- (void)pinchBeganScale:(CGFloat)scale {}
- (void)pinchChangedScale:(CGFloat)scale {
    [self drawRSI];
    [self drawRSIInfor];
}
- (void)pinchEndedScale:(CGFloat)scale {}

// longPress
- (void)longPressBeganLocation:(CGPoint)location {
    [self drawRSIInfor];
}
- (void)longPressChangedLocation:(CGPoint)location {
    [self drawRSIInfor];
}
- (void)longPressEndedLocation:(CGPoint)location {
    [self drawRSIInfor];
}

#pragma mark - draw
- (void)drawRSI {
    [self releaseRSILayer];
    [self p_addSublayer:self.rsiLayer];
    
    ZLGuideDataPack *dataPack = [self.dataSource rsiDataPackInPainter:self];
    if (!dataPack) {
        return;
    }
    [self.rsiLayer addSublayer:[self getRSIByDataPack:dataPack]];
}

- (void)drawRSIInfor {
    [self releaseRSIInforLayer];
    [self p_addSublayer:self.rsiInforLayer];
    
    ZLGuideDataPack *dataPack = [self.dataSource rsiDataPackInPainter:self];
    if (!dataPack) {
        return;
    }
    
    NSInteger crossIndex = [self.dataSource longPressIndexInPainter:self];
    ZLGuideRSIModel *guideModel = [dataPack.dataArray objectAtIndex:crossIndex];
    
    ZLRSIParam *rsiParam = (ZLRSIParam *)dataPack.param;
    NSString *rsiTitle = [NSString stringWithFormat:@"RSI(%d, %d)",(int)rsiParam.shortPeriod, (int)rsiParam.longPeriod];
    NSString *shortTitle = [NSString stringWithFormat:@"RSI1:%.2f", guideModel.shortData];
    NSString *longTitle = [NSString stringWithFormat:@"RSI2:%.2f", guideModel.longData];
    
    CGSize rsiSize = [rsiTitle sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(RSITitleFontSize)}];
    self.rsiSublayer.string = rsiTitle;
    self.rsiSublayer.foregroundColor = rsiParam.longColor.CGColor;
    self.rsiSublayer.frame = CGRectMake(2, 1 - self.p_top, rsiSize.width, rsiSize.height);
    
    CGSize shortSize = [shortTitle sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(RSITitleFontSize)}];
    self.shortSublayer.string = shortTitle;
    self.shortSublayer.foregroundColor = rsiParam.shortColor.CGColor;
    self.shortSublayer.frame = CGRectMake(self.rsiSublayer.right + 10, 1 - self.p_top, shortSize.width, shortSize.height);
    
    CGSize longSize = [longTitle sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(RSITitleFontSize)}];
    self.longSublayer.string = longTitle;
    self.longSublayer.foregroundColor = rsiParam.longColor.CGColor;
    self.longSublayer.frame = CGRectMake(self.shortSublayer.right + 10, 1 - self.p_top, longSize.width, longSize.height);
    
    [self.rsiInforLayer addSublayer:self.rsiSublayer];
    [self.rsiInforLayer addSublayer:self.longSublayer];
    [self.rsiInforLayer addSublayer:self.shortSublayer];
}

#pragma mark - release
- (void)releaseRSILayer {
    if (_rsiLayer) {
        [_rsiLayer removeFromSuperlayer];
        _rsiLayer = nil;
    }
}

- (void)releaseRSIInforLayer {
    if (_rsiInforLayer) {
        [_rsiInforLayer removeFromSuperlayer];
        _rsiInforLayer = nil;
    }
}

#pragma mark - property
- (CAShapeLayer *)rsiLayer {
    if (!_rsiLayer) {
        _rsiLayer = [CAShapeLayer layer];
        _rsiLayer.frame = self.p_frame;
        _rsiLayer.fillColor = ZLClearColor.CGColor;
        _rsiLayer.lineWidth = LINEWIDTH;
    }
    return _rsiLayer;
}

- (CAShapeLayer *)rsiInforLayer {
    if (!_rsiInforLayer) {
        _rsiInforLayer = [CAShapeLayer layer];
        _rsiInforLayer.frame = self.p_frame;
        _rsiInforLayer.fillColor = ZLClearColor.CGColor;
        _rsiInforLayer.lineWidth = LINEWIDTH;
    }
    return _rsiInforLayer;
}

- (CATextLayer *)longSublayer {
    if (!_longSublayer) {
        _longSublayer = [CATextLayer layer];
        _longSublayer.contentsScale = [UIScreen mainScreen].scale;
        _longSublayer.fontSize = RSITitleFontSize;
        _longSublayer.alignmentMode = kCAAlignmentJustified;
    }
    return _longSublayer;
}

- (CATextLayer *)shortSublayer {
    if (!_shortSublayer) {
        _shortSublayer = [CATextLayer layer];
        _shortSublayer.contentsScale = [UIScreen mainScreen].scale;
        _shortSublayer.fontSize = RSITitleFontSize;
        _shortSublayer.alignmentMode = kCAAlignmentJustified;
    }
    return _shortSublayer;
}

- (CATextLayer *)rsiSublayer {
    if (!_rsiSublayer) {
        _rsiSublayer = [CATextLayer layer];
        _rsiSublayer.contentsScale = [UIScreen mainScreen].scale;
        _rsiSublayer.fontSize = RSITitleFontSize;
        _rsiSublayer.alignmentMode = kCAAlignmentJustified;
    }
    return _rsiSublayer;
}

- (CAShapeLayer *)getRSIByDataPack:(ZLGuideDataPack *)dataPack {
    CGFloat aHigherValue = [self.delegate aHigherValueInPainter:self];
    //    CGFloat unitValue = [self.delegate unitValueInPainter:self];
    CGFloat unitValue = [self.delegate painter:self aunitByDValue:self.p_height];
    CGFloat cellWidth = [self.delegate cellWidthInPainter:self];
    CGFloat firstCandleX = [self.dataSource firstCandleXInPainter:self];
    
    NSArray *guideArray = dataPack.dataArray;
    ZLRSIParam *rsiParams = (ZLRSIParam *)dataPack.param;
    
    UIBezierPath *shortPath = [UIBezierPath bezierPath];
    shortPath.lineWidth = LINEWIDTH;
    shortPath.lineCapStyle = kCGLineCapRound;
    shortPath.lineJoinStyle = kCGLineCapRound;
    UIBezierPath *longPath = [UIBezierPath bezierPath];
    longPath.lineWidth = LINEWIDTH;
    longPath.lineCapStyle = kCGLineCapRound;
    longPath.lineJoinStyle = kCGLineCapRound;
    
    CAShapeLayer *shortLayer = [CAShapeLayer layer];
    shortLayer.frame = self.p_bounds;
    shortLayer.fillColor = ZLClearColor.CGColor;
    shortLayer.strokeColor = rsiParams.shortColor.CGColor;
    
    CAShapeLayer *longLayer = [CAShapeLayer layer];
    longLayer.frame = self.p_bounds;
    longLayer.fillColor = ZLClearColor.CGColor;
    longLayer.strokeColor = rsiParams.longColor.CGColor;
    
    BOOL isHead = YES;
    for (int i = 0; i < guideArray.count; i++) {
        ZLGuideRSIModel *model = guideArray[i];
        if (!model.isNeedDraw) continue;
        
        CGFloat leftX = firstCandleX + cellWidth * i;
        leftX += candleLeftAdge(cellWidth);
        leftX += candleWidth(cellWidth) / 2;
        
        CGFloat sY = (aHigherValue - model.shortData) / unitValue;
        CGFloat lY = (aHigherValue - model.longData) / unitValue;
        if (isHead) {
            [shortPath moveToPoint:CGPointMake(leftX, sY)];
            [longPath moveToPoint:CGPointMake(leftX, lY)];
            isHead = NO;
        } else {
            [shortPath addLineToPoint:CGPointMake(leftX, sY)];
            [longPath addLineToPoint:CGPointMake(leftX, lY)];
        }
    }
    
    CAShapeLayer *rsiLayer = [CAShapeLayer layer];
    rsiLayer.frame = self.p_bounds;
    
    shortLayer.path = shortPath.CGPath;
    [shortPath removeAllPoints];
    [rsiLayer addSublayer:shortLayer];
    
    longLayer.path = longPath.CGPath;
    [longPath removeAllPoints];
    [rsiLayer addSublayer:longLayer];
    
    return rsiLayer;
}

- (void)p_clear {
    [self releaseRSILayer];
    [self releaseRSIInforLayer];
}

@end
