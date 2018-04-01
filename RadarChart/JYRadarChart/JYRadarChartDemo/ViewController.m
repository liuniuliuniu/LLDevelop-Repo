//
//  ViewController.m
//  JYRadarChartDemo
//
//  Created by jy on 13-10-31.
//  Copyright (c) 2013年 wcode. All rights reserved.
//

#import "ViewController.h"
#import "JYRadarChart.h"

@interface ViewController () {
	JYRadarChart *p;
}

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
	p = [[JYRadarChart alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];

	NSArray *a1 = @[@(81), @(97), @(87), @(60), @(65)];
	p.dataSeries = @[a1];
	p.steps = 4;
	p.backgroundColor = [UIColor whiteColor];
	p.minValue = 20;
	p.maxValue = 120;
	p.fillArea = YES;
	p.colorOpacity = 0.7;
    p.drawPoints = YES;
	[p setColors:@[[[UIColor blueColor]colorWithAlphaComponent:0.2]]];
	[self.view addSubview:p];

}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
