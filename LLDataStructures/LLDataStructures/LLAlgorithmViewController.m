//
//  LLAlgorithmViewController.m
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/21.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLAlgorithmViewController.h"

@interface LLAlgorithmViewController ()

@property (nonatomic,strong) NSMutableArray * arrM;

@end

@implementation LLAlgorithmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.arrM = [NSMutableArray arrayWithObjects:@10,@7,@9,@1,@4,@5,@3,@2,@15, nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self bubbleSort];
//    [self quickSortWithArrM:self.arrM left:0 right:(int)self.arrM.count - 1];
//    [self selectSort];
//    [self binarySearch:1];
//    [self isPrime];
    
    [self fibonacciWithNum:40];
    

}

/**
 快排
 */
- (void)quickSortWithArrM:(NSMutableArray *)arrM left:(int)left right:(int)right {
    int i,j,temp;
    if (left > right) {
        return;
    }
    temp = [arrM[left] intValue];
    i = left;
    j = right;
    while (i < j) {
        // 顺序很重要 一定要先从右往左找
        while ([arrM[j] intValue] >= temp && i<j )  j--;
        while ([arrM[i] intValue] <= temp && i<j) i++;
        [arrM exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    // 最终将基准数归位
    arrM[left] = arrM[i];
    arrM[i] = @(temp);
    
    [self quickSortWithArrM:arrM left:left right:i - 1];
    [self quickSortWithArrM:arrM left:i + 1 right:right];
}

/**
 二分查找法  前提是有序数组
 */
- (void)binarySearch:(int)num {
    NSArray *arr = @[@1,@2,@4,@6,@8,@9,@13,@23,@54,@64,@68];
    int i = 0;
    int j = ((int)arr.count - 1);
    int index = -1;
    while (i<=j) {
        index = (j+i)/2;
        if ([arr[index] intValue] == num) {
            break;
        }else if ([arr[index] intValue] > num){
            j = index - 1;
        }else{
            i = index + 1;
        }
    }
    if (i > j) {
        index = -1;
    };
    NSLog(@"index = %d",index);
}

/**
 选择排序
 */
- (void)selectSort {
    for (int i = 0; i < self.arrM.count - 1; i++) {
        for (int j = i+1; j < self.arrM.count -1; j++) {
            if ([self.arrM[i]intValue] > [self.arrM[j]intValue]) {
                [self.arrM exchangeObjectAtIndex:j withObjectAtIndex:i];
            }
        }
    }
    NSLog(@"%@",self.arrM);
}

/**
 冒泡排序
 */
- (void)bubbleSort {
    for (int i = 0 ; i < self.arrM.count - 1 ; i++) {
        for (int j = 0; j < self.arrM.count - 1 - i; j++) {
            if (self.arrM[j] < self.arrM[j+1]) {
                [self.arrM exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"%@",self.arrM);
}


/**
 打印2到100之间的素数
 */
- (void)isPrime {
    
    for (int i = 2; i<100; i++) {
        for (int j = 2; j <= sqrt(i) ; j++) {
            if ((i & j) != 0) {
                NSLog(@"%zd",i);
            }
        }
    }
}

/**
 斐波那契数列 打印出 num 之前的斐波那契数列 后一个数是前两个数之和
 */
- (void)fibonacciWithNum:(int)num {
    
    NSMutableArray *arrM = [NSMutableArray array];
    arrM[0] = @0;
    arrM[1] = @1;
    NSLog(@"%@\n",arrM[0]);
    NSLog(@"%@\n",arrM[1]);
    for (int i = 2; i < num; i++) {
        arrM[i] = @([arrM[i - 1] intValue] + [arrM[i-2] intValue]);
        NSLog(@"%@\n",arrM[i]);
    }
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
