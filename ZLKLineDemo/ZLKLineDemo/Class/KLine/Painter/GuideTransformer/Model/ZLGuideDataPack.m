//
//  ZLGuideDataPack.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideDataPack.h"

#import "ZLGuideModel.h"

@implementation ZLGuideDataPack

- (instancetype)initWithParams:(ZLGuideParam *)param {
    if (self = [super init]) {
        self.param = param;
    }
    return self;
}

- (SMaximum *)getMaximumByRange:(NSRange)range {
    CGFloat min = INT32_MAX;
    CGFloat max = 0;
    
    NSArray *dataArray = [self.dataArray subarrayWithRange:range];
    for (ZLGuideModel *model in dataArray) {
        if (!model.isNeedDraw) continue;
        min = MIN(min, model.minData);
        max = MAX(max, model.maxData);
    }
    return [SMaximum initWithMax:max min:min];
}

@end

@implementation SMaximum

+ (instancetype)maximunDefault {
    return [SMaximum initWithMax:0 min:INT32_MAX];
}

+ (instancetype)initWithMax:(CGFloat)max min:(CGFloat)min {
    SMaximum *model = [[SMaximum alloc] init];
    model.max = max;
    model.min = min;
    return model;
}

- (SMaximum *)fixMaximum:(SMaximum *)maximum {
    return [SMaximum initWithMax:MAX(self.max, maximum.max) min:MIN(self.min, maximum.min)];
}


@end
