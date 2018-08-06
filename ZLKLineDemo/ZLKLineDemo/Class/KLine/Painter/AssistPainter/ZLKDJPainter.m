//
//  ZLKDJPainter.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/2.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLKDJPainter.h"

#import "ZLKDJParam.h"
#import "ZLGuideKDJModel.h"

#define KDJTitleFontSize 12

@interface ZLKDJPainter()

@property (nonatomic, strong) CAShapeLayer *kdjLayer;
@property (nonatomic, strong) CAShapeLayer *kdjInforLayer;
@property (nonatomic, strong) CAShapeLayer *trackingCrosslayer;

@property (nonatomic, strong) CATextLayer *kdjSublayer;
@property (nonatomic, strong) CATextLayer *kSublayer;
@property (nonatomic, strong) CATextLayer *dSublayer;
@property (nonatomic, strong) CATextLayer *jSublayer;

@end

@implementation ZLKDJPainter

- (void)p_initDefault {
    [super p_initDefault];
}

#pragma mark - override
- (void)draw {
    [super draw];
    [self drawKDJ];
    [self drawKDJInfor];
}

// tap
- (void)tapAtPoint:(CGPoint)point {}

// pan
- (void)panBeganPoint:(CGPoint)point {}
- (void)panChangedPoint:(CGPoint)point {
    [self drawKDJ];
    [self drawKDJInfor];
}
- (void)panEndedPoint:(CGPoint)point {}

// pinch
- (void)pinchBeganScale:(CGFloat)scale {}
- (void)pinchChangedScale:(CGFloat)scale {
    [self drawKDJ];
    [self drawKDJInfor];
}
- (void)pinchEndedScale:(CGFloat)scale {}

// longPress
- (void)longPressBeganLocation:(CGPoint)location {
    [self drawKDJInfor];
}
- (void)longPressChangedLocation:(CGPoint)location {
    [self drawKDJInfor];
}
- (void)longPressEndedLocation:(CGPoint)location {
    [self drawKDJInfor];
}

#pragma mark - draw
- (void)drawKDJ {
    [self releaseKDJLayer];
    [self p_addSublayer:self.kdjLayer];
    
    ZLGuideDataPack *dataPack = [self.dataSource kdjDataPackInPainter:self];
    if (!dataPack) {
        return;
    }
    [self.kdjLayer addSublayer:[self getKDJByDataPack:dataPack]];
}

- (void)drawKDJInfor {
    [self releaseKDJInforLayer];
    [self p_addSublayer:self.kdjInforLayer];
    
    ZLGuideDataPack *dataPack = [self.dataSource kdjDataPackInPainter:self];
    if (!dataPack) {
        return;
    }

    NSInteger crossIndex = [self.dataSource longPressIndexInPainter:self];
    ZLGuideKDJModel *guideModel = [dataPack.dataArray objectAtIndex:crossIndex];

    ZLKDJParam *kdjParam = (ZLKDJParam *)dataPack.param;
    NSString *kdjTitle = [NSString stringWithFormat:@"KDJ(%d, %d, %d)",(int)kdjParam.kdjPeriod_N, (int)kdjParam.kdjPeriod_M1, (int)kdjParam.kdjPeriod_M2];
    NSString *kTitle = [NSString stringWithFormat:@"K:%.2f", guideModel.kData];
    NSString *dTitle = [NSString stringWithFormat:@"D:%.2f", guideModel.dData];
    NSString *jTitle = [NSString stringWithFormat:@"J:%.2f", guideModel.jData];

    CGSize kdjSize = [kdjTitle sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(KDJTitleFontSize)}];
    self.kdjSublayer.string = kdjTitle;
    self.kdjSublayer.foregroundColor = kdjParam.dColor.CGColor;
    self.kdjSublayer.frame = CGRectMake(2, 1 - self.p_top, kdjSize.width, kdjSize.height);

    CGSize kSize = [kTitle sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(KDJTitleFontSize)}];
    self.kSublayer.string = kTitle;
    self.kSublayer.foregroundColor = kdjParam.kColor.CGColor;
    self.kSublayer.frame = CGRectMake(self.kdjSublayer.right + 10, 1 - self.p_top, kSize.width, kSize.height);

    CGSize dSize = [dTitle sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(KDJTitleFontSize)}];
    self.dSublayer.string = dTitle;
    self.dSublayer.foregroundColor = kdjParam.dColor.CGColor;
    self.dSublayer.frame = CGRectMake(self.kSublayer.right + 10, 1 - self.p_top, dSize.width, dSize.height);

    CGSize jSize = [jTitle sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(KDJTitleFontSize)}];
    self.jSublayer.string = jTitle;
    self.jSublayer.foregroundColor = kdjParam.jColor.CGColor;
    self.jSublayer.frame = CGRectMake(self.dSublayer.right + 10, 1 - self.p_top, jSize.width, jSize.height);

    [self.kdjInforLayer addSublayer:self.kdjSublayer];
    [self.kdjInforLayer addSublayer:self.kSublayer];
    [self.kdjInforLayer addSublayer:self.dSublayer];
    [self.kdjInforLayer addSublayer:self.jSublayer];
}

