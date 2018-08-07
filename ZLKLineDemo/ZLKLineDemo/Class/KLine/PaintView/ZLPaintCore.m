//
//  ZLPaintCore.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLPaintCore.h"
#import "KLineModel.h"
#import "ZLBasePainter.h"

#import "ZLGuideManager.h"

#import "ZLMAParam.h"
#import "ZLBOLLParam.h"
#import "ZLKDJParam.h"
#import "ZLRSIParam.h"

#define UninitializedIndex   -1


@interface ZLPaintCore()

@property (nonatomic, strong) ZLGuideManager *guideManager;

@property (nonatomic, assign) CGFloat sHigherPrice;
@property (nonatomic, assign) CGFloat sLowerPrice;

@property (nonatomic, assign) CGFloat aHigherValue;
@property (nonatomic, assign) CGFloat aLowerValue;

//@property (nonatomic, assign) CGFloat unitValue;
@property (nonatomic, assign) CGFloat kLineCellWidth;    //cell宽度

@property (nonatomic, assign) CGFloat kMinScale;     //最小缩放量
@property (nonatomic, assign) CGFloat kMaxScale;     //最大缩放量

@property (nonatomic, assign) NSInteger oriIndex;   // pan 之前的第一条index
@property (nonatomic, assign) NSInteger curIndex;   // pan 中当前index

@property (nonatomic, assign) CGFloat oriXScale;      // pinch 之前缩放比例
@property (nonatomic, assign) CGFloat curXScale;      // pinch 中当前缩放比例

@property (nonatomic, assign) NSInteger showCount;
@property (nonatomic, strong) NSArray *curShowArray;

@end

@implementation ZLPaintCore

- (instancetype)init {
    if (self = [super init]) {
        self.kLineCellWidth = 16 * SCALE;    //cell宽度
        
        self.kMinScale = 0.1;     //最小缩放量
        self.kMaxScale = 4.0;     //最大缩放量
        
        self.oriXScale = 1.0;
        self.oriIndex = UninitializedIndex;
        
        self.guideManager = [[ZLGuideManager alloc] init];
    }
    return self;
}

#pragma mark - scene fix
- (void)prepareDrawWithPoint:(CGPoint)point andScale:(CGFloat)scale {
//    if (CGSizeEqualToSize(self.viewPort, CGSizeZero)) {
//        NSAssert(NO, @"Invalid viewPort is zero.");
//        return;
//    }
    
    
    if (!self.drawDataArray || self.drawDataArray.count == 0) {
        NSAssert(NO, @"Invalid drawDataArray is nil or count is zero.");
        return;
    }
    
    [self fixScale:scale];
    [self fixShowCount];
    [self fixBeginIndexWithPoint:point];
    [self fixShowData];
    [self fixSMaximum]; // 主技术指标
    [self fixAMaximum]; // 辅助技术指标
}

// 计算 缩放比例
- (void)fixScale:(CGFloat)scale {
    CGFloat curScale = self.oriXScale * scale;
    curScale = MAX(curScale, self.kMinScale);
    curScale = MIN(curScale, self.kMaxScale);
    
    self.curXScale = curScale;
}

// 计算 要显示几个
- (void)fixShowCount {
    NSInteger showCount = self.portWidth / (self.kLineCellWidth * self.curXScale);
    self.showCount = MIN(self.arrayMaxCount, showCount);
}

// 计算 从第几个开始显示
- (void)fixBeginIndexWithPoint:(CGPoint)point {
    if (self.oriIndex == UninitializedIndex) {
        NSInteger beginIndex = self.arrayMaxCount - self.showCount;
        self.oriIndex = MAX(beginIndex, 0);//初始化偏移位置
    }
    
    CGFloat cellWidth = (self.kLineCellWidth * self.curXScale);
    self.curIndex = self.oriIndex - point.x / cellWidth;
}

- (void)fixShowData {
    NSInteger maxValue = self.arrayMaxCount - self.showCount;
    NSInteger minValue = 0;
    self.curIndex = MIN(self.curIndex, maxValue);
    self.curIndex = MAX(self.curIndex, minValue);
    
    self.curShowArray = [self.drawDataArray subarrayWithRange:NSMakeRange(self.curIndex, self.showCount)];
}

