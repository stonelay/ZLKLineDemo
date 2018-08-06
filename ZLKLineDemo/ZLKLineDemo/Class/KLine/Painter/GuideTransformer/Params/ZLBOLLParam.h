//
//  ZLBOLLParam.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideParam.h"


//typedef NS_ENUM(int, ZLBOLLDataType) {
//    ZLMADataTypeUp          = 1,
//    ZLMADataTypeMid         = 2,
//    ZLMADataTypeLow         = 3,
//};

@interface ZLBOLLParam : ZLGuideParam

//@property (nonatomic, assign) ZLBOLLDataType bollDataType;

@property (nonatomic, assign) CGFloat period; // boll的周期， 一般是20
@property (nonatomic, assign) CGFloat k;        // boll的差值倍数， 一般是2

@property (nonatomic, strong) UIColor *upColor;
@property (nonatomic, strong) UIColor *midColor;
@property (nonatomic, strong) UIColor *lowColor;

@property (nonatomic, strong) UIColor *bandColor;

@end
