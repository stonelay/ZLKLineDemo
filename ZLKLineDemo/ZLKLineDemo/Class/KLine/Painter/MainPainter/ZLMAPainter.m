//
//  ZLMAPainter.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/27.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLMAPainter.h"

#import "ZLGuideMAModel.h"
#import "ZLMAParam.h"

#define MATitleFontSize 12

@interface ZLMAPainter()

@property (nonatomic, strong) CAShapeLayer *maLayer;
@property (nonatomic, strong) CAShapeLayer *maInforLayer;

@end

@implementation ZLMAPainter

- (void)p_initDefault {
    [super p_initDefault];
//    self.maLayer.strokeColor = maColor.CGColor;
}

#pragma mark - override
- (void)draw {
    [super draw];
    [self drawMA];
    [self drawMAInfor];
}

// tap
- (void)tapAtPoint:(CGPoint)point {}

// pan
- (void)panBeganPoint:(CGPoint)point {}
- (void)panChangedPoint:(CGPoint)point {
    [self drawMA];
    [self drawMAInfor];
}
- (void)panEndedPoint:(CGPoint)point {}

// pinch
- (void)pinchBeganScale:(CGFloat)scale {}
- (void)pinchChangedScale:(CGFloat)scale {
    [self drawMA];
    [self drawMAInfor];
}
- (void)pinchEndedScale:(CGFloat)scale {}

// longPress
- (void)longPressBeganLocation:(CGPoint)location {
    [self drawMAInfor];
}
- (void)longPressChangedLocation:(CGPoint)location {
    [self drawMAInfor];
}
- (void)longPressEndedLocation:(CGPoint)location {
    [self drawMAInfor];
}

#pragma mark - draw
- (void)drawMA {
    [self releaseMaLayer];
    [self p_addSublayer:self.maLayer];
    
    NSMutableArray *dataPacks = [[NSMutableArray alloc] init];
    // safe nill
    [dataPacks addObject:[self.dataSource painter:self dataPackByMA:PKey_MADataID_MA1]];
    [dataPacks addObject:[self.dataSource painter:self dataPackByMA:PKey_MADataID_MA2]];
    [dataPacks addObject:[self.dataSource painter:self dataPackByMA:PKey_MADataID_MA3]];
    [dataPacks addObject:[self.dataSource painter:self dataPackByMA:PKey_MADataID_MA4]];
    [dataPacks addObject:[self.dataSource painter:self dataPackByMA:PKey_MADataID_MA5]];
    
    CGFloat sHigherPrice = [self.delegate sHigherPriceInPainter:self];
//    CGFloat unitValue = [self.delegate unitValueInPainter:self];
    CGFloat unitValue = [self.delegate painter:self sunitByDValue:self.p_height];
    CGFloat showCount = [self.dataSource showNumberInPainter:self];
    CGFloat cellWidth = [self.delegate cellWidthInPainter:self];
    CGFloat firstCandleX = [self.dataSource firstCandleXInPainter:self];

    for (int i = 0; i < dataPacks.count; i++) {
        ZLGuideDataPack *dataPack = dataPacks[i];
        [self.maLayer addSublayer:[self getMALayerByDataPack:dataPack higherPrice:sHigherPrice unitValue:unitValue showCount:showCount cellWidth:cellWidth firstCandleX:firstCandleX]];
    }
}

- (void)drawMAInfor {
    [self releaseMaInforLayer];
    [self p_addSublayer:self.maInforLayer];
    
    NSMutableArray *dataPacks = [[NSMutableArray alloc] init];
    // safe nill
    [dataPacks addObject:[self.dataSource painter:self dataPackByMA:PKey_MADataID_MA1]];
    [dataPacks addObject:[self.dataSource painter:self dataPackByMA:PKey_MADataID_MA2]];
    [dataPacks addObject:[self.dataSource painter:self dataPackByMA:PKey_MADataID_MA3]];
    [dataPacks addObject:[self.dataSource painter:self dataPackByMA:PKey_MADataID_MA4]];
    [dataPacks addObject:[self.dataSource painter:self dataPackByMA:PKey_MADataID_MA5]];
    
    NSInteger crossIndex = [self.dataSource longPressIndexInPainter:self];
    
    CGFloat bLeft = 2;
    CGFloat bTop = 1;
    CGPoint origin = CGPointMake(bLeft, bTop - self.p_top);
    for (int i = 0; i < dataPacks.count; i++) {
        ZLGuideDataPack *dataPack = dataPacks[i];
        ZLMAParam *maParam = (ZLMAParam *)dataPack.param;
        ZLGuideMAModel *guideModel = dataPack.dataArray[crossIndex];
        
        NSString *title = [NSString stringWithFormat:@"MA%d: %.2f", (int)maParam.period, guideModel.data];
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(MATitleFontSize)}];
        
        CGRect frame = CGRectMake(origin.x, origin.y, titleSize.width, titleSize.height);
        if (origin.x > bLeft &&  CGRectGetMaxX(frame) > self.p_width) {
            origin.x = bLeft;
            origin.y += titleSize.height + bTop;
            frame = CGRectMake(origin.x, origin.y, titleSize.width, titleSize.height);
        }
        origin.x += titleSize.width + 8;
        
        [self.maInforLayer addSublayer:[self getMaInforByMAParam:(ZLMAParam *)dataPack.param withFrame:frame title:title]];
    }
}

