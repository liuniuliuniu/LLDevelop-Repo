//
//  LLFactoryManager.h
//  LLDateFilterView
//
//  Created by liushaohua on 2018/1/10.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLFactoryManager : NSObject

/// 本周
+ (NSDictionary *)thisWeek;
/// 本月
+ (NSDictionary *)thisMonth;
/// 和当天相比偏移的天数
+ (NSDictionary *)dayCompareTodayOffset:(NSInteger)offset;

+ (NSDateComponents *)dateComponentForTimeInterval:(NSTimeInterval)timeInterval;

+ (NSDate *)dateFromStringByHotline:(NSString *)string;

+ (NSDate *)dateFromStringByHotlineWithoutSeconds:(NSString *)string;

+ (NSArray *)yearMonthDayFromDate:(NSDate *)date;
/// 字符串转时间戳
+ (NSTimeInterval)timeIntervalWithString:(NSString*)dataString;

+ (BOOL)compareDateOne:(NSDate *)dateOne earlierToDataTwo:(NSDate *)dateTwo;
/// 是否是闰年
+ (BOOL)isLeapYear:(NSInteger)year;
@end
