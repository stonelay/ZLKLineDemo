//
//  ZLMATransformer.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLMATransformer.h"

#import "ZLMAParam.h"
#import "KLineModel.h"
#import "ZLGuideMAModel.h"

NSString * const MA_Type_SMA  = @"SMA"; // 简单移动平均线
NSString * const MA_Type_EMA  = @"EMA"; // 加权移动平均线
NSString * const MA_Type_WMA  = @"WMA"; // 指数平滑移动平均线

@implementation ZLMATransformer

#pragma mark - override
- (NSString *)guideID {
    return kGUIDE_ID_MA;
}

- (ZLGuideDataPack *)transToGuideData:(NSArray *)chartDataArray guideParam:(ZLGuideParam *)guideParam {
    if (![guideParam isKindOfClass:[ZLMAParam class]]) {
        NSAssert(NO, @"Invalid ma guideParam class.");
        return nil;
    }
    ZLMAParam *maParam = (ZLMAParam *)guideParam;
    
    ZLGuideDataPack *dataPack = [[ZLGuideDataPack alloc] initWithParams:guideParam];
    NSArray *guideArray = [self transToGuideData:chartDataArray period:maParam.period type:maParam.maDataType];
    dataPack.dataArray = guideArray;
    
    return dataPack;
}

#pragma mark - private
- (NSArray *)transToGuideData:(NSArray *)chartDataArray period:(NSInteger)period type:(ZLMADataType)maDataType {
    switch (maDataType) {
        case ZLMADataTypeSMA:
            return [self transToSMAGuideData:chartDataArray period:period];
            break;
        case ZLMADataTypeEMA:
            return [self transToEMAGuideData:chartDataArray period:period];
            break;
        case ZLMADataTypeWMA:
            return [self transToWMAGuideData:chartDataArray period:period];
            break;
        default:
            break;
    }
    return nil;
}

- (NSArray *)transToSMAGuideData:(NSArray *)chartDataArray period:(NSInteger)period {
    [self maCheckChartData:chartDataArray period:period];
    
    NSMutableArray *tArray = [[NSMutableArray alloc] init];
    double ma = 0.0;
    
    for(int i = 0;i < chartDataArray.count;i++) {
        if (i < period - 1) {
            ZLGuideMAModel *model = [[ZLGuideMAModel alloc] init];
            model.period = period;
            model.data = 0;
            model.isNeedDraw = NO;
            
            KLineModel *pModel = [chartDataArray objectAtIndex:i];
            ma += pModel.close;
            [tArray addObject:model];
            continue;
        }
        
        if (i == period - 1) {
            KLineModel *pModel = [chartDataArray objectAtIndex:i];
            ma += pModel.close;
            
            ZLGuideMAModel *model = [[ZLGuideMAModel alloc] init];
            model.period = period;
            model.data = ma / (double)period;
            [tArray addObject:model];
            continue;
        }
        
        KLineModel *nModel = [chartDataArray objectAtIndex:i];
        KLineModel *oModel = [chartDataArray objectAtIndex:i - period];
        ma = ma - oModel.close + nModel.close;
        
        ZLGuideMAModel *model = [[ZLGuideMAModel alloc] init];
        model.period = period;
        model.data = ma / (double)period;
        model.isNeedDraw = YES;
        
        [tArray addObject:model];
    }
    
    return tArray;
}

- (NSArray *)transToEMAGuideData:(NSArray *)chartDataArray period:(NSInteger)period {
    [self maCheckChartData:chartDataArray period:period];
    
    // TODO EMA
    NSMutableArray * rltArray = [[NSMutableArray alloc] init];
    
    return rltArray;
}

- (NSArray *)transToWMAGuideData:(NSArray *)chartDataArray period:(NSInteger)period {
    [self maCheckChartData:chartDataArray period:period];
    
    // TODO WMA
    NSMutableArray * rltArray = [[NSMutableArray alloc] init];
    
    return rltArray;
}

- (void)maCheckChartData:(NSArray *)chartDataArray period:(NSInteger)period {
    NSAssert(chartDataArray != nil, @"Invalid chart data array.");
    NSAssert(period > 0, @"Invalid period setting.");
    NSAssert(period <= chartDataArray.count, @"Invalid chartDataArray.count period.");
}
@end