#pragma mark - release
- (void)releaseMaLayer{
    if (_maLayer) {
        [_maLayer removeFromSuperlayer];
        _maLayer = nil;
    }
}

- (void)releaseMaInforLayer{
    if (_maInforLayer) {
        [_maInforLayer removeFromSuperlayer];
        _maInforLayer = nil;
    }
}

#pragma mark - property
- (CAShapeLayer *)maLayer {
    if (!_maLayer) {
        _maLayer = [CAShapeLayer layer];
        _maLayer.frame = self.p_frame;
        _maLayer.fillColor = ZLClearColor.CGColor;
        _maLayer.lineWidth = LINEWIDTH;
    }
    return _maLayer;
}

- (CAShapeLayer *)maInforLayer {
    if (!_maInforLayer) {
        _maInforLayer = [CAShapeLayer layer];
        _maInforLayer.frame = self.p_frame;
        _maInforLayer.fillColor = ZLClearColor.CGColor;
        _maInforLayer.lineWidth = LINEWIDTH;
    }
    return _maInforLayer;
}

- (CAShapeLayer *)getMALayerByDataPack:(ZLGuideDataPack *)dataPack
                           higherPrice:(CGFloat)sHigherPrice
                             unitValue:(CGFloat)unitValue
                             showCount:(NSUInteger)showCount
                             cellWidth:(CGFloat)cellWidth
                          firstCandleX:(CGFloat)firstCandleX {
    
    NSArray *guideArray = dataPack.dataArray;
    ZLMAParam *maParams = (ZLMAParam *)dataPack.param;
    
    UIBezierPath *maPath = [UIBezierPath bezierPath];
    maPath.lineWidth = LINEWIDTH;
    
    CAShapeLayer *maShapeLayer = [CAShapeLayer layer];
    maShapeLayer.frame = self.p_bounds;
    maShapeLayer.strokeColor = maParams.maColor.CGColor;
    maShapeLayer.fillColor = ZLClearColor.CGColor;
    
    BOOL hasHead = NO;
    for (int i = 0; i < guideArray.count; i++) {
        ZLGuideMAModel *model = guideArray[i];
        if (!model.isNeedDraw) continue;
        
        CGFloat leftX = firstCandleX + cellWidth * i;
        leftX += candleLeftAdge(cellWidth);
        leftX += candleWidth(cellWidth) / 2;
        
        CGFloat maY = (sHigherPrice - model.data) / unitValue;
        if (hasHead) {
            [maPath addLineToPoint:CGPointMake(leftX, maY)];
        } else {
            [maPath moveToPoint:CGPointMake(leftX, maY)];
            hasHead = YES;
        }
    }
    
    maShapeLayer.path = maPath.CGPath;
    [maPath removeAllPoints];
    
    return maShapeLayer;
}

- (CATextLayer *)getMaInforByMAParam:(ZLMAParam *)param withFrame:(CGRect)frame title:(NSString *)title {
    CATextLayer *layer = [CATextLayer layer];
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.fontSize = MATitleFontSize;
    layer.alignmentMode = kCAAlignmentJustified;
    layer.foregroundColor = param.maColor.CGColor;
    
    layer.string = title;
    
    layer.frame = frame;
    return layer;
}

- (void)p_clear {
    [self releaseMaLayer];
    [self releaseMaInforLayer];
}


@end
