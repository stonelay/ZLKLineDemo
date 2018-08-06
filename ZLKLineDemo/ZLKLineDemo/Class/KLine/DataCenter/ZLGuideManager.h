//
//  ZLGuideManager.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/27.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZLGuideDataPack.h"

@interface SMaximum : NSObject

+ (instancetype)initWithMax:(CGFloat)max min:(CGFloat)min;

@property (nonatomic, assign) CGFloat max;
@property (nonatomic, assign) CGFloat min;

@end

@interface ZLGuideManager : NSObject

- (void)updateWithChartData:(NSArray *)chartData;

- (ZLGuideDataPack *)getMADataPackByKey:(NSString *)dataKey;
- (ZLGuideDataPack *)getBOLLDataPack;
- (ZLGuideDataPack *)getKDJDataPack;
- (ZLGuideDataPack *)getRSIDataPack;

- (SMaximum *)getMAMaximunWithRange:(NSRange)range;
- (SMaximum *)getBOLLMaximunWithRange:(NSRange)range;
- (SMaximum *)getKDJMaximunWithRange:(NSRange)range;
- (SMaximum *)getRSIMaximunWithRange:(NSRange)range;

@end
