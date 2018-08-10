//
//  ZLGuideDataType.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/31.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

//static NSString *const kGUIDE_MODEL_ID_BOLL  = @"BOLL_DATA";
//static NSString *const kGUIDE_MODEL_ID_KDJ   = @"KDJ_DATA";
//
static NSString *const kGUIDE_ID_NONE   = @"NONE";
static NSString *const kGUIDE_ID_MA     = @"MA";
static NSString *const kGUIDE_ID_BOLL   = @"BOLL";
static NSString *const kGUIDE_ID_RSI    = @"RSI";
static NSString *const kGUIDE_ID_KDJ    = @"KDJ";
static NSString *const kGUIDE_ID_MACD   = @"MACD";
//
//typedef NS_ENUM(int, ZLGuideDataName) {
//    ZLMADataName      = 0,
//    ZLMADataName_SMA     ,
//    ZLMADataName_EMA     ,
//    ZLMADataName_WMA     ,
//    
//    ZLBOLLDataName       ,
//    ZLBOLLDataName_UP    ,
//    ZLBOLLDataName_MID   ,
//    ZLBOLLDataName_LOW   ,
//    
//    ZLKDJDataName        ,
//    ZLKDJDataName_KLine  ,
//    ZLKDJDataName_DLine  ,
//    ZLKDJDataName_JLine  ,
//    //
//    //    ZLMACDDataName       ,
//    //    ZLMACDDataName_DIF   ,
//    //    ZLMACDDataName_DEA   ,
//    //    ZLMACDDataName_MACD  ,
//    //
//    //    ZLRSIDataName        ,
//    //    ZLRSIDataName_Long   ,
//    //    ZLRSIDataName_Short  ,
//};


typedef NS_ENUM(NSInteger, GuidePaintType) {
    GuidePaintTypeMain   = 1, // 主要的 ma，boll 等
    GuidePaintTypeAssist = 2  // 辅助 kdj、等
};

typedef NS_OPTIONS(NSInteger, ZLPainterOp) {
    ZLPainterOpNone                        = 0,
    ZLPainterOpCandle                      = 1, // 只能选一个
    ZLPainterOpBar                         = 2,
};

typedef NS_OPTIONS(NSInteger, GuidePaintMainType) {
    GuidePaintMainTypeNone   = 0,
    GuidePaintMainTypeMA     = 1 << 0,
    GuidePaintMainTypeBOLL   = 1 << 1,
    
    GuidePaintMainTypeALL    = 1 << 2,
};

typedef NS_OPTIONS(NSInteger, GuidePaintAssistType) {
    GuidePaintAssistTypeNone    = 0,
    GuidePaintAssistTypeKDJ     = 1 << 0,
    GuidePaintAssistTypeRSI     = 1 << 1,
    
    GuidePaintAssistTypeALL     = 1 << 2,
    //
};

@interface ZLGuideDataType : NSObject

+ (NSString *)getNameByPaintMainType:(GuidePaintMainType)mainType;
+ (NSString *)getNameByPaintAssistType:(GuidePaintAssistType)assistType;

+ (GuidePaintAssistType)getNextAssistType:(GuidePaintAssistType)assistType;
+ (GuidePaintMainType)getNextMainType:(GuidePaintMainType)mainType;

@end
