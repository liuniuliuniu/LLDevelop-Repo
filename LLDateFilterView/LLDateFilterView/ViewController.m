//
//  ViewController.m
//  LLDateFilterView
//
//  Created by liushaohua on 2018/1/21.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import "ViewController.h"
#import "LLDateFilterView.h"
#import "UIView+LLDateFilterView.h"


@interface ViewController ()

@property (nonatomic, strong) LLDateFilterView * dataView;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view addSubview:self.dataView];
    
}


- (LLDateFilterView *)dataView {
    if (!_dataView) {
        CGRect frame = CGRectMake(0, 200, self.view.width, 300);
        _dataView = [[LLDateFilterView alloc]initWithFrame:frame buttonTitles:@[@"重置",@"完成"] quickSelected:YES startDate:nil endDate:[NSDate date]];
        __weak typeof(self) weakSelf = self;
        _dataView.finishBlock = ^(LLDateFilterView *bView, NSString *bLeftDate, NSString *bRightDate, NSString * title) {
            if (bLeftDate==nil) {
                [weakSelf.dataView cleanDate];
            }else{                
                [weakSelf.dataView removeFromSuperview];                
                weakSelf.resultLabel.text = [NSString stringWithFormat:@"%@到%@",bLeftDate,bRightDate];
            }
        };
    }
    return _dataView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
