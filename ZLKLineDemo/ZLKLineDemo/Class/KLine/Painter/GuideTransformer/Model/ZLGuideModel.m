////
////  ZLGuideModel.m
////  OpenGLDemo
////
////  Created by LayZhang on 2018/7/30.
////  Copyright © 2018年 Zhanglei. All rights reserved.
////
//
//#import "ZLGuideModel.h"
//
//@implementation ZLGuideModel
//
//- (instancetype)init {
//    if (self = [super init]) {
//        [self initDefault];
//    }
//    return self;
//}
//
//- (instancetype)initWithId:(NSString *)gid {
//    if (self = [super init]) {
//        [self initDefault];
//        self.gid = gid;
//    }
//    return self;
//}
//
//- (void)initDefault {
//    self.gid = @"";
//    self.dataTime = nil;
//    self.data = 0.0;
//    self.cycle = 0;
//    self.needDraw = YES;
//}
//
//- (NSString *)name {
//    return [NSString stringWithFormat:@"%@ %ld", self.gid, (long)self.cycle];
//}
//
////- (CGFloat)getDataWithDataName:(ZLGuideDataName)dataName {
////    switch (dataName) {
////            // ma
////        case ZLMADataName_SMA:
////            return self.data;
////            break;
////        case ZLMADataName_EMA:
////            return self.data;
////            break;
////        case ZLMADataName_WMA:
////            return self.data;
////            break;
////
////            // boll
////        case ZLBOLLDataName_UP:
////            return self.upData;
////            break;
////        case ZLBOLLDataName_MID:
////            return self.data;
////            break;
////        case ZLBOLLDataName_LOW:
////            return self.lowData;
////            break;
////
////        default:
////            break;
////    }
////    return 0.0;
////}
//
//@end
