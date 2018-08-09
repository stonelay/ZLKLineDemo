//
//  DateFormat.h
//  Caifuguanjia
//
//  Created by LayZhang on 2018/3/1.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, JEDIWeekDays)
{
    JEDIWeekSunday          = 0,
    JEDIWeekMonday          = 1,
    JEDIWeekTuesday         = 2,
    JEDIWeekWednesday       = 3,
    JEDIWeekThursday        = 4,
    JEDIWeekFriday          = 5,
    JEDIWeekSaturday        = 6,
};


@interface DateFormat : NSObject

//
// 获取当前时间，单位：毫秒
//
+ (long long)       currentMillis;      // 毫秒 -- long long
+ (NSNumber *)      currentTimeMillis;  // 毫秒 -- long long
//
// 获取当前时间，单位：秒
//
+ (NSTimeInterval)  currentTimeIntervalSince1970;

//
// 获取时间，单位：毫秒
//
+ (long long)       getTimeMillisForDate:(NSDate *) date;
+ (NSNumber *)      getTimeMillisNumberForDate:(NSDate *) date;

//
// 获取日期字符串
//
+ (NSString *)      stringFromDate:(NSDate *) date;// "yyyyMMddHHmmssSSS"
+ (NSString *)      stringUIFromDate:(NSDate *) date;
+ (NSString *)      stringHHmmFromDate:(NSDate *)date;//@"yyyy-MM-dd HH:mm"
+ (NSString *)      stringUIFromTime:(NSDate *)date;
+ (NSString *)      stringUIFromyMd:(NSDate *)date;
+ (NSString *)      stringFromDate:(NSDate *) date withFormat:(NSString *) format;

//
// 获取时间字符串
//
+ (NSString *)      timeStringFromDate:(NSDate *) date; // "HH:mm:ss"

//
// 将毫秒转换成日期
//
+ (NSDate *)        dateFromMillis:(long long) ms;

//
// 从字符串获取日期
//
+ (NSDate *)        dateFromString:(NSString *) str;
+ (NSDate *)        dateFromString:(NSString *) str withFormat:(NSString *) format;
+ (NSDate *)        dateFromQuoteDay:(NSString *)quoteDay;

+ (NSDate *)        dateFromStringDay:(NSString *)quoteDay;

//
// 获取date所在月的第一天/最后一天
//
+ (NSDate *)        firstDayOfMonthForDate:(NSDate *) date;
+ (NSDate *)        lastDayOfMonthForDate:(NSDate *) date;

//
// 获取date所在周的指定一天
//
+ (NSDate *)        dayOfWeek:(JEDIWeekDays) weekDay forDate:(NSDate *) date;


//--------------------------------------------------------------------------------------
//
// 测试代码
//

+ (NSString *) getCertificateTimeString:(long long)time;

//根据日期获取星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

+ (NSString *)interceptTimeStampFromStr:(NSString *)str;

+ (NSString *)interceptTimeDetailFromStr:(NSString *)str;

+ (NSString *)getCurrentYD;
+ (NSString *)getTimeStamp;



@end
