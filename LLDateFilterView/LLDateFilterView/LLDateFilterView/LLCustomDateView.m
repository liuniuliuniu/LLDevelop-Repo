//
//  LLCustomDateView.m
//  LLDateFilterView
//
//  Created by liushaohua on 2018/1/10.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import "LLCustomDateView.h"
#import "LLFactoryManager.h"
#import "UIView+LLDateFilterView.h"

#define   TAGPICKERVIEW         2400

@implementation LLDate

- (NSString *)toStringWithSperastring:(NSString *)spera {
    return [[NSString alloc] initWithFormat:@"%@%@%@%@%@",@(self.year),spera,@(self.month),spera,@(self.day)];
}

- (NSString *)twoCharStringWithSperastring {
    NSString *month = nil;
    if (self.month < 10) {
        month = [[NSString alloc] initWithFormat:@"0%@",@(self.month)];
    }else {
        month = @(self.month).stringValue;
    }
    NSString *day = nil;
    if (self.day < 10) {
        day = [[NSString alloc] initWithFormat:@"0%@",@(self.day)];
    }else {
        day = @(self.day).stringValue;
    }
    
    return [[NSString alloc] initWithFormat:@"%@%@%@",@(self.year),month,day];
}

- (NSTimeInterval)toTimeInterval {
    return (long)[[self toDateTime] timeIntervalSince1970];
}
- (NSDate *)toDateTime {
    NSString * formatter= @"yyyy-MM-dd";
    NSString * formatterString = [self timeFormatterString];
    NSTimeZone * localzone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    [dateFormatter setTimeZone:localzone];
    NSDate * date = [dateFormatter dateFromString:formatterString];
    return date;
}
- (NSString *)timeFormatterString {
    return [NSString stringWithFormat:@"%@-%@-%@",@(_year),@(_month),@(_day)];
}
@end


@interface LLCustomDateView ()

@property (nonatomic,strong) NSArray    *todayArray;
@property (nonatomic,assign) NSInteger  yearL;
@property (nonatomic,assign) NSInteger  monthL;
@property (nonatomic,assign) NSInteger  dayL;
@property (nonatomic,assign) NSInteger  yearR;
@property (nonatomic,assign) NSInteger  monthR;
@property (nonatomic,assign) NSInteger  dayR;

@end

@implementation LLCustomDateView

- (instancetype)initWithFrame:(CGRect)frame minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate {
    self = [super initWithFrame:frame];
    if (self) {
        _leftStartDate = minDate;
        _leftEndDate = maxDate;
        _rightStartDate = minDate;
        _rightEndDate = maxDate;
        _changedData = NO;
        [self designSubviews];
    }
    return self;
}

