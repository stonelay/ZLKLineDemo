//
//  ZLKDJTransformer.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/2.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLKDJTransformer.h"

#import "ZLKDJParam.h"
#import "KLineModel.h"

#import "ZLGuideKDJModel.h"

@implementation ZLKDJTransformer

- (NSString *)guideID {
    return kGUIDE_ID_KDJ;
}

- (ZLGuideDataPack *)transToGuideData:(NSArray *)chartDataArray guideParam:(ZLGuideParam *)guideParam {
    [self kdjCheckChartData:chartDataArray guideParam:guideParam];
    
    ZLKDJParam *kdjParam = (ZLKDJParam *)guideParam;
    ZLGuideDataPack *dataPack = [[ZLGuideDataPack alloc] initWithParams:guideParam];
    
    NSMutableArray *tArray  = [[NSMutableArray alloc] init];
    
    int n   = kdjParam.kdjPeriod_N;
    int m1  = kdjParam.kdjPeriod_M1;
    int m2  = kdjParam.kdjPeriod_M2;
    
    double rsv = 0.0;
    double k = 50.0;
    double d = 50.0;
    double j = 0.0;
    for (int i = 0; i < chartDataArray.count; i++) {
        KLineModel *cModel = [chartDataArray objectAtIndex:i];
        int sIndex = MAX(i, i - (n - 1));
        int eIndex = i;
        
        double min = INT32_MAX;
        double max = INT32_MIN;
        
        for(int j = sIndex; j <= eIndex; j++) {
            KLineModel *tModel = [chartDataArray objectAtIndex:j];
            min = MIN(min, tModel.low);
            max = MAX(max, tModel.high);
        }
        
        rsv = ((cModel.close - min) / (max - min)) * 100.0;
        k = (1 * rsv + (m1 - 1) * k) / m1;
        d = (1 * k + (m2 - 1) * d) / m2;
        j = 3 * k - 2 * d;
        
        ZLGuideKDJModel *gModel = [[ZLGuideKDJModel alloc] init];
        gModel.kData = k;
        gModel.dData = d;
        gModel.jData = j;
        [tArray addObject:gModel];
    }
    
    dataPack.dataArray = [tArray copy];
    return dataPack;
}

#pragma mark - private
- (void)kdjCheckChartData:(NSArray *)chartDataArray guideParam:(ZLGuideParam *)guideParam {
    NSAssert(chartDataArray != nil, @"Invalid chart data array.");
    NSAssert(guideParam != nil, @"Invalid guideParam setting.");
    NSAssert([guideParam isKindOfClass:[ZLKDJParam class]], @"Ivalid kdj param.");
    NSAssert(((ZLKDJParam *)guideParam).kdjPeriod_N > 0, @"Invalid kdjPeriod_N setting.");
    NSAssert(((ZLKDJParam *)guideParam).kdjPeriod_M1 > 0, @"Invalid kdjPeriod_M1 setting.");
    NSAssert(((ZLKDJParam *)guideParam).kdjPeriod_M2 > 0, @"Invalid kdjPeriod_M2 setting.");
}


@end
