//
//  LLDateFilterView.h
//  LLDateFilterView
//
//  Created by liushaohua on 2018/1/10.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLCustomDateView.h"


@interface LLButtonDataModel : NSObject

@property (nonatomic , copy) NSString * title;
@property (nonatomic , copy) NSString * startTime;
@property (nonatomic , copy) NSString * endTime;
@property (nonatomic , copy) UIColor  * selectedColor;
@property (nonatomic , copy) UIColor  * normalColor;

@end

@class LLDateFilterView;
typedef void(^LLDateBlock)(LLDateFilterView *bView,NSString *bLeftDate,NSString *bRightDate,NSString * titleString);

@interface LLDateFilterView : UIView

@property (nonatomic, strong) LLCustomDateView  *dateView;
@property (nonatomic, copy)   LLDateBlock       finishBlock;
@property (nonatomic, strong) NSDate             *minDate;
@property (nonatomic, strong) NSDate             *startDate;
@property (nonatomic, strong) NSDate             *endDate;
@property (nonatomic, strong) NSDictionary       *dic;

/**
 快速选择按钮选中颜色  default is blue
 */
@property (nonatomic, strong) UIColor * btnSelectColor;

/**
 快速选择按钮默认颜色  default is gray
 */
@property (nonatomic, strong) UIColor * btnNormalColor;

/**
 初始化方法一

 @param frame frame Height 不需要设置 自适应
 @param buttonTitles 左右按钮 default is 重置 and 完成
 @param needQuickSelectionModule 是否显示快速选择视图
 @param startDate 开始时间
 @param endDate 结束时间
 @return view
 */
- (instancetype)initWithFrame:(CGRect)frame buttonTitles:(NSArray *)buttonTitles quickSelected:(BOOL)needQuickSelectionModule startDate:(NSDate *)startDate endDate:(NSDate *)endDate;

/**
 初始化方法二

 @param frame frame Height 不需要设置 自适应
 @param buttonTitles 左右按钮 default is 重置 and 完成
 @param needQuickSelectionModule 是否需要快速选择视图
 @return view
 */
- (instancetype)initWithFrame:(CGRect)frame buttonTitles:(NSArray *)buttonTitles quickSelected:(BOOL)needQuickSelectionModule;

/**
 初始化方法三

 @param frame Height 不需要设置 自适应
 @param buttonTitles 左右按钮 default is 重置 and 完成
 @return view
 */
- (instancetype)initWithFrame:(CGRect)frame buttonTitles:(NSArray *)buttonTitles;
- (void)cleanDate;

@end
