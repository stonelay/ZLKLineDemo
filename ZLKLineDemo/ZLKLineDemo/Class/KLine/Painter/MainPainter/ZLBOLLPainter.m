//
//  ZLBOLLPainter.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/31.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLBOLLPainter.h"

#import "ZLGuideBOLLModel.h"
#import "ZLBOLLParam.h"

#import "ZLGuideDataType.h"

#define BOLLTitleFontSize 12

@interface ZLBOLLPainter()

@property (nonatomic, strong) CAShapeLayer *bollLayer;
@property (nonatomic, strong) CAShapeLayer *bollInforLayer;

@property (nonatomic, strong) CATextLayer *bollSublayer;
@property (nonatomic, strong) CATextLayer *mSublayer;
@property (nonatomic, strong) CATextLayer *tSublayer;
@property (nonatomic, strong) CATextLayer *bSublayer;

@end

@implementation ZLBOLLPainter

- (void)p_initDefault {
    [super p_initDefault];
}

#pragma mark - override
- (void)draw {
    [super draw];
    [self drawBOLL];
    [self drawBOLLInfor];
}

// tap
- (void)tapAtPoint:(CGPoint)point {}

// pan
- (void)panBeganPoint:(CGPoint)point {}
- (void)panChangedPoint:(CGPoint)point {
    [self drawBOLL];
    [self drawBOLLInfor];
}
- (void)panEndedPoint:(CGPoint)point {}

// pinch
- (void)pinchBeganScale:(CGFloat)scale {}
- (void)pinchChangedScale:(CGFloat)scale {
    [self drawBOLL];
    [self drawBOLLInfor];
}
- (void)pinchEndedScale:(CGFloat)scale {}

// longPress
- (void)longPressBeganLocation:(CGPoint)location {
    [self drawBOLLInfor];
}
- (void)longPressChangedLocation:(CGPoint)location {
    [self drawBOLLInfor];
}
- (void)longPressEndedLocation:(CGPoint)location {
    [self drawBOLLInfor];
}

#pragma mark - draw
- (void)drawBOLL {
    [self releaseBOLLLayer];
    
    ZLGuideDataPack *dataPack = [self.dataSource bollDataPackInPainter:self];
    if (!dataPack) {
        return;
    }
    [self.bollLayer addSublayer:[self getBOLLByDataPack:dataPack]];
    [self.bollLayer addSublayer:[self getBOLLBandByDataPack:dataPack]];
    
    [self p_addSublayer:self.bollLayer];
}

- (void)drawBOLLInfor {
    [self releaseBOLLInforLayer];
    
    ZLGuideDataPack *dataPack = [self.dataSource bollDataPackInPainter:self];
    if (!dataPack) {
        return;
    }
    
    NSInteger crossIndex = [self.dataSource longPressIndexInPainter:self];
    ZLGuideBOLLModel *guideModel = [dataPack.dataArray objectAtIndex:crossIndex];
    
    ZLBOLLParam *bollParam = (ZLBOLLParam *)dataPack.param;
    NSString *bollTitle = [NSString stringWithFormat:@"BOLL(%d, %d)",(int) bollParam.period, (int)bollParam.k];
    NSString *mTitle = [NSString stringWithFormat:@"M:%.2f", guideModel.midData];
    NSString *tTitle = [NSString stringWithFormat:@"T:%.2f", guideModel.upData];
    NSString *bTitle = [NSString stringWithFormat:@"B:%.2f", guideModel.lowData];
    
    CGSize bollSize = [bollTitle sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(BOLLTitleFontSize)}];
    self.bollSublayer.string = bollTitle;
    self.bollSublayer.foregroundColor = bollParam.midColor.CGColor;
    self.bollSublayer.frame = CGRectMake(2, 1 - self.p_top, bollSize.width, bollSize.height);
    
    CGSize mSize = [mTitle sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(BOLLTitleFontSize)}];
    self.mSublayer.string = mTitle;
    self.mSublayer.foregroundColor = bollParam.midColor.CGColor;
    self.mSublayer.frame = CGRectMake(self.bollSublayer.right + 10, 1 - self.p_top, mSize.width, mSize.height);
    
    CGSize tSize = [tTitle sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(BOLLTitleFontSize)}];
    self.tSublayer.string = tTitle;
    self.tSublayer.foregroundColor = bollParam.upColor.CGColor;
    self.tSublayer.frame = CGRectMake(self.mSublayer.right + 10, 1 - self.p_top, tSize.width, tSize.height);
    
    CGSize bSize = [bTitle sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(BOLLTitleFontSize)}];
    self.bSublayer.string = bTitle;
    self.bSublayer.foregroundColor = bollParam.lowColor.CGColor;
    self.bSublayer.frame = CGRectMake(self.tSublayer.right + 10, 1 - self.p_top, bSize.width, bSize.height);
    
    [self.bollLayer addSublayer:self.bollSublayer];
    [self.bollLayer addSublayer:self.tSublayer];
    [self.bollLayer addSublayer:self.mSublayer];
    [self.bollLayer addSublayer:self.bSublayer];
    
    [self p_addSublayer:self.bollInforLayer];
}

