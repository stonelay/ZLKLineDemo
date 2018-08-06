//
//  ZLPaintMainScene.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/24.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLPaintMainScene.h"

#import "LZCandleGridePainter.h"
#import "ZLCandlePainter.h"
#import "ZLMAPainter.h"
#import "ZLBOLLPainter.h"

#import "ZLQuoteDataCenter.h"

#import "KLineModel.h"

#import "ZLGuideDataType.h"
#import "ZLPaintCore.h"

#define UninitializedIndex   -1

@interface ZLPaintMainScene()<PaintViewDelegate, PaintViewDataSource>

@property (nonatomic, strong) LZCandleGridePainter *gridePainter;
@property (nonatomic, strong) ZLCandlePainter *candlePainter;

@property (nonatomic, strong) NSDictionary *mainPainters;   // <key, painter>

@end

@implementation ZLPaintMainScene

- (LZCandleGridePainter *)gridePainter {
    if (!_gridePainter) {
        _gridePainter = [[LZCandleGridePainter alloc] initWithPaintView:self];
        _gridePainter.paintOp = ZLGridePaintShowAll ^ ZLGridePaintShowLatitudeTitle;
        _gridePainter.dataSource = self;
        _gridePainter.delegate = self;
    }
    return _gridePainter;
}

- (ZLCandlePainter *)candlePainter {
    if (!_candlePainter) {
        _candlePainter = [[ZLCandlePainter alloc] initWithPaintView:self];
        _candlePainter.dataSource = self;
        _candlePainter.delegate = self;
    }
    return _candlePainter;
}

- (NSDictionary *)mainPainters {
    if (!_mainPainters) {
        NSMutableDictionary *tDic = [[NSMutableDictionary alloc] init];
        
        ZLBasePainter *maPainter = [[ZLMAPainter alloc] initWithPaintView:self];
        maPainter.dataSource = self;
        maPainter.delegate = self;
        [tDic setObject:maPainter forKey:[ZLGuideDataType getNameByPaintMainType:GuidePaintMainTypeMA]];
        
        ZLBasePainter *bollPainter = [[ZLBOLLPainter alloc] initWithPaintView:self];
        bollPainter.dataSource = self;
        bollPainter.delegate = self;
        [tDic setObject:bollPainter forKey:[ZLGuideDataType getNameByPaintMainType:GuidePaintMainTypeBOLL]];
        
        _mainPainters = [tDic copy];
    }
    return _mainPainters;
}

- (void)draw {
    [self.paintCore prepareDrawWithPoint:CGPointZero andScale:1.0];
    [self doInterfaceMethod:_cmd andData:nil];
}

- (void)clear {}

#pragma mark - main paint dataSource
- (NSUInteger)maxNumberInPainter:(ZLBasePainter *)painter {
    return self.paintCore.arrayMaxCount;
}

- (NSUInteger)showNumberInPainter:(ZLBasePainter *)painter {
    return self.paintCore.showCount;
}

- (NSArray *)showArrayInPainter:(ZLBasePainter *)painter {
    return self.paintCore.curShowArray;
}

- (KLineModel *)painter:(ZLBasePainter *)painter dataAtIndex:(NSUInteger)index {
    return self.paintCore.curShowArray[index];
}

- (BOOL)isShowAllInPainter:(ZLBasePainter *)painter {
    return self.paintCore.isShowAll;
}

- (CGPoint)longPressPointInPainter:(ZLBasePainter *)painter {
    return self.paintCore.longPressPoint;
}

- (NSInteger)longPressIndexInPainter:(ZLBasePainter *)painter {
    return self.paintCore.longPressIndex;
}

- (CGFloat)firstCandleXInPainter:(ZLBasePainter *)painter {
    return self.paintCore.firstCandleX;
}

- (ZLGuideDataPack *)painter:(ZLBasePainter *)painter dataPackByMA:(NSString *)ma {
    return [self.paintCore getMADataPackByKey:ma];
}

- (ZLGuideDataPack *)bollDataPackInPainter:(ZLBasePainter *)painter {
    return [self.paintCore getBOLLDataPack];
}

#pragma mark - main paitview delegate
- (CGFloat)cellWidthInPainter:(ZLBasePainter *)painter {
    return self.paintCore.cellWidth;
}

- (UIEdgeInsets)edgeInsetsInPainter:(ZLBasePainter *)painter {
    return self.degeInsets;
}

- (CGFloat)sHigherPriceInPainter:(ZLBasePainter *)painter {
    return self.paintCore.sHigherPrice;
}

- (CGFloat)sLowerPriceInPainter:(ZLBasePainter *)painter {
    return self.paintCore.sLowerPrice;
}

- (CGFloat)painter:(ZLBasePainter *)painter sunitByDValue:(CGFloat)dValue {
    return (self.paintCore.sHigherPrice - self.paintCore.sLowerPrice) / dValue;
}

#pragma mark - override
// tap
- (void)tapAtPoint:(CGPoint)point {
    [self tapNextMainType];
    [self draw];
    [self doInterfaceMethod:_cmd andData:[NSValue valueWithCGPoint:point]];
}

