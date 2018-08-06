//
//  ZLGridePainter.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/24.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGridePainter.h"

#define BorderStrokeColor       ZLHEXCOLOR(0xB22222)
#define AxisStrokeColor         ZLHEXCOLOR(0xA52A2A)
#define CrossColor              ZLHEXCOLOR(0xbebebe)

#define LongitudeTitleFontSize  12
#define LatitudeTitleFontSize   10

#define LongitudeStrokeColor    ZLGray(167)
#define LongitudeTitleColor     ZLGray(99)
#define LatitudeStrokeColor     ZLGray(167)
#define LatitudeTitleColor      ZLGray(99)

@interface ZLGridePainter()

@property (nonatomic, strong) CAShapeLayer *trackingCrosslayer;// 十字线

@property (nonatomic, strong) CAShapeLayer *borderShapeLayer;
@property (nonatomic, strong) CAShapeLayer *xAxisShapeLayer;

@property (nonatomic, strong) CAShapeLayer *latitudeLayer;
@property (nonatomic, strong) CAShapeLayer *longitudeLayer;

@end

@implementation ZLGridePainter

- (void)p_initDefault {
    [super p_initDefault];
}

#pragma mark - override
- (void)draw {
    [super draw];
    
    [self drawBorder];
    [self drawAxis];
    [self drawLongittueLines];
    [self drawLatitudeLines];
}

// tap
- (void)tapAtPoint:(CGPoint)point {}

// pan
- (void)panBeganPoint:(CGPoint)point {}
- (void)panChangedPoint:(CGPoint)point {
    [self drawLongittueLines];
    [self drawLatitudeLines];
}
- (void)panEndedPoint:(CGPoint)point {}

// pinch
- (void)pinchBeganScale:(CGFloat)scale {}
- (void)pinchChangedScale:(CGFloat)scale {
    [self drawLongittueLines];
    [self drawLatitudeLines];
}
- (void)pinchEndedScale:(CGFloat)scale {}

// longPress
- (void)longPressBeganLocation:(CGPoint)location {
    [self drawTrackingCross];
}

- (void)longPressChangedLocation:(CGPoint)location {
    [self drawTrackingCross];
}

- (void)longPressEndedLocation:(CGPoint)location {
    [self releaseTrackingCrossLayer];
}

#pragma mark - draw
- (void)drawBorder {
    [self releaseBorderShapeLayer];
    [self p_addSublayer:self.borderShapeLayer];
    
//    CGRect border = CGRectMake(self.p_left, self.p_top, self.p_width, self.p_height + self.p_bottom);
    CGRect border = self.s_bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:border];
    self.borderShapeLayer.path = path.CGPath;
    [path removeAllPoints];
}

- (void)drawAxis {
    [self releaseXAxisShapeLayer];
    [self p_addSublayer:self.xAxisShapeLayer];
    
    CGPoint pointLT = CGPointMake(self.p_left, self.p_top);     // lt
    CGPoint pointLB = CGPointMake(self.p_left, self.p_bottom);  // lb
    CGPoint pointRT = CGPointMake(self.p_right, self.p_top);    // rt
    CGPoint pointRB = CGPointMake(self.p_right, self.p_bottom); // rb
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    // top
    [path moveToPoint:pointLT];
    [path addLineToPoint:pointRT];
    // left
    [path moveToPoint:pointLT];
    [path addLineToPoint:pointLB];
    // right
    [path moveToPoint:pointRT];
    [path addLineToPoint:pointRB];
    // bottom
    [path moveToPoint:pointRB];
    [path addLineToPoint:pointLB];
    
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineCapRound; //终点处理
    
    self.xAxisShapeLayer.path = path.CGPath;
    
    [path removeAllPoints];
}

- (void)drawLatitudeLines {
    [self releaseLatitudeLayer];
    [self p_addSublayer:self.latitudeLayer];
    
    // 经线绘制方式 绘制大于等于 五条
    NSUInteger showCount = [self.dataSource showNumberInPainter:self];
    NSUInteger step = showCount / 4;
    
    NSArray *curShowArray = [self.dataSource showArrayInPainter:self];
    
    CGFloat cellWidth = [self.delegate cellWidthInPainter:self];
    CGFloat firstCandleX = [self.dataSource firstCandleXInPainter:self];
    
    for (int i = 0; i < showCount; i+=step) {
        CGFloat leftX = firstCandleX + cellWidth * i;
        leftX += candleWidth(cellWidth) / 2 + candleLeftAdge(cellWidth);
        
        if (self.paintOp & ZLGridePaintShowLatitude) {
            CAShapeLayer *subLatitudeLayer = [self getLatitudeLayerFromPositionX:leftX];
            [self.latitudeLayer addSublayer:subLatitudeLayer];
        }
        
        if (self.paintOp & ZLGridePaintShowLatitudeTitle) {
            KLineModel *model = curShowArray[i];
            CATextLayer *titleLayer = [self getLatitudeTitleFromPositionX:leftX title:model.date];
            [self.latitudeLayer addSublayer:titleLayer];
        }
    }
}