#pragma mark - release
- (void)releaseKDJLayer {
    if (_kdjLayer) {
        [_kdjLayer removeFromSuperlayer];
        _kdjLayer = nil;
    }
}

- (void)releaseKDJInforLayer {
    if (_kdjInforLayer) {
        [_kdjInforLayer removeFromSuperlayer];
        _kdjInforLayer = nil;
    }
}

#pragma mark - property
- (CAShapeLayer *)kdjLayer {
    if (!_kdjLayer) {
        _kdjLayer = [CAShapeLayer layer];
        _kdjLayer.frame = self.p_frame;
        _kdjLayer.fillColor = ZLClearColor.CGColor;
        _kdjLayer.lineWidth = LINEWIDTH;
    }
    return _kdjLayer;
}

- (CAShapeLayer *)kdjInforLayer {
    if (!_kdjInforLayer) {
        _kdjInforLayer = [CAShapeLayer layer];
        _kdjInforLayer.frame = self.p_frame;
        _kdjInforLayer.fillColor = ZLClearColor.CGColor;
        _kdjInforLayer.lineWidth = LINEWIDTH;
    }
    return _kdjInforLayer;
}

- (CATextLayer *)kSublayer {
    if (!_kSublayer) {
        _kSublayer = [CATextLayer layer];
        _kSublayer.contentsScale = [UIScreen mainScreen].scale;
        _kSublayer.fontSize = KDJTitleFontSize;
        _kSublayer.alignmentMode = kCAAlignmentJustified;
    }
    return _kSublayer;
}

- (CATextLayer *)dSublayer {
    if (!_dSublayer) {
        _dSublayer = [CATextLayer layer];
        _dSublayer.contentsScale = [UIScreen mainScreen].scale;
        _dSublayer.fontSize = KDJTitleFontSize;
        _dSublayer.alignmentMode = kCAAlignmentJustified;
    }
    return _dSublayer;
}

- (CATextLayer *)jSublayer {
    if (!_jSublayer) {
        _jSublayer = [CATextLayer layer];
        _jSublayer.contentsScale = [UIScreen mainScreen].scale;
        _jSublayer.fontSize = KDJTitleFontSize;
        _jSublayer.alignmentMode = kCAAlignmentJustified;
    }
    return _jSublayer;
}

- (CATextLayer *)kdjSublayer {
    if (!_kdjSublayer) {
        _kdjSublayer = [CATextLayer layer];
        _kdjSublayer.contentsScale = [UIScreen mainScreen].scale;
        _kdjSublayer.fontSize = KDJTitleFontSize;
        _kdjSublayer.alignmentMode = kCAAlignmentJustified;
    }
    return _kdjSublayer;
}