#pragma mark - release
- (void)releaseBOLLLayer {
    if (_bollLayer) {
        [_bollLayer removeFromSuperlayer];
        _bollLayer = nil;
    }
}

- (void)releaseBOLLInforLayer {
    if (_bollInforLayer) {
        [_bollInforLayer removeFromSuperlayer];
        _bollInforLayer = nil;
    }
}

#pragma mark - property
- (CAShapeLayer *)bollLayer {
    if (!_bollLayer) {
        _bollLayer = [CAShapeLayer layer];
        _bollLayer.frame = self.p_frame;
        _bollLayer.fillColor = ZLClearColor.CGColor;
        _bollLayer.lineWidth = LINEWIDTH;
    }
    return _bollLayer;
}

- (CAShapeLayer *)bollInforLayer {
    if (!_bollInforLayer) {
        _bollInforLayer = [CAShapeLayer layer];
        _bollInforLayer.frame = self.p_frame;
        _bollInforLayer.fillColor = ZLClearColor.CGColor;
        _bollInforLayer.lineWidth = LINEWIDTH;
    }
    return _bollInforLayer;
}


- (CATextLayer *)bSublayer {
    if (!_bSublayer) {
        _bSublayer = [CATextLayer layer];
        _bSublayer.contentsScale = [UIScreen mainScreen].scale;
        _bSublayer.fontSize = BOLLTitleFontSize;
        _bSublayer.alignmentMode = kCAAlignmentJustified;
    }
    return _bSublayer;
}

- (CATextLayer *)tSublayer {
    if (!_tSublayer) {
        _tSublayer = [CATextLayer layer];
        _tSublayer.contentsScale = [UIScreen mainScreen].scale;
        _tSublayer.fontSize = BOLLTitleFontSize;
        _tSublayer.alignmentMode = kCAAlignmentJustified;
    }
    return _tSublayer;
}

- (CATextLayer *)mSublayer {
    if (!_mSublayer) {
        _mSublayer = [CATextLayer layer];
        _mSublayer.contentsScale = [UIScreen mainScreen].scale;
        _mSublayer.fontSize = BOLLTitleFontSize;
        _mSublayer.alignmentMode = kCAAlignmentJustified;
    }
    return _mSublayer;
}

- (CATextLayer *)bollSublayer {
    if (!_bollSublayer) {
        _bollSublayer = [CATextLayer layer];
        _bollSublayer.contentsScale = [UIScreen mainScreen].scale;
        _bollSublayer.fontSize = BOLLTitleFontSize;
        _bollSublayer.alignmentMode = kCAAlignmentJustified;
    }
    return _bollSublayer;
}

