//
//  LLCustomDateView.h
//  LLDateFilterView
//
//  Created by liushaohua on 2018/1/10.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLCustomDateView;
@class LLDate;
typedef void(^CustomDateBlock)(LLCustomDateView *bView,LLDate *leftDate,LLDate *rightDate);

@interface LLDate : NSObject

@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger hour;
@property (nonatomic,assign) NSInteger minute;

- (NSString *)toStringWithSperastring:(NSString *)spera;

- (NSString *)twoCharStringWithSperastring;

- (NSTimeInterval)toTimeInterval;

- (NSDate *)toDateTime;

@end

@interface LLCustomDateView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) NSDate     *leftStartDate;
@property (nonatomic,strong) NSDate     *leftEndDate;
@property (nonatomic,strong) NSDate     *rightStartDate;
@property (nonatomic,strong) NSDate     *rightEndDate;
@property (nonatomic,assign) BOOL        changedData;
@property (nonatomic,copy) CustomDateBlock      block;

- (instancetype)initWithFrame:(CGRect)frame minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate;
- (void)selectDate:(NSDate *)date isRight:(BOOL)isRight;

- (LLDate *)leftDate;
- (NSString *)leftDateString;
- (LLDate *)rightDate;
- (NSString *)rightDateString;

- (void)initStatus:(NSDictionary*)dic;

@end
