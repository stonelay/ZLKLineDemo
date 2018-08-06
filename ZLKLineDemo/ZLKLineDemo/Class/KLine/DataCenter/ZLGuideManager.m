//
//  ZLGuideManager.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/27.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideManager.h"

#import "ZLMATransformer.h"
#import "ZLBOLLTransformer.h"
#import "ZLKDJTransformer.h"
#import "ZLRSITransformer.h"

#import "ZLMAParam.h"
#import "ZLBOLLParam.h"
#import "ZLKDJParam.h"
#import "ZLRSIParam.h"

#import "ZLGuideMAModel.h"
#import "ZLGuideBOLLModel.h"
#import "ZLGuideKDJModel.h"
#import "ZLGuideRSIModel.h"

// boll
#define BOLLDefaultPeriod 20.0
#define BOLLDefaultK 2.0

#define BOLLDefaultUpColor      ZLHEXCOLOR(0x800080)
#define BOLLDefaultMidColor     ZLHEXCOLOR(0x8A2BE2)
#define BOLLDefaultLowColor     ZLHEXCOLOR(0x98FB98)
#define BOLLDefaultBandColor    ZLHEXCOLOR_a(0xCD5C5C, 0.1)

// ma
#define MA1DefaultPeriod 5.0
#define MA2DefaultPeriod 10.0
#define MA3DefaultPeriod 20.0
#define MA4DefaultPeriod 60.0
#define MA5DefaultPeriod 144.0

#define MA1DefaultColor         ZLHEXCOLOR(0xBA55D3)
#define MA2DefaultColor         ZLHEXCOLOR(0xF8F8FF)
#define MA3DefaultColor         ZLHEXCOLOR(0x00BFFF)
#define MA4DefaultColor         ZLHEXCOLOR(0x3CB371)
#define MA5DefaultColor         ZLHEXCOLOR(0xF0E68C)

// kdj
#define KDJDefaultNPeriod 9.0
#define KDJDefaultM1Period 3.0
#define KDJDefaultM2Period 3.0

#define KDJDefaultKColor        ZLHEXCOLOR(0x800080)
#define KDJDefaultDColor        ZLHEXCOLOR(0x9932CC)
#define KDJDefaultJColor        ZLHEXCOLOR(0x98FB98)

// rsi
#define RSIDefaultLPeriod 14.0
#define RSIDefaultSPeriod 7.0

#define RSIDefaultLColor        ZLHEXCOLOR(0x98FB98)
#define RSIDefaultSColor        ZLHEXCOLOR(0x800080)


@interface ZLGuideManager()

// ma
@property (nonatomic, strong) ZLMATransformer *maTransformer;
@property (nonatomic, strong) NSDictionary *maParamsDic; // <MAKey, params>
@property (nonatomic, strong) NSMutableDictionary *maGuideData; // <MAKey, datapack>

// boll
@property (nonatomic, strong) ZLBOLLTransformer *bollTransformer;
@property (nonatomic, strong) ZLBOLLParam *bollParam;
@property (nonatomic, strong) ZLGuideDataPack *bollDataPack;

// kdj
@property (nonatomic, strong) ZLKDJTransformer *kdjTransformer;
@property (nonatomic, strong) ZLKDJParam *kdjParam;
@property (nonatomic, strong) ZLGuideDataPack *kdjDataPack;

// rsi
@property (nonatomic, strong) ZLRSITransformer *rsiTransformer;
@property (nonatomic, strong) ZLRSIParam *rsiParam;
@property (nonatomic, strong) ZLGuideDataPack *rsiDataPack;


@end

@implementation ZLGuideManager
- (instancetype)init {
    if (self = [super init]) {
        [self initDefault];
    }
    return self;
}

- (void)initDefault {
    // 以后添加可设置？
}

#pragma mark - update
- (void)updateWithChartData:(NSArray *)chartData {
    [self updateMAChartData:chartData];
    [self updateBOLLChartData:chartData];
    [self updateKDJChartData:chartData];
    [self updateRSIChartData:chartData];
}