- (void)initStatus:(NSDictionary*)dic {
    NSString *monthString;
    NSString *dayString;
    NSInteger indexOfYearL;
    NSInteger indexOfMonthL;
    NSInteger indexOfDayL;
    NSInteger indexOfYearR;
    NSInteger indexOfMonthR;
    NSInteger indexOfDayR;
    self.todayArray = [LLFactoryManager yearMonthDayFromDate:[[NSDate alloc] init]];
    if (self.todayArray.count > 3) {
        self.yearL = [self.todayArray[0] integerValue];
        self.monthL = [self.todayArray[1] integerValue];
        self.dayL = [self.todayArray[2] integerValue];
        self.yearR = self.yearL;
        self.monthR = self.monthL;
        self.dayR = self.dayL;
    }
    monthString = [self transformStringWithNum:self.monthL];
    dayString = [self transformStringWithNum:self.dayL];
    
    indexOfYearL = [[self yearTitles] indexOfObject:@(self.yearL).stringValue];
    indexOfYearR = [[self yearTitles] indexOfObject:@(self.yearL).stringValue];
    
    indexOfMonthL = [[self monthTitles] indexOfObject:monthString];
    indexOfMonthR = [[self monthTitles] indexOfObject:monthString];
    
    indexOfDayL = [[self dayTitlesByYear:self.yearL month:self.monthL] indexOfObject:dayString];
    indexOfDayR = [[self dayTitlesByYear:self.yearL month:self.monthL] indexOfObject:dayString];
    if (dic) {
        NSString * startString = dic[@"start_date"];
        if (startString) {
            NSArray * array = [startString componentsSeparatedByString:@"-"];
            if (array.count>=3) {
                self.yearL = [array[0] integerValue];
                self.monthL = [array[1] integerValue];
                self.dayL = [array[2] integerValue];
                indexOfYearL = [[self yearTitles] indexOfObject:array[0]];
                indexOfMonthL = [[self monthTitles] indexOfObject:array[1]];
                indexOfDayL = [[self dayTitlesByYear:self.yearL month:self.monthL] indexOfObject:array[2]];
            }
        }
        NSString * endString = dic[@"end_date"];
        if (endString) {
            NSArray * array = [endString componentsSeparatedByString:@"-"];
            if (array.count>=3) {
                self.yearR = [array[0] integerValue];
                self.monthR = [array[1] integerValue];
                self.dayR = [array[2] integerValue];
                indexOfYearR = [[self yearTitles] indexOfObject:array[0]];
                indexOfMonthR = [[self monthTitles] indexOfObject:array[1]];
                indexOfDayR = [[self dayTitlesByYear:self.yearR month:self.monthR] indexOfObject:array[2]];
                
            }
        }
    }
    
    UIPickerView *leftPickerView = [self viewWithTag:TAGPICKERVIEW];
    UIPickerView *rightPickerView = [self viewWithTag:TAGPICKERVIEW + 1];
    
    if (indexOfYearL != NSNotFound && indexOfYearR != NSNotFound) {
        [leftPickerView selectRow:indexOfYearL inComponent:0 animated:NO];
        [rightPickerView selectRow:indexOfYearR inComponent:0 animated:NO];
    }
    if (indexOfMonthL != NSNotFound && indexOfMonthR != NSNotFound) {
        [leftPickerView selectRow:indexOfMonthL inComponent:1 animated:NO];
        [rightPickerView selectRow:indexOfMonthR inComponent:1 animated:NO];
    }
    if (indexOfDayL != NSNotFound && indexOfDayR != NSNotFound) {
        [leftPickerView selectRow:indexOfDayL inComponent:2 animated:NO];
        [rightPickerView selectRow:indexOfDayR inComponent:2 animated:NO];
    }
}

- (void)designSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    self.todayArray = [LLFactoryManager yearMonthDayFromDate:[[NSDate alloc] init]];
    if (self.todayArray.count > 3) {
        self.yearL = [self.todayArray[0] integerValue];
        self.monthL = [self.todayArray[1] integerValue];
        self.dayL = [self.todayArray[2] integerValue];
        self.yearR = self.yearL;
        self.monthR = self.monthL;
        self.dayR = self.dayL;
    }
    
    NSString *monthString = [self transformStringWithNum:self.monthL];
    NSString *dayString = [self transformStringWithNum:self.dayL];

    NSInteger indexOfYear = [[self yearTitles] indexOfObject:@(self.yearL).stringValue];
    NSInteger indexOfMonth = [[self monthTitles] indexOfObject:monthString];
    NSInteger indexOfDay = [[self dayTitlesByYear:self.yearL month:self.monthL] indexOfObject:dayString];
    
    for (int y = 0; y < 2; y ++) {
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(y * [UIScreen mainScreen].bounds.size.width / 2, 0, self.width / 2 - 20, self.height)];
        picker.dataSource = self;
        picker.delegate = self;
        picker.tag = TAGPICKERVIEW + y;
        [self addSubview:picker];
        
        if (indexOfYear != NSNotFound) {
            [picker selectRow:indexOfYear inComponent:0 animated:NO];
        }
        if (indexOfMonth != NSNotFound) {
            [picker selectRow:indexOfMonth inComponent:1 animated:NO];
        }
        if (indexOfDay != NSNotFound) {
            [picker selectRow:indexOfDay inComponent:2 animated:NO];
        }

        NSArray *titles = @[@"年",@"月",@"日"];
        for (int x = 0; x < 3; x ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(y * [UIScreen mainScreen].bounds.size.width / 2 + self.width / 8 + x * self.width / 7 + (x == 2?3:0), self.height / 2 - 15, 30, 30)];
            label.text = titles[x];
            if ([UIScreen mainScreen].bounds.size.width < 330) {
                label.font = [UIFont systemFontOfSize:12];
            }else{
                label.font = [UIFont systemFontOfSize:15];
            }
            [self addSubview:label];
        }
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2 - 15, self.height / 2 - 15, 30, 30)];
    label.text = @"至";
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
}