- (void)drawLongittueLines {
    [self releaseLongitudeLayer];
    [self p_addSublayer:self.longitudeLayer];
}

- (void)drawTrackingCross {
    [self releaseTrackingCrossLayer];
    [self p_addSublayer:self.trackingCrosslayer];
}

#pragma mark - release
- (void)releaseBorderShapeLayer{
    if (_borderShapeLayer) {
        [_borderShapeLayer removeFromSuperlayer];
        _borderShapeLayer = nil;
    }
}

- (void)releaseXAxisShapeLayer {
    if (_xAxisShapeLayer) {
        [_xAxisShapeLayer removeFromSuperlayer];
        _xAxisShapeLayer = nil;
    }
}

- (void)releaseLongitudeLayer {
    if (_longitudeLayer) {
        [_longitudeLayer removeFromSuperlayer];
        _longitudeLayer = nil;
    }
}

- (void)releaseLatitudeLayer {
    if (_latitudeLayer) {
        [_latitudeLayer removeFromSuperlayer];
        _latitudeLayer = nil;
    }
}

- (void)releaseTrackingCrossLayer {
    if (_trackingCrosslayer) {
        [_trackingCrosslayer removeFromSuperlayer];
        _trackingCrosslayer = nil;
    }
}

#pragma mark - property
- (CAShapeLayer *)borderShapeLayer {
    if (!_borderShapeLayer) {
        _borderShapeLayer = [CAShapeLayer layer];
        _borderShapeLayer.frame = self.s_bounds;
        _borderShapeLayer.fillColor = ZLClearColor.CGColor;
        _borderShapeLayer.strokeColor = BorderStrokeColor.CGColor;
        _borderShapeLayer.lineWidth = LINEWIDTH;
    }
    return _borderShapeLayer;
}

- (CAShapeLayer *)xAxisShapeLayer {
    if (!_xAxisShapeLayer) {
        _xAxisShapeLayer = [CAShapeLayer layer];
        _xAxisShapeLayer.frame = self.s_bounds;
        _xAxisShapeLayer.fillColor = ZLClearColor.CGColor;
        _xAxisShapeLayer.strokeColor = AxisStrokeColor.CGColor;
        _xAxisShapeLayer.lineWidth = LINEWIDTH;
    }
    return _xAxisShapeLayer;
}

- (CAShapeLayer *)longitudeLayer {
    if (!_longitudeLayer) {
        _longitudeLayer = [CAShapeLayer layer];
        _longitudeLayer.frame = self.p_frame;
        _longitudeLayer.fillColor = ZLClearColor.CGColor;
        _longitudeLayer.lineWidth = LINEWIDTH;
    }
    return _longitudeLayer;
}

- (CAShapeLayer *)latitudeLayer {
    if (!_latitudeLayer) {
        _latitudeLayer = [CAShapeLayer layer];
        _latitudeLayer.frame = self.p_frame;
        _latitudeLayer.fillColor = ZLClearColor.CGColor;
        _latitudeLayer.lineWidth = LINEWIDTH;
    }
    return _latitudeLayer;
}

- (CAShapeLayer *)trackingCrosslayer {
    if (!_trackingCrosslayer) {
        _trackingCrosslayer = [CAShapeLayer layer];
        _trackingCrosslayer.frame = self.p_frame;
    }
    return _trackingCrosslayer;
}

#pragma mark - sublayers
- (CAShapeLayer *)getLatitudeLayerFromPositionX:(CGFloat)positionX {
    
    UIBezierPath *latpath = [UIBezierPath bezierPath];
    latpath.lineWidth = LINEWIDTH;
    
    [latpath moveToPoint:CGPointMake(positionX, 0)];
    [latpath addLineToPoint:CGPointMake(positionX, self.p_height)];
    
    CAShapeLayer *latLayer = [CAShapeLayer layer];
    latLayer.frame = self.p_bounds;
    latLayer.strokeColor = LatitudeStrokeColor.CGColor;
    latLayer.lineDashPattern = @[@3, @5];
    
    latLayer.path = latpath.CGPath;
    [latpath removeAllPoints];
    
    return latLayer;
}

- (CATextLayer *)getLatitudeTitleFromPositionX:(CGFloat)positionX title:(NSString *)title {
    CATextLayer *layer = [CATextLayer layer];
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.fontSize = LatitudeTitleFontSize;
    layer.alignmentMode = kCAAlignmentJustified;
    layer.foregroundColor = LatitudeTitleColor.CGColor;
    
    if (!title) return layer;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(LatitudeTitleFontSize)}];
    layer.string = title;
    
    positionX -= titleSize.width / 2;
    
    if (positionX < 0) {
        positionX += titleSize.width / 2;
    } else if (positionX + titleSize.width > self.p_width) {
        positionX -= titleSize.width / 2;
    }
    
    layer.frame = CGRectMake(positionX, self.p_height + 4, titleSize.width, titleSize.height);
    return layer;
}

