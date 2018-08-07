//
//  ZLPaintCore.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZLGuideDataPack.h"

static const CGFloat InforHeightNONE    = 10;
static const CGFloat InforHeightKDJ     = 40;
static const CGFloat InforHeightRSI     = 40;
static const CGFloat InforHeightBOLL    = 40;
static const CGFloat InforHeightMA      = 60;

static CGFloat inline getMainInforHeight(GuidePaintMainType mainType){
    switch (mainType) {
        case GuidePaintMainTypeMA:
            return InforHeightMA * SCALE;
            break;
        case GuidePaintMainTypeBOLL:
            return InforHeightBOLL * SCALE;
            break;
        case GuidePaintMainTypeNone:
            return InforHeightNONE * SCALE;
            break;
        default:
            break;
    }
    return InforHeightNONE * SCALE;
}

static CGFloat inline getAssistInforHeight(GuidePaintAssistType assistType){
    switch (assistType) {
        case GuidePaintAssistTypeKDJ:
            return InforHeightKDJ * SCALE;
            break;
        case GuidePaintAssistTypeRSI:
            return InforHeightRSI * SCALE;
            break;
        default:
            break;
    }
    return InforHeightNONE * SCALE;
}

/*
 计算绘图数据, 不涉及具体的位置, 只和价格有关
*/
@interface ZLPaintCore : NSObject

// ------ scene base ------ //
@property (nonatomic, assign, readonly) CGFloat sHigherPrice;   // 当前屏幕最高价
@property (nonatomic, assign, readonly) CGFloat sLowerPrice;   // 当前屏幕最低价

@property (nonatomic, assign, readonly) CGFloat aHigherValue;   // 辅助指标最高值
@property (nonatomic, assign, readonly) CGFloat aLowerValue;   // 辅助指标最低值

//@property (nonatomic, assign, readonly) CGFloat unitValue;    // 单位点的值

@property (nonatomic, assign, readonly) CGFloat cellWidth;

@property (nonatomic, assign, readonly) BOOL isShowAll;

// ------ scene candle base ------ //
@property (nonatomic, assign, readonly) NSInteger arrayMaxCount; // 最大展示个数
@property (nonatomic, assign, readonly) NSInteger showCount; // 当前页面显示的个数

// ------ scene cross base ------ //
@property (nonatomic, assign) CGPoint longPressPoint;
@property (nonatomic, assign) NSInteger longPressIndex;
@property (nonatomic, assign) CGFloat firstCandleX;

//@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGFloat portWidth;

@property (nonatomic, strong, readonly) NSArray *curShowArray; // 当前显示队列

@property (nonatomic, strong) NSMutableArray *drawDataArray; //

//@property (nonatomic, assign) ZLKLinePainterOp linePainterOp;
@property (nonatomic, assign) GuidePaintMainType paintMainType;
@property (nonatomic, assign) GuidePaintAssistType paintAssistType;

- (void)editIndex;
- (void)editScale;

- (void)prepareDrawWithPoint:(CGPoint)point andScale:(CGFloat)scale;

#pragma mark - property
- (ZLGuideDataPack *)getDataPackByGuideKey:(NSString *)guideKey;
- (ZLGuideDataPack *)getDataPackByGuideKey:(NSString *)guideKey dataKey:(NSString *)dataKey;

@end
