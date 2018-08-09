//
//  DecimalUtil.h
//  XYKGuanjia
//
//  Created by LayZhang on 2018/1/26.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DecimalUtil : NSObject


+ (NSString *)formatDoubleParam:(double) value digit:(int) digit;

+ (NSString *)formatTimeParam:(long long)time;

+ (NSString *)formatDoubleByNoStyle:(double) value digit:(int) digit;

+ (NSString *)formatMoney:(double)money digist:(int)digist;

+ (NSString *)formatNumber:(double)price;

+ (NSString *)formatZeroMoney:(double)money digist:(int)digist;

+ (NSString *)formatPercent:(double)percent withDigist:(int)digist;

@end
