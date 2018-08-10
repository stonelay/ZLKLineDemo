//
//  ZLBOLLTransformer.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLBOLLTransformer.h"

#import "ZLBOLLParam.h"
#import "KLineModel.h"
#import "ZLGuideBOLLModel.h"

@implementation ZLBOLLTransformer

- (void)initDefault {
    [super initDefault];
    self.transfirmerName = kGUIDE_ID_BOLL;
}

- (ZLGuideDataPack *)transToGuideData:(NSArray *)chartDataArray guideParam:(ZLGuideParam *)guideParam {
    [self bollCheckChartData:chartDataArray guideParam:guideParam];
    
    ZLBOLLParam *bollParam = (ZLBOLLParam *)guideParam;
    ZLGuideDataPack *dataPack = [[ZLGuideDataPack alloc] initWithParams:guideParam];
    
    NSMutableArray *tArray  = [[NSMutableArray alloc] init];
    
    int period = bollParam.period;
    CGFloat k = bollParam.k;
    
    for (int i = 0; i < chartDataArray.count; i++) {
        if (i < period - 1) {
            ZLGuideBOLLModel *gModel = [[ZLGuideBOLLModel alloc] init];
            gModel.period = period;
            gModel.midData = 0;
            gModel.upData = 0;
            gModel.lowData = 0;
            gModel.isNeedDraw = NO;
            [tArray addObject:gModel];
            continue;
        }
        
        CGFloat mid = 0;
        CGFloat dif = 0;
        CGFloat sum = 0;
        
        for (int j = i - (period - 1); j <= i; j++) {
            KLineModel *pModel = [chartDataArray objectAtIndex:j];
            mid += pModel.close;
        }
        mid /= (double)period;
        
        for (int j = i - (period - 1); j <= i; j++) {
            KLineModel *pModel = [chartDataArray objectAtIndex:j];
            sum += pow(pModel.close - mid, 2.0);
        }
        dif = (k * sqrt(sum / (double)period));
        
        ZLGuideBOLLModel *gModel = [[ZLGuideBOLLModel alloc] init];
        gModel.period = period;
        gModel.midData = mid;
        gModel.upData = mid + dif;
        gModel.lowData = mid - dif;
        gModel.isNeedDraw = YES;
        [tArray addObject:gModel];
    }
    
    dataPack.dataArray = [tArray copy];
    return dataPack;
}

#pragma mark - private
- (void)bollCheckChartData:(NSArray *)chartDataArray guideParam:(ZLGuideParam *)guideParam {
    NSAssert(chartDataArray != nil, @"Invalid chart data array.");
    NSAssert(guideParam != nil, @"Invalid guideParam setting.");
    NSAssert([guideParam isKindOfClass:[ZLBOLLParam class]], @"Ivalid boll param.");
    NSAssert(((ZLBOLLParam *)guideParam).period > 0, @"Invalid period setting.");
}

@end
