//
//  RAShareChartView.m
//  Running_0.1
//
//  Created by qiuyaoyao on 16/4/18.
//  Copyright © 2016年 qiuyaoyao. All rights reserved.
//

#import "RAShareChartView.h"
#import "RADotView.h"
#import "UIColor+custom.h"
#import "UIBezierPath+Pentagon.h"

//#define kRScrollAlertViewWidth 300

@interface RAShareChartView ()

@property (nonatomic, strong) NSMutableArray *dotArrays;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSMutableArray *dot1Arrays;
@property (nonatomic, strong) UIImageView *bgIV;

@property (nonatomic,assign) CGFloat r;

@end

@implementation RAShareChartView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.r = MIN(self.frame.size.width/2, self.frame.size.height/2);
        self.backgroundColor = [UIColor whiteColor];
        [self drawBgPentagon];
    }
    return  self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setScoresArray:(NSArray *)scoresArray
{
    _scoresArray = scoresArray;
    [self drawScorePentagonV];
}

// 填充的颜色
- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = [[UIColor blueColor]colorWithAlphaComponent:0.3 ].CGColor;
        _shapeLayer.fillColor = [[UIColor  blueColor]colorWithAlphaComponent:0.1 ].CGColor;
    }
    return _shapeLayer;
}

// 线的长度
- (NSNumber *)convertLengthFromScore:(double)score
{
    return @(self.r / 4 * score);
    
}
- (NSArray *)convertLengthsFromScore:(NSArray *)scoreArray
{
    NSMutableArray *lengthArray = [NSMutableArray array];
    for (int i = 0; i < [scoreArray count]; i++) {
        double score = [[scoreArray objectAtIndex:i] doubleValue];
        [lengthArray addObject:[self convertLengthFromScore:score]];
    }
    return lengthArray;
}

- (void)drawBgPentagon
{
    for (int i = 0; i < 4; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor darkGrayColor].CGColor;
        UIColor *fillColor = [UIColor colorWithHex:0xEEF2FA alpha:0.1];
        shapeLayer.fillColor = fillColor.CGColor;
        shapeLayer.path = [UIBezierPath drawPentagonWithCenter:CGPointMake(self.r, self.r) Length:[[self convertLengthFromScore:4 - i] doubleValue]];
        [self.layer addSublayer:shapeLayer];
    }    
}

#pragma mark - 描绘分数五边行  按等比放大
- (void)drawScorePentagonV
{
    NSArray *lengthsArray = [self convertLengthsFromScore:self.scoresArray];
    self.shapeLayer.path = [UIBezierPath drawPentagonWithCenter:CGPointMake(self.r, self.r) LengthArray:lengthsArray];
    [self.layer addSublayer:self.shapeLayer];
    [self changeBgSizeFinish];
}
#pragma mark - 描点
- (void)changeBgSizeFinish
{
     NSArray *array = [self convertLengthsFromScore:self.scoresArray];
    NSArray *lengthsArray = [UIBezierPath converCoordinateFromLength:array Center:CGPointMake(self.r, self.r)];
    for (int i = 0; i < [lengthsArray count]; i++) {
        CGPoint point = [[lengthsArray objectAtIndex:i] CGPointValue];
        RADotView *view = [[RADotView alloc] init];
        view.dotColor = [UIColor colorWithHex:0x136CF3];
        view.center = point;
        view.bounds = CGRectMake(0, 0, 8.5, 8.5);
        [self addSubview:view];
    }
}

@end