// 计算 主技术指标 最高最低 和 单位值
- (void)fixSMaximum {
    self.sLowerPrice = INT32_MAX;
    self.sHigherPrice = 0;
    
    for (KLineModel *model in self.curShowArray) {
        self.sHigherPrice = MAX(model.high, self.sHigherPrice);
        self.sLowerPrice = MIN(model.low, self.sLowerPrice);
    }
    
    if (self.paintMainType & GuidePaintMainTypeMA) {
        SMaximum *maximum = [self.guideManager getMaximumByGuideKey:kGUIDE_ID_MA range:NSMakeRange(self.curIndex, self.showCount)];
        self.sHigherPrice = MAX(maximum.max, self.sHigherPrice);
        self.sLowerPrice = MIN(maximum.min, self.sLowerPrice);
    }
    
    if (self.paintMainType & GuidePaintMainTypeBOLL) {
        SMaximum *maximum = [self.guideManager getMaximumByGuideKey:kGUIDE_ID_BOLL range:NSMakeRange(self.curIndex, self.showCount)];
        self.sHigherPrice = MAX(maximum.max, self.sHigherPrice);
        self.sLowerPrice = MIN(maximum.min, self.sLowerPrice);
    }
    
    // 预留屏幕上下空隙
    self.sLowerPrice *= kLScale;
    self.sHigherPrice *= kHScale;
}

// 计算辅助技术指标的最高和最低
- (void)fixAMaximum {
    self.aLowerValue = 0; //INT32_MAX;
    self.aHigherValue = 80; //0;
    
    if (self.paintAssistType & GuidePaintAssistTypeKDJ) {
        SMaximum *maximum = [self.guideManager getMaximumByGuideKey:kGUIDE_ID_KDJ range:NSMakeRange(self.curIndex, self.showCount)];
        self.aHigherValue = MAX(maximum.max, self.aHigherValue);
        self.aLowerValue = MIN(maximum.min, self.aLowerValue);
    }
    
    if (self.paintAssistType & GuidePaintAssistTypeRSI) {
        SMaximum *maximum = [self.guideManager getMaximumByGuideKey:kGUIDE_ID_RSI range:NSMakeRange(self.curIndex, self.showCount)];
        self.aHigherValue = MAX(maximum.max, self.aHigherValue);
        self.aLowerValue = MIN(maximum.min, self.aLowerValue);
    }
    
    // 预留屏幕上下空隙
    self.aLowerValue *= kLScale;
    self.aHigherValue *= kHScale;
}

#pragma mark - property
- (NSInteger)arrayMaxCount {
    return self.drawDataArray.count;
}

- (BOOL)isShowAll {
    return self.arrayMaxCount == self.showCount;
}

- (CGFloat)cellWidth {
    return self.kLineCellWidth * self.curXScale;
}

- (NSInteger)longPressIndex {
    if (CGPointEqualToPoint(self.longPressPoint, CGPointZero)) {
        return self.showCount - 1;
    }
    
    CGFloat cellWidth = self.cellWidth;
    NSInteger showCount = self.showCount;
    
    NSInteger crossIndex = (self.longPressPoint.x - self.firstCandleX) / cellWidth;
    
    crossIndex = MAX(crossIndex, 0);
    crossIndex = MIN(crossIndex, showCount - 1);
    return crossIndex;
}

- (CGFloat)firstCandleX {
    CGFloat cellWidth = self.cellWidth;
    NSInteger showCount = self.showCount;
    
    CGFloat leftX = 0;
    BOOL isShowAll = self.isShowAll;
    if (isShowAll) {
        leftX = self.portWidth - showCount * cellWidth;
    }
    return leftX;
}

- (void)editIndex {self.oriIndex = self.curIndex;}
- (void)editScale {self.oriXScale = self.curXScale;}

- (void)setDrawDataArray:(NSMutableArray *)drawDataArray {
    _drawDataArray = drawDataArray;
    [self.guideManager updateWithChartData:drawDataArray];
}

- (ZLGuideDataPack *)getDataPackByGuideKey:(NSString *)guideKey {
    if ([guideKey isEqualToString:kGUIDE_ID_MA]) {
        return [self getDataPackByGuideKey:guideKey dataKey:PKey_MADataID_MA1];
    }
    return [self getDataPackByGuideKey:guideKey dataKey:nil];
}

- (ZLGuideDataPack *)getDataPackByGuideKey:(NSString *)guideKey dataKey:(NSString *)dataKey {
    ZLGuideDataPack *oDataPack = [self.guideManager getDataPackByGuideKey:guideKey dataKey:dataKey];
    if (!oDataPack) return nil;
    
    ZLGuideDataPack *tDataPack = [[ZLGuideDataPack alloc] initWithParams:oDataPack.param];
    tDataPack.dataArray = [oDataPack.dataArray subarrayWithRange:NSMakeRange(self.curIndex, self.showCount)];
    return tDataPack;
}

@end
