//
//  ZLRSITransformer.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/6.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLRSITransformer.h"

#import "ZLRSIParam.h"
#import "KLineModel.h"

#import "ZLGuideRSIModel.h"

@implementation ZLRSITransformer

- (NSString *)guideID {
    return kGUIDE_ID_RSI;
}

- (ZLGuideDataPack *)transToGuideData:(NSArray *)chartDataArray guideParam:(ZLGuideParam *)guideParam {
    [self rsiCheckChartData:chartDataArray guideParam:guideParam];
    
    ZLRSIParam *rsiParam = (ZLRSIParam *)guideParam;
    ZLGuideDataPack *dataPack = [[ZLGuideDataPack alloc] initWithParams:guideParam];
    
    NSMutableArray *tArray  = [[NSMutableArray alloc] init];
    
    ZLGuideRSIModel *gModel = [[ZLGuideRSIModel alloc] init];
    gModel.isNeedDraw = NO;
    [tArray addObject:gModel];
    
    int longPeriod   = rsiParam.longPeriod;
    int shortPeriod  = rsiParam.shortPeriod;
    
    KLineModel *kModel = [chartDataArray objectAtIndex:0];
    double longUp = 0;
    double longDown = 0;
    double shortUp = 0;
    double shortDown = 0;
    double diff = 0;
    double ccPrice = kModel.close;
    double lcPrice = 0;
    for (int i = 1; i < chartDataArray.count; i++) {
        kModel = [chartDataArray objectAtIndex:i];
        lcPrice = ccPrice;
        ccPrice = kModel.close;
        
        diff = ccPrice - lcPrice;
        
        longUp = [self updateUpByOriValue:longUp period:longPeriod diff:diff];
        longDown = [self updateDownByOriValue:longDown period:longPeriod diff:diff];
        
        shortUp = [self updateUpByOriValue:shortUp period:shortPeriod diff:diff];
        shortDown = [self updateDownByOriValue:shortDown period:shortPeriod diff:diff];
        
        gModel = [[ZLGuideRSIModel alloc] init];
        gModel.longPeriod = longPeriod;
        gModel.longData = longUp / (longUp + longDown) * 100;
        gModel.shortPeriod = shortPeriod;
        gModel.shortData = shortUp / (shortUp + shortDown) * 100;
        gModel.isNeedDraw = YES;
        
        [tArray addObject:gModel];
    }
    
    dataPack.dataArray = [tArray copy];
    return dataPack;
}

- (double)updateUpByOriValue:(double)oriValue period:(double)period diff:(double)diff {
    if (diff > 0) {
        return (oriValue * (period - 1) + diff) / period;
    } else {
        return oriValue * (period - 1) / period;
    }
}

- (double)updateDownByOriValue:(double)oriValue period:(double)period diff:(double)diff {
    if (diff > 0) {
        return oriValue * (period - 1) / period;
    } else {
        return (oriValue * (period - 1) - diff) / period;
    }
}

#pragma mark - private
- (void)rsiCheckChartData:(NSArray *)chartDataArray guideParam:(ZLGuideParam *)guideParam {
    NSAssert(chartDataArray != nil, @"Invalid chart data array.");
    NSAssert(guideParam != nil, @"Invalid guideParam setting.");
    NSAssert([guideParam isKindOfClass:[ZLRSIParam class]], @"Ivalid rsi param.");
    NSAssert(((ZLRSIParam *)guideParam).longPeriod > 0, @"Invalid longPeriod setting.");
    NSAssert(((ZLRSIParam *)guideParam).shortPeriod > 0, @"Invalid shortPeriod setting.");
}


@end