- (CAShapeLayer *)getLongitudeLayerFromPositionY:(CGFloat)positionY {
    UIBezierPath *lonpath = [UIBezierPath bezierPath];
    lonpath.lineWidth = LINEWIDTH;
    
    [lonpath moveToPoint:CGPointMake(0, positionY)];
    [lonpath addLineToPoint:CGPointMake(self.p_width, positionY)];
    
    CAShapeLayer *lonLayer = [CAShapeLayer layer];
    lonLayer.frame = self.p_bounds;
    lonLayer.strokeColor = LongitudeStrokeColor.CGColor;
    lonLayer.lineDashPattern = @[@2, @2];
    
    lonLayer.path = lonpath.CGPath;
    [lonpath removeAllPoints];

    return lonLayer;
}

- (CATextLayer *)getLongitudeTitleFromPositionY:(CGFloat)positionY title:(NSString *)title {
    CATextLayer *layer = [CATextLayer layer];
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.fontSize = LongitudeTitleFontSize;
    layer.alignmentMode = kCAAlignmentJustified;
    layer.foregroundColor = LongitudeTitleColor.CGColor;
    
    if (!title) return layer;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:ZLNormalFont(LongitudeTitleFontSize)}];
    layer.string = title;
    
    layer.frame = CGRectMake(4, positionY - titleSize.height - 2, titleSize.width, titleSize.height);
    return layer;
}

- (void)addLongitudeWithPrice:(CGFloat)price positionY:(CGFloat)positionY {
    CAShapeLayer *lonLayer = [self getLongitudeLayerFromPositionY:positionY];
    CATextLayer *lonTitleLayer = [self getLongitudeTitleFromPositionY:positionY title:[NSString stringWithFormat:@"%.2f", price]];
    if (self.paintOp & ZLGridePaintShowLongitude) {
        [self.longitudeLayer addSublayer:lonLayer];
    }
    if (self.paintOp & ZLGridePaintShowLongitude) {
        [self.longitudeLayer addSublayer:lonTitleLayer];
    }
}

- (void)addTrackingCrossLayerWithCrossPoint:(CGPoint)crossPoint edgeInsets:(UIEdgeInsets)edgeInsets {
    if (CGPointEqualToPoint(crossPoint, CGPointZero)) {
        return;
    }
    UIBezierPath *crossPath = [UIBezierPath bezierPath];
    crossPath.lineCapStyle = kCGLineCapRound;
    crossPath.lineJoinStyle = kCGLineCapRound;
    
    if (UIEdgeInsetsEqualToEdgeInsets(edgeInsets, UIEdgeInsetsZero)) {
        [crossPath moveToPoint:CGPointMake(crossPoint.x, 0)];
        [crossPath addLineToPoint:CGPointMake(crossPoint.x, self.p_height)];
    } else {
        NSLog(@"%f,%f", edgeInsets.top, edgeInsets.bottom);
        CGFloat edge = (edgeInsets.left + edgeInsets.right) / 2;
        
        CGFloat top = crossPoint.y - edgeInsets.top - edge;
        CGFloat bottom = crossPoint.y + edgeInsets.bottom + edge;
        CGFloat left = crossPoint.x - edgeInsets.left - edge;
        CGFloat right = crossPoint.x + edgeInsets.right + edge;
        CGFloat crossY = crossPoint.y;
        CGFloat crossX = crossPoint.x;
        
        // xCross
        [crossPath moveToPoint:CGPointMake(0, crossY)];
        [crossPath addLineToPoint:CGPointMake(left, crossY)];
        [crossPath moveToPoint:CGPointMake(right, crossY)];
        [crossPath addLineToPoint:CGPointMake(self.p_width, crossY)];
        
        // yCross
        [crossPath moveToPoint:CGPointMake(crossX, 0)];
        [crossPath addLineToPoint:CGPointMake(crossX, top)];
        [crossPath moveToPoint:CGPointMake(crossX, bottom)];
        [crossPath addLineToPoint:CGPointMake(crossX, self.p_height)];
    }
    
    
    CAShapeLayer *crossCAShapeLayer = [CAShapeLayer layer];
    crossCAShapeLayer.frame = self.p_bounds;
    crossCAShapeLayer.strokeColor = CrossColor.CGColor;
    
    crossCAShapeLayer.path = crossPath.CGPath;
    
    [crossPath removeAllPoints];
    
    [self.trackingCrosslayer addSublayer:crossCAShapeLayer];
}

- (void)p_clear {
    [self releaseBorderShapeLayer];
    [self releaseXAxisShapeLayer];
    [self releaseLatitudeLayer];
    [self releaseLongitudeLayer];
    [self releaseTrackingCrossLayer];
}


@end