- (void)selectDate:(NSDate *)date isRight:(BOOL)isRight {
    
    if (![date isKindOfClass:[NSDate class]]) {
        return;
    }
    NSArray *lastArray = [self yearMonthDayFromDate:date];
    NSInteger year = [lastArray[0] integerValue];
    NSInteger month = [lastArray[1] integerValue];
    NSInteger day = [lastArray[2] integerValue];
    if (!isRight) {
        _yearL = year;
        _monthL = month;
        _dayL = day;
    }
    else {
        _yearR = year;
        _monthR = month;
        _dayR = day;
    }

    UIPickerView *_pickerView = [self viewWithTag:TAGPICKERVIEW + isRight];
    
    NSInteger yearIndex = [[self yearTitles] indexOfObject:@(year).stringValue];
    NSInteger monthIndex = [[self monthTitles] indexOfObject:[self transformStringWithNum:month]];
    NSInteger dayIndex = [[self dayTitlesByYear:year month:month] indexOfObject:[self transformStringWithNum:day]];
    
    if (yearIndex != NSNotFound) {
        [_pickerView selectRow:yearIndex inComponent:0 animated:YES];
    }
    if (monthIndex != NSNotFound) {
        [_pickerView selectRow:monthIndex inComponent:1 animated:YES];
    }
    if (dayIndex != NSNotFound) {
        [_pickerView selectRow:dayIndex inComponent:2 animated:YES];
    }
}
                             
- (NSArray *)hourTitles {
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        for (int x = 0; x < 24; x ++) {
            [titles addObject:[self transformStringWithNum:x]];
        }
        return titles;
}
                             
- (NSArray *)minuteTitles {
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        for (int x = 0; x < 60; x ++) {
            [titles addObject:[self transformStringWithNum:x]];
        }
        return titles;
}

