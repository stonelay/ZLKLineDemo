//
//  ZLGuideDataPack.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZLGuideParam.h"

@interface SMaximum : NSObject

+ (instancetype)maximunDefault;
+ (instancetype)initWithMax:(CGFloat)max min:(CGFloat)min;

@property (nonatomic, assign) CGFloat max;
@property (nonatomic, assign) CGFloat min;

// 取最高和最低
- (SMaximum *)fixMaximum:(SMaximum *)maximum;

@end

@interface ZLGuideDataPack : NSObject

- (instancetype)initWithParams:(ZLGuideParam *)param;

@property (nonatomic, strong) ZLGuideParam *param;
@property (nonatomic, strong) NSArray *dataArray;

- (SMaximum *)getMaximumByRange:(NSRange)range;


@end
