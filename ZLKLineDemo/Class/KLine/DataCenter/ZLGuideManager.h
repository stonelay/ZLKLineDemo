//
//  ZLGuideManager.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/27.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZLGuideDataPack.h"

@interface ZLGuideManager : NSObject

- (void)updateWithChartData:(NSArray *)chartData;

- (ZLGuideDataPack *)getDataPackByGuideKey:(NSString *)guideKey;
- (ZLGuideDataPack *)getDataPackByGuideKey:(NSString *)guideKey dataKey:(NSString *)dataKey;

- (SMaximum *)getMaximumByGuideKey:(NSString *)guideKey range:(NSRange)range;

@end