- (CAShapeLayer *)getKDJByDataPack:(ZLGuideDataPack *)dataPack {
    CGFloat aHigherValue = [self.delegate aHigherValueInPainter:self];
    //    CGFloat unitValue = [self.delegate unitValueInPainter:self];
    CGFloat unitValue = [self.delegate painter:self aunitByDValue:self.p_height];
    CGFloat cellWidth = [self.delegate cellWidthInPainter:self];
    CGFloat firstCandleX = [self.dataSource firstCandleXInPainter:self];

    NSArray *guideArray = dataPack.dataArray;
    ZLKDJParam *kdjParams = (ZLKDJParam *)dataPack.param;

    UIBezierPath *kPath = [UIBezierPath bezierPath];
    kPath.lineWidth = LINEWIDTH;
    kPath.lineCapStyle = kCGLineCapRound;
    kPath.lineJoinStyle = kCGLineCapRound;
    UIBezierPath *dPath = [UIBezierPath bezierPath];
    dPath.lineWidth = LINEWIDTH;
    dPath.lineCapStyle = kCGLineCapRound;
    dPath.lineJoinStyle = kCGLineCapRound;
    UIBezierPath *jPath = [UIBezierPath bezierPath];
    jPath.lineWidth = LINEWIDTH;
    jPath.lineCapStyle = kCGLineCapRound;
    jPath.lineJoinStyle = kCGLineCapRound;

    CAShapeLayer *kLayer = [CAShapeLayer layer];
    kLayer.frame = self.p_bounds;
    kLayer.fillColor = ZLClearColor.CGColor;
    kLayer.strokeColor = kdjParams.kColor.CGColor;

    CAShapeLayer *dLayer = [CAShapeLayer layer];
    dLayer.frame = self.p_bounds;
    dLayer.fillColor = ZLClearColor.CGColor;
    dLayer.strokeColor = kdjParams.dColor.CGColor;

    CAShapeLayer *jLayer = [CAShapeLayer layer];
    jLayer.frame = self.p_bounds;
    jLayer.fillColor = ZLClearColor.CGColor;
    jLayer.strokeColor = kdjParams.jColor.CGColor;

    BOOL isHead = YES;
    for (int i = 0; i < guideArray.count; i++) {
        ZLGuideKDJModel *model = guideArray[i];

        CGFloat leftX = firstCandleX + cellWidth * i;
        leftX += candleLeftAdge(cellWidth);
        leftX += candleWidth(cellWidth) / 2;

        CGFloat kY = (aHigherValue - model.kData) / unitValue;
        CGFloat dY = (aHigherValue - model.dData) / unitValue;
        CGFloat jY = (aHigherValue - model.jData) / unitValue;
        if (isHead) {
            [kPath moveToPoint:CGPointMake(leftX, kY)];
            [dPath moveToPoint:CGPointMake(leftX, dY)];
            [jPath moveToPoint:CGPointMake(leftX, jY)];
            isHead = NO;
        } else {
            [kPath addLineToPoint:CGPointMake(leftX, kY)];
            [dPath addLineToPoint:CGPointMake(leftX, dY)];
            [jPath addLineToPoint:CGPointMake(leftX, jY)];
        }
    }

    CAShapeLayer *kdjLayer = [CAShapeLayer layer];
    kdjLayer.frame = self.p_bounds;

    kLayer.path = kPath.CGPath;
    [kPath removeAllPoints];
    [kdjLayer addSublayer:kLayer];

    dLayer.path = dPath.CGPath;
    [dPath removeAllPoints];
    [kdjLayer addSublayer:dLayer];

    jLayer.path = jPath.CGPath;
    [jPath removeAllPoints];
    [kdjLayer addSublayer:jLayer];

    return kdjLayer;
}

- (void)p_clear {
    [self releaseKDJLayer];
    [self releaseKDJInforLayer];
}

@end