- (void)updateMAChartData:(NSArray *)chartData {
    for (NSString *key in [self.maParamsDic allKeys]) {
        ZLMAParam *maParam = [self.maParamsDic objectForKey:key];
        ZLGuideDataPack *pack = [self.maTransformer transToGuideData:chartData guideParam:maParam];
        [self.maGuideData setValue:pack forKey:key];
    }
}

- (void)updateBOLLChartData:(NSArray *)chartData {
    self.bollDataPack = [self.bollTransformer transToGuideData:chartData guideParam:self.bollParam];
}

- (void)updateKDJChartData:(NSArray *)chartData {
    self.kdjDataPack = [self.kdjTransformer transToGuideData:chartData guideParam:self.kdjParam];
}

- (void)updateRSIChartData:(NSArray *)chartData {
    self.rsiDataPack = [self.rsiTransformer transToGuideData:chartData guideParam:self.rsiParam];
}

#pragma mark - transformer
- (ZLMATransformer *)maTransformer {
    if (!_maTransformer) {
        _maTransformer = [[ZLMATransformer alloc] init];
    }
    return _maTransformer;
}

- (ZLBOLLTransformer *)bollTransformer {
    if (!_bollTransformer) {
        _bollTransformer = [[ZLBOLLTransformer alloc] init];
    }
    return _bollTransformer;
}

- (ZLKDJTransformer *)kdjTransformer {
    if (!_kdjTransformer) {
        _kdjTransformer = [[ZLKDJTransformer alloc] init];
    }
    return _kdjTransformer;
}

- (ZLRSITransformer *)rsiTransformer {
    if (!_rsiTransformer) {
        _rsiTransformer = [[ZLRSITransformer alloc] init];
    }
    return _rsiTransformer;
}

#pragma mark - default
- (NSDictionary *)maParamsDic {
    if (!_maParamsDic) {
        NSMutableDictionary *tDic = [[NSMutableDictionary alloc] init];
        [tDic setValue:[self getMAParamWithColor:MA1DefaultColor period:MA1DefaultPeriod maDataType:ZLMADataTypeSMA] forKey:PKey_MADataID_MA1];
        [tDic setValue:[self getMAParamWithColor:MA2DefaultColor period:MA2DefaultPeriod maDataType:ZLMADataTypeSMA] forKey:PKey_MADataID_MA2];
        [tDic setValue:[self getMAParamWithColor:MA3DefaultColor period:MA3DefaultPeriod maDataType:ZLMADataTypeSMA] forKey:PKey_MADataID_MA3];
        [tDic setValue:[self getMAParamWithColor:MA4DefaultColor period:MA4DefaultPeriod maDataType:ZLMADataTypeSMA] forKey:PKey_MADataID_MA4];
        [tDic setValue:[self getMAParamWithColor:MA5DefaultColor period:MA5DefaultPeriod maDataType:ZLMADataTypeSMA] forKey:PKey_MADataID_MA5];
        _maParamsDic = [tDic copy];
    }
    return _maParamsDic;
}

- (NSMutableDictionary *)maGuideData {
    if (!_maGuideData) {
        _maGuideData = [[NSMutableDictionary alloc] init];
    }
    return _maGuideData;
}

- (ZLBOLLParam *)bollParam {
    if (!_bollParam) {
        _bollParam = [[ZLBOLLParam alloc] init];
        _bollParam.period = 20.0; // default
        _bollParam.k = 2.0;
        _bollParam.upColor = BOLLDefaultUpColor;
        _bollParam.midColor = BOLLDefaultMidColor;
        _bollParam.lowColor = BOLLDefaultLowColor;
        _bollParam.bandColor = BOLLDefaultBandColor;
    }
    return _bollParam;
}

