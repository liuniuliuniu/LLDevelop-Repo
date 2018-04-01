//
//  JYRadarChart.m
//  JYRadarChart
//
//  Created by jy on 13-10-31.
//  Copyright (c) 2013年 wcode. All rights reserved.
//

#import "JYRadarChart.h"
#import "JYLegendView.h"

#define PADDING 13
#define LEGEND_PADDING 3
#define ATTRIBUTE_TEXT_SIZE 10
#define COLOR_HUE_STEP 5
#define MAX_NUM_OF_COLOR 17

@interface JYRadarChart ()

@property (nonatomic, assign) NSUInteger numOfV;
@property (nonatomic, strong) JYLegendView *legendView;
@property (nonatomic, strong) UIFont *scaleFont;

@end

@implementation JYRadarChart

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder
            :aDecoder];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

- (void)setDefaultValues {
    _maxValue = 100.0;
    _centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    _r = MIN(self.frame.size.width / 2 - PADDING, self.frame.size.height / 2 - PADDING);
    _steps = 1;
    _drawPoints = NO;
    _pointsDiameter = 8;
    _pointsStrokeSize = 2;
    _pointsColorOpacity = 1;
    _drawStrokePoints = YES;
    _showLegend = NO;
    _showAxes = YES;
    _showStepText = NO;
    _fillArea = NO;
    _minValue = 0;
    _colorOpacity = 1.0;
    _backgroundLineColorRadial = [UIColor darkGrayColor];
    _backgroundFillColor = [UIColor whiteColor];
    
    _pointsColors = nil;

    _legendView = [[JYLegendView alloc] init];
    _legendView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    _legendView.backgroundColor = [UIColor clearColor];
    _legendView.colors = [NSMutableArray array];
}

- (void)setShowLegend:(BOOL)showLegend {
    _showLegend = showLegend;
    if (_showLegend) {
        [self addSubview:self.legendView];
    }
    else {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[JYLegendView class]]) {
                [subView removeFromSuperview];
            }
        }
    }
}

- (void)setPointsColors:(NSMutableArray *)pointsColors{
    _pointsColors = [NSMutableArray array];
    for (UIColor *color in pointsColors) {
        [_pointsColors addObject:[color colorWithAlphaComponent:self.pointsColorOpacity]];
    }
}

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    [self.legendView sizeToFit];
    [self.legendView setNeedsDisplay];
}

- (void)setDataSeries:(NSMutableArray *)dataSeries {
    _dataSeries = dataSeries;
    NSArray *arr = _dataSeries[0];
    _numOfV = [arr count];
    if (self.legendView.colors.count < _dataSeries.count) {
        for (int i = 0; i < _dataSeries.count; i++) {
            UIColor *color = [UIColor colorWithHue:1.0 * (i * COLOR_HUE_STEP % MAX_NUM_OF_COLOR) / MAX_NUM_OF_COLOR
                                        saturation:1
                                        brightness:1
                                             alpha:self.colorOpacity];
            self.legendView.colors[i] = color;
        }
    }
}

- (void)drawRect:(CGRect)rect {
    NSArray *colors = [self.colors copy];
    CGFloat radPerV = M_PI * 2 / _numOfV;
    
    if (_clockwise) {
        radPerV =  - (M_PI * 2 / _numOfV);
    }
    else
    {
        radPerV = (M_PI * 2 / _numOfV);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [_backgroundFillColor setFill];
    CGContextMoveToPoint(context, _centerPoint.x, _centerPoint.y - _r);
    for (int i = 1; i <= _numOfV; ++i) {
        CGContextAddLineToPoint(context, _centerPoint.x - _r * sin(i * radPerV),
                                _centerPoint.y - _r * cos(i * radPerV));
    }
    CGContextFillPath(context);

    //draw steps line
    //static CGFloat dashedPattern[] = {3,3};
    //TODO: make this color a variable
    [[UIColor lightGrayColor] setStroke];
    CGContextSaveGState(context);
    for (int step = 1; step <= _steps; step++) {
        for (int i = 0; i <= _numOfV; ++i) {
            if (i == 0) {
                CGContextMoveToPoint(context, _centerPoint.x, _centerPoint.y - _r * step / _steps);
            }
            else {
                //                CGContextSetLineDash(context, 0, dashedPattern, 2);
                CGContextAddLineToPoint(context, _centerPoint.x - _r * sin(i * radPerV) * step / _steps,
                                        _centerPoint.y - _r * cos(i * radPerV) * step / _steps);
            }
        }
        CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
    
    //draw lines
    if (_numOfV > 0) {
        for (int serie = 0; serie < [_dataSeries count]; serie++) {
            if (self.fillArea) {
                [colors[serie] setFill];
                [colors[serie] setStroke];
            }
            
            else {
                [colors[serie] setStroke];
            }
            for (int i = 0; i < _numOfV; ++i) {
                CGFloat value = [_dataSeries[serie][i] floatValue];
                if (i == 0) {
                    CGContextMoveToPoint(context, _centerPoint.x, _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _r);
                }
                else {
                    CGContextAddLineToPoint(context, _centerPoint.x - (value - _minValue) / (_maxValue - _minValue) * _r * sin(i * radPerV),
                            _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _r * cos(i * radPerV));
                }
            }
            CGFloat value = [_dataSeries[serie][0] floatValue];
            CGContextAddLineToPoint(context, _centerPoint.x, _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _r);

            if (self.fillArea) {
                CGContextDrawPath(context, kCGPathFillStroke);
                
            }
            else {
                CGContextStrokePath(context);
            }

            //draw data points
            if (_drawPoints) {
                for (int i = 0; i < _numOfV; i++) {
                    CGFloat value = [_dataSeries[serie][i] floatValue];
                    CGFloat xVal = _centerPoint.x - (value - _minValue) / (_maxValue - _minValue) * _r * sin(i * radPerV);
                    CGFloat yVal = _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _r * cos(i * radPerV);

                    [_pointsColors[serie] setFill];
                    CGContextFillEllipseInRect(context, CGRectMake(xVal - _pointsDiameter/2, yVal - _pointsDiameter/2, _pointsDiameter, _pointsDiameter));
                    if(_drawStrokePoints){
//                        [self.backgroundColor setFill];
                        CGContextFillEllipseInRect(context, CGRectMake(xVal - _pointsDiameter/2 + _pointsStrokeSize, yVal - _pointsDiameter/2  + _pointsStrokeSize,
                                                                       _pointsDiameter-_pointsStrokeSize*2, _pointsDiameter-_pointsStrokeSize*2));
                    }
                }
            }
        }
    }
    
}

@end
