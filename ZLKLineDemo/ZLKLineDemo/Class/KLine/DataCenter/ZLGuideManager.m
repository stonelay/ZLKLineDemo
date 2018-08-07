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

#import "ZLGuideDataType.h"


@interface ZLGuideManager()

// transformer
@property (nonatomic, strong) NSDictionary *transformerDic; // <GuideKey, transformer>
// param
@property (nonatomic, strong) NSDictionary *guideParamDic; // <GuideKay, guideParam>
@property (nonatomic, strong) NSDictionary *maParamsDic; // <MAKey, params>
// dataPack
@property (nonatomic, strong) NSMutableDictionary *dataPackDic; // <GuideKay, dataPack>
@property (nonatomic, strong) NSMutableDictionary *maGuideDataPack; // <MAKey, datapack>

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
    for (GuidePaintMainType i = GuidePaintMainTypeMA; i < GuidePaintMainTypeALL; i <<= 1) {
        NSString *guideID = [ZLGuideDataType getNameByPaintMainType:i];
        [self updateChartData:chartData withGuideID:guideID];
    }
    for (GuidePaintAssistType i = GuidePaintAssistTypeKDJ; i < GuidePaintAssistTypeALL; i <<= 1) {
        NSString *guideID = [ZLGuideDataType getNameByPaintAssistType:i];
        [self updateChartData:chartData withGuideID:guideID];
    }
}

- (void)updateChartData:(NSArray *)chartData withGuideID:(NSString *)guideID {
    if ([guideID isEqualToString:kGUIDE_ID_MA]) {
        [self updateMAChartData:chartData];
    } else {
        ZLDataTransformer *transformer = [self.transformerDic objectForKey:guideID];
        ZLGuideParam *guideParam = [self.guideParamDic objectForKey:guideID];
        ZLGuideDataPack *dataPack = [transformer transToGuideData:chartData guideParam:guideParam];
        [self.dataPackDic setObject:dataPack forKey:guideID];
    }
}

- (void)updateMAChartData:(NSArray *)chartData {
    for (NSString *key in [self.maParamsDic allKeys]) {
        ZLMAParam *maParam = [self.maParamsDic objectForKey:key];
        ZLDataTransformer *transformer = [self.transformerDic objectForKey:kGUIDE_ID_MA];
        ZLGuideDataPack *pack = [transformer transToGuideData:chartData guideParam:maParam];
        [self.maGuideDataPack setObject:pack forKey:key];
    }
}

#pragma mark - transformer
- (NSDictionary *)transformerDic {
    if (!_transformerDic) {
        NSMutableDictionary *tDic = [[NSMutableDictionary alloc] init];
        for (GuidePaintMainType i = GuidePaintMainTypeMA; i < GuidePaintMainTypeALL; i <<= 1) {
            NSString *guideID = [ZLGuideDataType getNameByPaintMainType:i];
            ZLDataTransformer *transformer = [ZLDataTransformer getTransformerWithGuideID:guideID];
            [tDic setObject:transformer forKey:guideID];
        }
        for (GuidePaintAssistType i = GuidePaintAssistTypeKDJ; i < GuidePaintAssistTypeALL; i <<= 1) {
            NSString *guideID = [ZLGuideDataType getNameByPaintAssistType:i];
            ZLDataTransformer *transformer = [ZLDataTransformer getTransformerWithGuideID:guideID];
            [tDic setObject:transformer forKey:guideID];
        }
        _transformerDic = [tDic copy];
    }
    return _transformerDic;
}

#pragma mark - default
- (NSDictionary *)maParamsDic {
    if (!_maParamsDic) {
        NSMutableDictionary *tDic = [[NSMutableDictionary alloc] init];
        [tDic setObject:[ZLMAParam initWithMADataKey:PKey_MADataID_MA1] forKey:PKey_MADataID_MA1];
        [tDic setObject:[ZLMAParam initWithMADataKey:PKey_MADataID_MA2] forKey:PKey_MADataID_MA2];
        [tDic setObject:[ZLMAParam initWithMADataKey:PKey_MADataID_MA3] forKey:PKey_MADataID_MA3];
        [tDic setObject:[ZLMAParam initWithMADataKey:PKey_MADataID_MA4] forKey:PKey_MADataID_MA4];
        [tDic setObject:[ZLMAParam initWithMADataKey:PKey_MADataID_MA5] forKey:PKey_MADataID_MA5];
        _maParamsDic = [tDic copy];
    }
    return _maParamsDic;
}

- (NSMutableDictionary *)maGuideDataPack {
    if (!_maGuideDataPack) {
        _maGuideDataPack = [[NSMutableDictionary alloc] init];
    }
    return _maGuideDataPack;
    
}

- (NSDictionary *)guideParamDic {
    if (!_guideParamDic) {
        NSMutableDictionary *tDic = [[NSMutableDictionary alloc] init];
        for (GuidePaintMainType i = GuidePaintMainTypeBOLL; i < GuidePaintMainTypeALL; i <<= 1) {
            NSString *guideID = [ZLGuideDataType getNameByPaintMainType:i];
            ZLGuideParam *guideParam = [ZLGuideParam getDefaultParamByGuideID:guideID];
            [tDic setObject:guideParam forKey:guideID];
        }
        for (GuidePaintAssistType i = GuidePaintAssistTypeKDJ; i < GuidePaintAssistTypeALL; i <<= 1) {
            NSString *guideID = [ZLGuideDataType getNameByPaintAssistType:i];
            ZLGuideParam *guideParam = [ZLGuideParam getDefaultParamByGuideID:guideID];
            [tDic setObject:guideParam forKey:guideID];
        }
        _guideParamDic = [tDic copy];
    }
    return _guideParamDic;
}

- (NSMutableDictionary *)dataPackDic {
    if (!_dataPackDic) {
        _dataPackDic = [[NSMutableDictionary alloc] init];
    }
    return _dataPackDic;
}

#pragma mark - public
- (ZLGuideDataPack *)getDataPackByGuideKey:(NSString *)guideKey {
    if ([guideKey isEqualToString:kGUIDE_ID_MA]) {
        return [self getDataPackByGuideKey:guideKey dataKey:PKey_MADataID_MA1];
    }
    return [self getDataPackByGuideKey:guideKey dataKey:nil];
}

- (ZLGuideDataPack *)getDataPackByGuideKey:(NSString *)guideKey dataKey:(NSString *)dataKey {
    ZLGuideDataPack *dataPack;
    if ([guideKey isEqualToString:kGUIDE_ID_MA]) {
        dataPack = [self.maGuideDataPack objectForKey:dataKey];
    } else {
        dataPack = [self.dataPackDic objectForKey:guideKey];
    }
    NSAssert(dataPack, @"Invalid data pack");
    return dataPack;
}

- (SMaximum *)getMaximumByGuideKey:(NSString *)guideKey range:(NSRange)range {
    if ([guideKey isEqualToString:kGUIDE_ID_MA]) {
        SMaximum *maximum = [SMaximum maximunDefault];
        for (ZLGuideDataPack *dataPack in self.maGuideDataPack.allValues) {
            maximum = [maximum fixMaximum:[dataPack getMaximumByRange:range]];
        }
        return maximum;
    } else {
        ZLGuideDataPack *dataPack = [self.dataPackDic objectForKey:guideKey];
        return [dataPack getMaximumByRange:range];
    }
}

@end