- (ZLKDJParam *)kdjParam {
    if (!_kdjParam) {
        _kdjParam = [[ZLKDJParam alloc] init];
        _kdjParam.kdjPeriod_N = KDJDefaultNPeriod;
        _kdjParam.kdjPeriod_M1 = KDJDefaultM1Period;
        _kdjParam.kdjPeriod_M2 = KDJDefaultM2Period;
        _kdjParam.kColor = KDJDefaultKColor;
        _kdjParam.dColor = KDJDefaultDColor;
        _kdjParam.jColor = KDJDefaultJColor;
    }
    return _kdjParam;
}

- (ZLRSIParam *)rsiParam {
    if (!_rsiParam) {
        _rsiParam = [[ZLRSIParam alloc] init];
        _rsiParam.longPeriod = RSIDefaultLPeriod;
        _rsiParam.shortPeriod = RSIDefaultSPeriod;
        _rsiParam.longColor = RSIDefaultLColor;
        _rsiParam.shortColor = RSIDefaultSColor;
    }
    return _rsiParam;
}

#pragma mark - maker
- (ZLMAParam *)getMAParamWithColor:(UIColor *)color period:(CGFloat)period maDataType:(ZLMADataType)dataType {
    ZLMAParam *param = [[ZLMAParam alloc] init];
    param.maDataType = ZLMADataTypeSMA;
    param.period = period;
    param.maColor = color;
    return param;
}

#pragma mark - public
- (ZLGuideDataPack *)getMADataPackByKey:(NSString *)dataKey {
    return [self.maGuideData objectForKey:dataKey];
}

- (ZLGuideDataPack *)getBOLLDataPack {
    return self.bollDataPack;
}

- (ZLGuideDataPack *)getKDJDataPack {
    return self.kdjDataPack;
}

- (ZLGuideDataPack *)getRSIDataPack {
    return self.rsiDataPack;
}

- (SMaximum *)getMAMaximunWithRange:(NSRange)range {
    CGFloat min = INT32_MAX;
    CGFloat max = 0;
    for (NSString *key in [self.maGuideData allKeys]) {
        ZLGuideDataPack *dataPack = [self.maGuideData objectForKey:key];
        NSArray *dataArray = [dataPack.dataArray subarrayWithRange:range];
        for (ZLGuideMAModel *model in dataArray) {
            if (model.isNeedDraw) {
                min = MIN(min, model.data);
                max = MAX(max, model.data);
            }
        }
    }
    return [SMaximum initWithMax:max min:min];
}

- (SMaximum *)getBOLLMaximunWithRange:(NSRange)range {
    CGFloat min = INT32_MAX;
    CGFloat max = 0;
    
    NSArray *dataArray = [self.bollDataPack.dataArray subarrayWithRange:range];
    for (ZLGuideBOLLModel *model in dataArray) {
        if (model.isNeedDraw) {
            min = MIN(min, model.lowData);
            max = MAX(max, model.upData);
        }
    }
    return [SMaximum initWithMax:max min:min];
}

- (SMaximum *)getKDJMaximunWithRange:(NSRange)range {
//    CGFloat min = INT32_MAX;
//    CGFloat max = 0;
    
    CGFloat min = 0.0;
    CGFloat max = 80.0;
    
    NSArray *dataArray = [self.kdjDataPack.dataArray subarrayWithRange:range];
    for (ZLGuideKDJModel *model in dataArray) {
        min = MIN(min, model.minData);
        max = MAX(max, model.maxData);
    }
    return [SMaximum initWithMax:max min:min];
}

- (SMaximum *)getRSIMaximunWithRange:(NSRange)range {
    //    CGFloat min = INT32_MAX;
    //    CGFloat max = 0;
    
    CGFloat min = 0.0;
    CGFloat max = 80.0;
    
    NSArray *dataArray = [self.kdjDataPack.dataArray subarrayWithRange:range];
    for (ZLGuideKDJModel *model in dataArray) {
        min = MIN(min, model.minData);
        max = MAX(max, model.maxData);
    }
    return [SMaximum initWithMax:max min:min];
}

@end

@implementation SMaximum

+ (instancetype)initWithMax:(CGFloat)max min:(CGFloat)min {
    SMaximum *model = [[SMaximum alloc] init];
    model.max = max;
    model.min = min;
    return model;
}

@end