- (NSArray *)yearMonthDayFromDate:(NSDate *)date {
    
    if (date == nil) {
        return nil;
    }
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


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return self.width / 5;
    }
    return self.width / 7;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 25;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [self yearTitles].count;
    }else if (component == 1) {
        return 12;
    }else {
        NSArray *titles = nil;
        if (pickerView.tag == TAGPICKERVIEW) {
            titles = [self dayTitlesByYear:self.yearL month:self.monthL];
        }else{
            titles = [self dayTitlesByYear:self.yearR month:self.monthR];
        }
        return titles.count;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    UILabel *label = (UILabel *)view;
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        label.font = [UIFont systemFontOfSize:13];
    }
    NSString *string = nil;
    if (component == 0) {
        string = [self yearTitles][row];
    }else if (component == 1) {
        string = [self monthTitles][row];
    }else if (component == 2) {
        if (pickerView.tag == TAGPICKERVIEW) {
            NSArray *titles = [self dayTitlesByYear:self.yearL month:self.monthL];
            if (row < titles.count) {
                string = titles[row];
            }
        }else {
            NSArray *titles = [self dayTitlesByYear:self.yearR month:self.monthR];
            if (row < titles.count) {
                string = titles[row];
            }
        }
    }
    label.text = string;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger yearNow = [self.todayArray[0] integerValue];
    _changedData = YES;
    if (pickerView.tag == TAGPICKERVIEW) {
        if (component == 0) {
            if ([_leftStartDate isKindOfClass:[NSDate class]] && [_leftEndDate isKindOfClass:[NSDate class]]) {
                NSDateComponents *components = [LLFactoryManager dateComponentForTimeInterval:[_leftStartDate timeIntervalSince1970]];
                self.yearL = row + components.year;
            }else {
                self.yearL = row + yearNow - 5;
            }
            
            NSArray *dayArray = [self dayTitlesByYear:self.yearL month:self.monthL];
            NSString *dayString = [self transformStringWithNum:self.dayL];
            NSInteger dayIndex = [dayArray indexOfObject:dayString];
            if ((dayIndex == NSNotFound) && (self.dayL > dayArray.count)) {
                self.dayL = dayArray.count;
            }
        }else if (component == 1) {
            self.monthL = row + 1;
            NSArray *dayArray = [self dayTitlesByYear:self.yearL month:self.monthL];
            NSString *dayString = [self transformStringWithNum:self.dayL];
            NSInteger dayIndex = [dayArray indexOfObject:dayString];
            if ((dayIndex == NSNotFound) && (self.dayL > dayArray.count)){
                self.dayL = dayArray.count;
            }
        }else if (component == 2) {
            self.dayL = row + 1;
        }
        [pickerView reloadAllComponents];
        
        NSDate *date = [LLFactoryManager dateFromStringByHotlineWithoutSeconds:[[NSString alloc] initWithFormat:@"%@-%@-%@ 00:00",@(self.yearL).stringValue,[self transformStringWithNum:self.monthL],[self transformStringWithNum:self.dayL]]];
        if (self.leftStartDate) {
            BOOL isEarlier = [LLFactoryManager compareDateOne:date earlierToDataTwo:self.leftStartDate];

            if (isEarlier) {
                NSArray *minArray = [LLFactoryManager yearMonthDayFromDate:self.leftStartDate];
                if (minArray) {
                    NSInteger year = [minArray[0] integerValue];
                    NSInteger month = [minArray[1] integerValue];
                    NSInteger day = [minArray[2] integerValue];
                    
                    NSArray *arrayDays = [self dayTitlesByYear:year month:month];
                    NSInteger yearIndex = [[self yearTitles] indexOfObject:@(year).stringValue];
                    NSInteger monthIndex = [[self monthTitles] indexOfObject:[self transformStringWithNum:month]];
                    NSInteger dayIndex = [arrayDays indexOfObject:[self transformStringWithNum:day]];
                    
                    if (yearIndex != NSNotFound) {
                        self.yearL = year;
                    }
                    if (monthIndex != NSNotFound) {
                        self.monthL = month;
                    }
                    if (dayIndex != NSNotFound) {
                        self.dayL = day;
                    }
                }
            }
        }
        
        date = [LLFactoryManager dateFromStringByHotlineWithoutSeconds:[[NSString alloc] initWithFormat:@"%@-%@-%@ 00:00",@(self.yearL).stringValue,[self transformStringWithNum:self.monthL],[self transformStringWithNum:self.dayL]]];
        if (self.leftEndDate) {
            BOOL isEarlier = [LLFactoryManager compareDateOne:self.leftEndDate earlierToDataTwo:date];
            
            if (isEarlier) {
                NSArray *minArray = [LLFactoryManager yearMonthDayFromDate:self.leftEndDate];
                if (minArray) {
                    NSInteger year = [minArray[0] integerValue];
                    NSInteger month = [minArray[1] integerValue];
                    NSInteger day = [minArray[2] integerValue];
                    
                    NSInteger yearIndex = [[self yearTitles] indexOfObject:@(year).stringValue];
                    NSInteger monthIndex = [[self monthTitles] indexOfObject:[self transformStringWithNum:month]];
                    NSInteger dayIndex = [[self dayTitlesByYear:year month:month] indexOfObject:[self transformStringWithNum:day]];
                    
                    if (yearIndex != NSNotFound) {
                        self.yearL = year;
                    }
                    if (monthIndex != NSNotFound) {
                        self.monthL = month;
                    }
                    if (dayIndex != NSNotFound) {
                        self.dayL = day;
                    }
                }
            }
        }
        
        [pickerView reloadAllComponents];
        
        NSArray *arrayDays = [self dayTitlesByYear:self.yearL month:self.monthL];
        NSInteger yearIndex = [[self yearTitles] indexOfObject:@(self.yearL).stringValue];
        NSInteger monthIndex = [[self monthTitles] indexOfObject:[self transformStringWithNum:self.monthL]];
        NSInteger dayIndex = [arrayDays indexOfObject:[self transformStringWithNum:self.dayL]];
        
        if (yearIndex != NSNotFound) {
            [pickerView selectRow:yearIndex inComponent:0 animated:YES];
        }
        if (monthIndex != NSNotFound) {
            [pickerView selectRow:monthIndex inComponent:1 animated:YES];
        }
        if (dayIndex != NSNotFound) {
            [pickerView selectRow:dayIndex inComponent:2 animated:YES];
        }
    }else{  // Right
        
        if (component == 0) {
            
            if ([_leftStartDate isKindOfClass:[NSDate class]] && [_leftEndDate isKindOfClass:[NSDate class]]) {
                NSDateComponents *components = [LLFactoryManager dateComponentForTimeInterval:[_leftStartDate timeIntervalSince1970]];
                self.yearR = row + components.year;
            }else{
                self.yearR = row + yearNow - 5;
            }
            
            
            NSArray *dayArray = [self dayTitlesByYear:self.yearR month:self.monthR];
            NSString *dayString = [self transformStringWithNum:self.dayR];
            NSInteger dayIndex = [dayArray indexOfObject:dayString];
            if ((dayIndex == NSNotFound) && (self.dayR > dayArray.count)){
                self.dayR = dayArray.count;
            }
        }else if (component == 1) {
            self.monthR = row + 1;
            NSArray *dayArray = [self dayTitlesByYear:self.yearR month:self.monthR];
            NSString *dayString = [self transformStringWithNum:self.dayR];
            NSInteger dayIndex = [dayArray indexOfObject:dayString];
            if ((dayIndex == NSNotFound) && (self.dayR > dayArray.count)){
                self.dayR = dayArray.count;
            }
        }else if (component == 2){
            self.dayR = row + 1;
        }
        [pickerView reloadAllComponents];
        
        NSDate *date = [LLFactoryManager dateFromStringByHotlineWithoutSeconds:[[NSString alloc] initWithFormat:@"%@-%@-%@ 00:00",@(self.yearR).stringValue,[self transformStringWithNum:self.monthR],[self transformStringWithNum:self.dayR]]];
        if (self.rightStartDate) {
            BOOL isEarlier = [LLFactoryManager compareDateOne:date earlierToDataTwo:self.rightStartDate];
            if (isEarlier) {
                NSArray *minArray = [LLFactoryManager yearMonthDayFromDate:self.rightStartDate];
                if (minArray) {
                    NSInteger year = [minArray[0] integerValue];
                    NSInteger month = [minArray[1] integerValue];
                    NSInteger day = [minArray[2] integerValue];
                    
                    NSArray *arrayDays = [self dayTitlesByYear:year month:month];
                    NSInteger yearIndex = [[self yearTitles] indexOfObject:@(year).stringValue];
                    NSInteger monthIndex = [[self monthTitles] indexOfObject:[self transformStringWithNum:month]];
                    NSInteger dayIndex = [arrayDays indexOfObject:[self transformStringWithNum:day]];
                    
                    if (yearIndex != NSNotFound) {
                        self.yearR = year;
                    }
                    if (monthIndex != NSNotFound) {
                        self.monthR = month;
                    }
                    if (dayIndex != NSNotFound) {
                        self.dayR = day;
                    }
                }
            }
        }
        
        date = [LLFactoryManager dateFromStringByHotlineWithoutSeconds:[[NSString alloc] initWithFormat:@"%@-%@-%@ 00:00",@(self.yearR).stringValue,[self transformStringWithNum:self.monthR],[self transformStringWithNum:self.dayR]]];
        if (self.rightEndDate) {
            BOOL isEarlier = [LLFactoryManager compareDateOne:self.rightEndDate earlierToDataTwo:date];
            if (isEarlier) {
                NSArray *minArray = [LLFactoryManager yearMonthDayFromDate:self.rightEndDate];
                if (minArray) {
                    NSInteger year = [minArray[0] integerValue];
                    NSInteger month = [minArray[1] integerValue];
                    NSInteger day = [minArray[2] integerValue];
                    
                    NSInteger yearIndex = [[self yearTitles] indexOfObject:@(year).stringValue];
                    NSInteger monthIndex = [[self monthTitles] indexOfObject:[self transformStringWithNum:month]];
                    NSInteger dayIndex = [[self dayTitlesByYear:year month:month] indexOfObject:[self transformStringWithNum:day]];
                    
                    if (yearIndex != NSNotFound) {
                        self.yearR = year;
                    }
                    if (monthIndex != NSNotFound) {
                        self.monthR = month;
                    }
                    if (dayIndex != NSNotFound) {
                        self.dayR = day;
                    }
                }
            }
        }
        
        [pickerView reloadAllComponents];        
        NSArray *arrayDays = [self dayTitlesByYear:self.yearR month:self.monthR];
        NSInteger yearIndex = [[self yearTitles] indexOfObject:@(self.yearR).stringValue];
        NSInteger monthIndex = [[self monthTitles] indexOfObject:[self transformStringWithNum:self.monthR]];
        NSInteger dayIndex = [arrayDays indexOfObject:[self transformStringWithNum:self.dayR]];
        
        if (yearIndex != NSNotFound) {
            [pickerView selectRow:yearIndex inComponent:0 animated:YES];
        }
        if (monthIndex != NSNotFound) {
            [pickerView selectRow:monthIndex inComponent:1 animated:YES];
        }
        if (dayIndex != NSNotFound) {
            [pickerView selectRow:dayIndex inComponent:2 animated:YES];
        }
    }
    
    LLDate *dateL = [[LLDate alloc] init];
    dateL.year = _yearL;
    dateL.month = _monthL;
    dateL.day = _dayL;

    LLDate *dateR = [[LLDate alloc] init];
    dateR.year = _yearR;
    dateR.month = _monthR;
    dateR.day = _dayR;

    if (_block) {
        _block(self,dateL,dateR);
    }
}

