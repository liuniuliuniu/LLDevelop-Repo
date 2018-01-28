//
//  LLFactoryManager.m
//  LLDateFilterView
//
//  Created by liushaohua on 2018/1/10.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import "LLFactoryManager.h"

@implementation LLFactoryManager


+ (NSDictionary *)thisWeek {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay fromDate:now];
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    long firstDiff;
    if (weekDay == 1) {
        firstDiff = 1;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
    }
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    return [NSDictionary dictionaryWithObjectsAndKeys:[formater stringFromDate:firstDayOfWeek],@"start_date",[formater stringFromDate:[NSDate date]],@"end_date", nil];
}

+ (NSDictionary *)thisMonth {
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:dateNow];
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@-%@-01",[dateStr substringToIndex:4],[dateStr substringWithRange:NSMakeRange(5, 2)]],@"start_date",dateStr,@"end_date", nil];
}

+ (NSDictionary *)dayCompareTodayOffset:(NSInteger)offset {
    NSDate * date = [NSDate date];
    NSDate *Day = [NSDate dateWithTimeInterval:(offset*24*60*60) sinceDate:date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beforDate = [dateFormatter stringFromDate:Day];
    return [NSDictionary dictionaryWithObjectsAndKeys:beforDate,@"start_date",beforDate,@"end_date", nil];
}

+ (NSDateComponents *)dateComponentForTimeInterval:(NSTimeInterval)timeInterval {
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    return [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth fromDate:date];
}

+ (NSDate *)dateFromStringByHotline:(NSString *)string {
    if ([string isKindOfClass:[NSNull class]])  return nil;
    if ([string isKindOfClass:[NSString class]] && string.length == 0) return nil;

    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600]];
    [dateFormatter  setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date= [dateFormatter dateFromString:string];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    return localeDate;
}

+ (NSDate *)dateFromStringByHotlineWithoutSeconds:(NSString *)string {
    
    if ([string isKindOfClass:[NSNull class]]) return nil;
    if ([string isKindOfClass:[NSString class]] && string.length == 0) return nil;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date= [dateFormatter dateFromString:string];
    
    return date;
}


+ (NSArray *)yearMonthDayFromDate:(NSDate *)date {
    if (date == nil) return nil;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit year = NSCalendarUnitYear;
    NSCalendarUnit month = NSCalendarUnitMonth;
    NSCalendarUnit day = NSCalendarUnitDay;
    NSCalendarUnit hour = NSCalendarUnitHour;
    NSCalendarUnit minute = NSCalendarUnitMinute;
    NSCalendarUnit second = NSCalendarUnitSecond;
    NSDateComponents *theComponents = [calendar components:year|month|day|hour|minute|second fromDate:date];
    return @[@(theComponents.year),@(theComponents.month),@(theComponents.day),@(theComponents.hour),@(theComponents.minute),@(theComponents.second)];
}


+ (NSTimeInterval)timeIntervalWithString:(NSString*)dataString {
    NSString * formatter= @"yyyy-MM-dd";
    NSTimeZone * localzone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    [dateFormatter setTimeZone:localzone];
    NSDate * date = [dateFormatter dateFromString:dataString];
    return (long)[date timeIntervalSince1970];
}

+ (BOOL)compareDateOne:(NSDate *)dateOne earlierToDataTwo:(NSDate *)dateTwo {
    
    if (dateOne == nil  || dateTwo == nil) return NO;
    NSTimeInterval aTimeInterval = [dateOne timeIntervalSince1970];
    NSTimeInterval bTimeInterval = [dateTwo timeIntervalSince1970];
    if (aTimeInterval < bTimeInterval)  return YES;
    
    return NO;
}

+ (BOOL)isLeapYear:(NSInteger)year {
    if ((year % 4  == 0 && year % 100 != 0)  || year % 400 == 0)
        return YES;
    else
        return NO;
}




@end