// pan
- (void)panBeganPoint:(CGPoint)point {
    [self.paintCore editIndex];
    [self doInterfaceMethod:_cmd andData:[NSValue valueWithCGPoint:point]];
}
- (void)panChangedPoint:(CGPoint)point {
    [self.paintCore prepareDrawWithPoint:point andScale:1.0];
    [self doInterfaceMethod:_cmd andData:[NSValue valueWithCGPoint:point]];
}
- (void)panEndedPoint:(CGPoint)point {
    [self.paintCore editIndex];
    [self doInterfaceMethod:_cmd andData:[NSValue valueWithCGPoint:point]];
}

// pinch
- (void)pinchBeganScale:(CGFloat)scale {
    [self.paintCore editScale];
    [self doInterfaceMethod:_cmd andData:[NSNumber numberWithFloat:scale]];
}
- (void)pinchChangedScale:(CGFloat)scale {
    [self.paintCore prepareDrawWithPoint:CGPointZero andScale:scale];
    [self doInterfaceMethod:_cmd andData:[NSNumber numberWithFloat:scale]];
}
- (void)pinchEndedScale:(CGFloat)scale {
    [self.paintCore editScale];
    [self doInterfaceMethod:_cmd andData:[NSNumber numberWithFloat:scale]];
}

// longPress
- (void)longPressBeganLocation:(CGPoint)location {
    self.paintCore.longPressPoint = location;
    [self doInterfaceMethod:_cmd andData:[NSValue valueWithCGPoint:location]];
}
- (void)longPressChangedLocation:(CGPoint)location {
    self.paintCore.longPressPoint = location;
    [self doInterfaceMethod:_cmd andData:[NSValue valueWithCGPoint:location]];
}
- (void)longPressEndedLocation:(CGPoint)location {
    self.paintCore.longPressPoint = CGPointZero;
    [self doInterfaceMethod:_cmd andData:[NSValue valueWithCGPoint:location]];
}

- (void)doInterfaceMethod:(SEL)methodName andData:(id)data {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    [self.gridePainter performSelector:methodName withObject:data];
    [self.candlePainter performSelector:methodName withObject:data];
    
    // main
    if (self.paintCore.paintMainType & GuidePaintMainTypeMA) {
        ZLBasePainter *mainPainter = [self.mainPainters objectForKey:[ZLGuideDataType getNameByPaintMainType:GuidePaintMainTypeMA]];
        if (mainPainter) { [mainPainter performSelector:methodName withObject:data]; }
    }
    
    if (self.paintCore.paintMainType & GuidePaintMainTypeBOLL) {
        ZLBasePainter *mainPainter = [self.mainPainters objectForKey:[ZLGuideDataType getNameByPaintMainType:GuidePaintMainTypeBOLL]];
        if (mainPainter) { [mainPainter performSelector:methodName withObject:data]; }
    }
    
    // TODO add other main
    
    //    // assist
    //    if (self.paintCore.paintAssistType & GuidePaintAssistTypeKDJ) {
    //        ZLBasePainter *assistPainter = [self.assistPainters objectForKey:[ZLGuideDataType getNameByPaintAssistType:GuidePaintAssistTypeKDJ]];
    //        if (assistPainter) { [assistPainter performSelector:methodName withObject:data]; }
    //    }
    
    // TODO add other assist
    
#pragma clang diagnostic pop
}

#pragma mark - private
- (void)tapNextMainType {
    if (self.paintCore.paintMainType & GuidePaintMainTypeMA) {
        ZLBasePainter *mainPainter = [self.mainPainters objectForKey:[ZLGuideDataType getNameByPaintMainType:GuidePaintMainTypeMA]];
        [mainPainter clear];
    }
    
    if (self.paintCore.paintMainType & GuidePaintMainTypeBOLL) {
        ZLBasePainter *mainPainter = [self.mainPainters objectForKey:[ZLGuideDataType getNameByPaintMainType:GuidePaintMainTypeBOLL]];
        [mainPainter clear];
    }
    
    self.paintCore.paintMainType = [ZLGuideDataType getNextMainType:self.paintCore.paintMainType];
    
    if (self.paintCore.paintMainType & GuidePaintMainTypeBOLL) {
        UIEdgeInsets dege = self.degeInsets;
        dege.top = getMainInforHeight(GuidePaintMainTypeBOLL);
        self.degeInsets = dege;
    }
    if (self.paintCore.paintMainType & GuidePaintMainTypeMA) {
        UIEdgeInsets dege = self.degeInsets;
        dege.top = getMainInforHeight(GuidePaintMainTypeMA);
        self.degeInsets = dege;
    }
    if (self.paintCore.paintMainType == GuidePaintMainTypeNone) {
        UIEdgeInsets dege = self.degeInsets;
        dege.top = getMainInforHeight(GuidePaintMainTypeNone);
        self.degeInsets = dege;
    }
}

- (void)setPaintCore:(ZLPaintCore *)paintCore {
    _paintCore = paintCore;
    self.degeInsets = UIEdgeInsetsMake(getMainInforHeight(paintCore.paintMainType), 0, 0, 0);
}

- (void)setDegeInsets:(UIEdgeInsets)degeInsets {
    _degeInsets = degeInsets;
    self.paintCore.portWidth = self.width - self.degeInsets.left - self.degeInsets.right;
}
@end
