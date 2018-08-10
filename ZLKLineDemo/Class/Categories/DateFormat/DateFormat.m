//
//  DateFormat.m
//  Caifuguanjia
//
//  Created by LayZhang on 2018/3/1.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "DateFormat.h"

@implementation DateFormat

//------------------------------------------------------------------------------
+ (long long)       currentMillis
{
    NSTimeInterval nsTime = [[NSDate date] timeIntervalSince1970];
    return (long long)(nsTime * 1000.0);
}

//------------------------------------------------------------------------------
+ (NSNumber *)      currentTimeMillis
{
    return [NSNumber numberWithLongLong:[DateFormat currentMillis]];
}

//------------------------------------------------------------------------------
+ (NSTimeInterval)  currentTimeIntervalSince1970
{
    return [[NSDate date] timeIntervalSince1970];
}

//------------------------------------------------------------------------------
+ (long long)       getTimeMillisForDate:(NSDate *) date
{
    NSTimeInterval nsTime = [date timeIntervalSince1970];
    return (long long)(nsTime * 1000.0);
}

//------------------------------------------------------------------------------
+ (NSNumber *)      getTimeMillisNumberForDate:(NSDate *) date
{
    return [NSNumber numberWithLongLong:[DateFormat getTimeMillisForDate:date]];
}

//------------------------------------------------------------------------------
+ (NSString *) stringFromDate:(NSDate *) date
{
    return [DateFormat stringFromDate:date withFormat:@"yyyyMMddHHmmssSSS"];
}

+ (NSString *)stringUIFromDate:(NSDate *)date{
    return [DateFormat stringFromDate:date withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)stringHHmmFromDate:(NSDate *)date{
    return [DateFormat stringFromDate:date withFormat:@"yyyy-MM-dd HH:mm"];
}

+ (NSString *)stringUIFromTime:(NSDate *)date{
    return [DateFormat stringFromDate:date withFormat:@"HH:mm:ss"];
}

+ (NSString *)stringUIFromyMd:(NSDate *)date{
    return [DateFormat stringFromDate:date withFormat:@"yyyy-MM-dd"];
}

//------------------------------------------------------------------------------
+ (NSString *) stringFromDate:(NSDate *) date withFormat:(NSString *) format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter stringFromDate:date];
}

//------------------------------------------------------------------------------
+ (NSString *) timeStringFromDate:(NSDate *) date
{
    return [DateFormat stringFromDate:date withFormat:@"HH:mm:ss"];
}


//------------------------------------------------------------------------------
+ (NSDate *)   dateFromMillis:(long long) ms
{
    NSTimeInterval interval = (double)ms / 1000.0;
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

//------------------------------------------------------------------------------
+ (NSDate *)   dateFromString:(NSString *) str
{
    return [DateFormat dateFromString:str withFormat:@"yyyyMMddHHmmssSSS"];
}

//------------------------------------------------------------------------------
+ (NSDate *)   dateFromString:(NSString *) str withFormat:(NSString *) format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter dateFromString:str];
}

+ (NSDate *)dateFromQuoteDay:(NSString *)quoteDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return [dateFormatter dateFromString:quoteDay];
}

+ (NSDate *)dateFromStringDay:(NSString *)quoteDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return [dateFormatter dateFromString:quoteDay];
}

//------------------------------------------------------------------------------
+ (NSDate *)        firstDayOfMonthForDate:(NSDate *) date
{
    NSDateComponents * comps = nil;
    NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    comps = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    
    [comps setDay:1];
    return [gregorian dateFromComponents:comps];
}

//------------------------------------------------------------------------------
+ (NSDate *)        lastDayOfMonthForDate:(NSDate *) date
{
    NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    
    NSDateComponents * comps = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comps setDay:range.length];
    
    return [gregorian dateFromComponents:comps];
}

//------------------------------------------------------------------------------
+ (NSDate *)        dayOfWeek:(JEDIWeekDays) weekDay forDate:(NSDate *) date
{
    NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:1]; // 1, 周日为第一天； 2, 周一为第一天；
    
    NSDate * weekDate = nil;
    NSTimeInterval timeRange = 0.0;
    
    BOOL bResult = [gregorian rangeOfUnit:NSWeekCalendarUnit startDate:&weekDate interval:&timeRange forDate:date];
    if(bResult == NO){
        return date;
    }
    
    NSDateComponents * weekComp = [[NSDateComponents alloc] init];
    [weekComp setDay:weekDay];
    
    return [gregorian dateByAddingComponents:weekComp toDate:weekDate options:0];
}

//-----
+ (NSString *)getCertificateTimeString:(long long)time {
    NSNumber *longlongTime = [NSNumber numberWithLongLong:time];
    NSString *timeString = [longlongTime stringValue];
    NSString *yyyyString = [timeString substringWithRange:NSMakeRange(0, 4)];
    NSString *MMString = [timeString substringWithRange:NSMakeRange(4, 2)];
    NSString *ddString = [timeString substringWithRange:NSMakeRange(6, 2)];
    NSString *HHString = [timeString substringWithRange:NSMakeRange(8, 2)];
    NSString *mmString = [timeString substringWithRange:NSMakeRange(10, 2)];
    NSString *ssString = [timeString substringWithRange:NSMakeRange(12, 2)];
    //    yyy-MM-dd HH:mm:ss
    NSString *formatString = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@", yyyyString, MMString, ddString, HHString, mmString, ssString];
    return formatString;
}

////////

+ (NSString *)getCurrentYear{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY"];
    
    return [dateFormatter stringFromDate:currentDate];
    
}

+ (NSString *)getCurrentYD {
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    
    return [dateFormatter stringFromDate:currentDate];
    
}

+ (NSString *)getTimeStamp {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *simOrder = [dateFormater stringFromDate:[NSDate date]];
    return simOrder;
}

//根据日期获取星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+ (NSString *)interceptTimeStampFromStr:(NSString *)str{
    
    NSTimeInterval _interval=[str doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy.MM.dd"];
    
    return [objDateformat stringFromDate: date];
    
}

+ (NSString *)interceptTimeDetailFromStr:(NSString *)str {
    NSTimeInterval _interval=[str doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [objDateformat stringFromDate: date];
}


@end