- (CAShapeLayer *)getBOLLByDataPack:(ZLGuideDataPack *)dataPack {
    CGFloat sHigherPrice = [self.delegate sHigherPriceInPainter:self];
//    CGFloat unitValue = [self.delegate unitValueInPainter:self];
    CGFloat unitValue = [self.delegate painter:self sunitByDValue:self.p_height];
    CGFloat cellWidth = [self.delegate cellWidthInPainter:self];
    CGFloat firstCandleX = [self.dataSource firstCandleXInPainter:self];
    
    NSArray *guideArray = dataPack.dataArray;
    ZLBOLLParam *bollParams = (ZLBOLLParam *)dataPack.param;
    
    UIBezierPath *upPath = [UIBezierPath bezierPath];
    upPath.lineWidth = LINEWIDTH;
    UIBezierPath *midPath = [UIBezierPath bezierPath];
    midPath.lineWidth = LINEWIDTH;
    UIBezierPath *lowPath = [UIBezierPath bezierPath];
    lowPath.lineWidth = LINEWIDTH;
    
    CAShapeLayer *upLayer = [CAShapeLayer layer];
    upLayer.frame = self.p_bounds;
    upLayer.fillColor = ZLClearColor.CGColor;
    upLayer.strokeColor = bollParams.upColor.CGColor;
   
    CAShapeLayer *midLayer = [CAShapeLayer layer];
    midLayer.frame = self.p_bounds;
    midLayer.fillColor = ZLClearColor.CGColor;
    midLayer.strokeColor = bollParams.midColor.CGColor;
    
    CAShapeLayer *lowLayer = [CAShapeLayer layer];
    lowLayer.frame = self.p_bounds;
    lowLayer.fillColor = ZLClearColor.CGColor;
    lowLayer.strokeColor = bollParams.lowColor.CGColor;
    
    BOOL isHead = YES;
    for (int i = 0; i < guideArray.count; i++) {
        ZLGuideBOLLModel *model = guideArray[i];
        if (!model.isNeedDraw) continue;
        
        CGFloat leftX = firstCandleX + cellWidth * i;
        leftX += candleLeftAdge(cellWidth);
        leftX += candleWidth(cellWidth) / 2;
        
        CGFloat upY = (sHigherPrice - model.upData) / unitValue;
        CGFloat midY = (sHigherPrice - model.midData) / unitValue;
        CGFloat lowY = (sHigherPrice - model.lowData) / unitValue;
        if (isHead) {
            [upPath moveToPoint:CGPointMake(leftX, upY)];
            [midPath moveToPoint:CGPointMake(leftX, midY)];
            [lowPath moveToPoint:CGPointMake(leftX, lowY)];
            isHead = NO;
        } else {
            [upPath addLineToPoint:CGPointMake(leftX, upY)];
            [midPath addLineToPoint:CGPointMake(leftX, midY)];
            [lowPath addLineToPoint:CGPointMake(leftX, lowY)];
        }
    }
    
    CAShapeLayer *bollLayer = [CAShapeLayer layer];
    bollLayer.frame = self.p_bounds;
    
    upLayer.strokeColor = bollParams.upColor.CGColor;
    upLayer.path = upPath.CGPath;
    [upPath removeAllPoints];
    [bollLayer addSublayer:upLayer];
    
    midLayer.strokeColor = bollParams.midColor.CGColor;
    midLayer.path = midPath.CGPath;
    [midPath removeAllPoints];
    [bollLayer addSublayer:midLayer];
    
    lowLayer.strokeColor = bollParams.lowColor.CGColor;
    lowLayer.path = lowPath.CGPath;
    [lowPath removeAllPoints];
    [bollLayer addSublayer:lowLayer];
    
    return bollLayer;
}

- (CAShapeLayer *)getBOLLBandByDataPack:(ZLGuideDataPack *)dataPack {
    CGFloat sHigherPrice = [self.delegate sHigherPriceInPainter:self];
//    CGFloat unitValue = [self.delegate unitValueInPainter:self];
    CGFloat unitValue = [self.delegate painter:self sunitByDValue:self.p_height];
    CGFloat cellWidth = [self.delegate cellWidthInPainter:self];
    CGFloat firstCandleX = [self.dataSource firstCandleXInPainter:self];
    
    NSArray *guideArray = dataPack.dataArray;
    ZLBOLLParam *bollParams = (ZLBOLLParam *)dataPack.param;
    
    UIBezierPath *bandPath = [UIBezierPath bezierPath];
    bandPath.lineWidth = LINEWIDTH;
    
    CAShapeLayer *bandShapeLayer = [CAShapeLayer layer];
    bandShapeLayer.frame = self.p_bounds;
    bandShapeLayer.strokeColor = ZLClearColor.CGColor;
    bandShapeLayer.fillColor = bollParams.bandColor.CGColor;
    
    NSMutableArray *tUpArray = [[NSMutableArray alloc] init];
    NSMutableArray *tLowArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < guideArray.count; i++) {
        ZLGuideBOLLModel *model = guideArray[i];
        if (!model.isNeedDraw) continue;
        
        CGFloat leftX = firstCandleX + cellWidth * i;
        leftX += candleLeftAdge(cellWidth);
        leftX += candleWidth(cellWidth) / 2;
        
        CGFloat upY = (sHigherPrice - model.upData) / unitValue;
        CGFloat lowY = (sHigherPrice - model.lowData) / unitValue;
        
        [tUpArray addObject:[NSValue valueWithCGPoint:CGPointMake(leftX, upY)]];
        [tLowArray addObject:[NSValue valueWithCGPoint:CGPointMake(leftX, lowY)]];
    }
    
    for (int i = 0; i < tUpArray.count; i++) {
        if (i == 0) {
            [bandPath moveToPoint:[tUpArray[i] CGPointValue]];
        } else {
            [bandPath addLineToPoint:[tUpArray[i] CGPointValue]];
        }
    }
    
    for (int i = (int)tLowArray.count - 1; i >=0; i--) {
        [bandPath addLineToPoint:[tLowArray[i] CGPointValue]];
    }
    
    bandShapeLayer.path = bandPath.CGPath;
    [bandPath removeAllPoints];
    
    return bandShapeLayer;
}

- (void)p_clear {
    [self releaseBOLLLayer];
    [self releaseBOLLInforLayer];
}

@end
