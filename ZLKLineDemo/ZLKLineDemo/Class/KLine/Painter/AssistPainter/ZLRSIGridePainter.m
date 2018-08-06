//
//  ZLRSIGridePainter.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/6.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLRSIGridePainter.h"

@implementation ZLRSIGridePainter

- (void)draw {
    [super draw];
}

- (void)drawBorder {
    [super drawBorder];
}
- (void)drawLatitudeLines {
    [super drawLatitudeLines];
}

- (void)drawLongittueLines {
    [super drawLongittueLines];
    
    CGFloat aHigherValue = [self.delegate aHigherValueInPainter:self];
    //    CGFloat aLowerValue = [self.delegate aLowerValueInPainter:self];
    
    // 纬线 绘制方式 0,20,50,80四条
    CGFloat unitValue = [self.delegate painter:self aunitByDValue:self.p_height];
    
    //    CGFloat curHigherValue = aHigherValue / kHScale;
    //    CGFloat curLowerValue = aLowerValue / kLScale;
    
    //    CGFloat higherY = (aHigherValue - curHigherValue) / unitValue;
    CGFloat v80Y = (aHigherValue - 80.0) / unitValue;
    CGFloat v50Y = (aHigherValue - 50.0) / unitValue;
    CGFloat v20Y = (aHigherValue - 20.0) / unitValue;
    CGFloat v00Y = (aHigherValue - 0.0) / unitValue;
    //    CGFloat lowerY = (aHigherValue - curLowerValue) / unitValue;
    
    //    [self addLongitudeWithPrice:curHigherValue positionY:higherY];
    [self addLongitudeWithPrice:80.0 positionY:v80Y];
    [self addLongitudeWithPrice:50.0 positionY:v50Y];
    [self addLongitudeWithPrice:20.0 positionY:v20Y];
    [self addLongitudeWithPrice:00.0 positionY:v00Y];
    //    [self addLongitudeWithPrice:curLowerValue positionY:lowerY];
}

- (void)drawTrackingCross {
    [super drawTrackingCross];
    CGFloat cellWidth = [self.delegate cellWidthInPainter:self];
    NSInteger crossIndex = [self.dataSource longPressIndexInPainter:self];
    CGFloat firstCandleX = [self.dataSource firstCandleXInPainter:self];
    CGFloat leftX = firstCandleX + cellWidth * crossIndex;
    
    leftX += candleLeftAdge(cellWidth);
    CGPoint pPoint = CGPointMake(leftX + candleWidth(cellWidth) / 2, 0);
    [self addTrackingCrossLayerWithCrossPoint:pPoint edgeInsets:UIEdgeInsetsZero];
}
@end