- (LLDate *)leftDate {
    LLDate *date = [[LLDate alloc] init];
    date.year = _yearL;
    date.month = _monthL;
    date.day = _dayL;
    return date;
}

- (NSString *)leftDateString {
    
    return [NSString stringWithFormat:@"%04ld-%02ld-%02ld",(long)_yearL,(long)_monthL,(long)_dayL];
}

- (LLDate *)rightDate {
    LLDate *date = [[LLDate alloc] init];
    date.year = _yearR;
    date.month = _monthR;
    date.day = _dayR;
    return date;
}

- (NSString *)rightDateString {
    return [NSString stringWithFormat:@"%04ld-%02ld-%02ld",(long)_yearR,(long)_monthR,(long)_dayR];
}

- (NSArray *)monthTitles {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int x = 0; x < 12; x ++) {
        [array addObject:[self transformStringWithNum:x + 1]];
    }
    return array;
}

- (NSArray *)dayTitlesByYear:(NSInteger)year month:(NSInteger)month {
    NSInteger days = 0;
    BOOL isLeapYear = [LLFactoryManager isLeapYear:year];
    BOOL isBigMonth = NO;
    if (month <=7) {
        if (month % 2 == 1) {
            isBigMonth = YES;
        }
    }else{
        if (month % 2 == 0) {
            isBigMonth = YES;
        }
    }
    
    if (isLeapYear) {
        if (month == 2) {
            days = 29;
        }else if (isBigMonth){
            days = 31;
        }else{
            days = 30;
        }
    }else{
        if (month == 2) {
            days = 28;
        }else if (isBigMonth){
            days = 31;
        }else{
            days = 30;
        }
    }
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int x = 0; x < days; x ++) {
        [titles addObject:[self transformStringWithNum:x + 1]];
    }
    return titles;
}

- (NSArray *)yearTitles {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if ([_leftStartDate isKindOfClass:[NSDate class]] && [_leftEndDate isKindOfClass:[NSDate class]]) {
        NSDateComponents *minComponents = [LLFactoryManager dateComponentForTimeInterval:[_leftStartDate timeIntervalSince1970]];
        NSDateComponents *maxComponents = [LLFactoryManager dateComponentForTimeInterval:[_leftEndDate timeIntervalSince1970]];
        for (NSInteger x = minComponents.year; x <= maxComponents.year; x ++) {
            [array addObject:@(x).stringValue];
        }
    }else{
        NSInteger yearNow = [self.todayArray[0] integerValue];
        for (int x = 0; x < 6; x ++) {
            [array addObject:@(x + yearNow - 5).stringValue];
        }
    }
    return array;
}

- (NSString *)transformStringWithNum:(NSInteger)number {
    if (number < 0) {
        return @"--";
    }
    if (number < 10) {
        return [[NSString alloc] initWithFormat:@"0%@",@(number)];
    }else{
        return @(number).stringValue;
    }
}

@end
