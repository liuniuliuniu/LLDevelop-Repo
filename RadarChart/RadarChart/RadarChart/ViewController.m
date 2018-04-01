//
//  ViewController.m
//  RadarChart
//
//  Created by qiuyaoyao on 16/6/5.
//  Copyright © 2016年 runagain. All rights reserved.
//

#import "ViewController.h"
#import "RAShareChartView.h"

@interface ViewController ()

@property (nonatomic, strong) RAShareChartView *chartV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.chartV.center = self.view.center;
    [self.view addSubview:self.chartV];
    
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(1.5)];
    [array addObject:@(2.0)];
    [array addObject:@(4.0)];
    [array addObject:@(3.5)];
    [array addObject:@(0.7)];
    
    self.chartV.scoresArray = array;
}

-(RAShareChartView *)chartV
{
    if (!_chartV) {
        _chartV = [[RAShareChartView alloc] initWithFrame:CGRectMake(0, 0, 300 , 400)];
    }
    return _chartV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
