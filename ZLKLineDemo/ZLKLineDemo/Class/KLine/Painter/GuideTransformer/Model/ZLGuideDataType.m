//
//  ZLGuideDataType.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/31.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideDataType.h"

@implementation ZLGuideDataType

+ (NSString *)getNameByPaintMainType:(GuidePaintMainType)mainType {
    switch (mainType) {
        case GuidePaintMainTypeMA:
            return kGUIDE_ID_MA;
            break;
        case GuidePaintMainTypeBOLL:
            return kGUIDE_ID_BOLL;
            break;
        default:
            break;
    }
    return kGUIDE_ID_NONE;
}

+ (NSString *)getNameByPaintAssistType:(GuidePaintAssistType)assistType {
    switch (assistType) {
        case GuidePaintAssistTypeKDJ:
            return kGUIDE_ID_KDJ;
            break;
        case GuidePaintAssistTypeRSI:
            return kGUIDE_ID_RSI;
            break;
            
        default:
            break;
    }
    return kGUIDE_ID_NONE;
}

+ (GuidePaintAssistType)getNextAssistType:(GuidePaintAssistType)assistType {
    // TODO update
    switch (assistType) {
        case GuidePaintAssistTypeKDJ:
            return GuidePaintAssistTypeRSI;
            break;
        case GuidePaintAssistTypeRSI:
            return GuidePaintAssistTypeKDJ;
            break;
        default:
            break;
    }
    return assistType;
}

+ (GuidePaintMainType)getNextMainType:(GuidePaintMainType)mainType {
    // TODO update
    switch (mainType) {
        case GuidePaintMainTypeNone:
            return GuidePaintMainTypeMA;
            break;
        case GuidePaintMainTypeMA:
            return GuidePaintMainTypeBOLL;
            break;
        case GuidePaintMainTypeBOLL:
            return GuidePaintMainTypeNone;
            break;
       
        default:
            break;
    }
    return mainType;
}
@end
