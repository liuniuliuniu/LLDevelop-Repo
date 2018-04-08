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
    
//   BOOL res = [self isValidIP:@"0.0.0.0"];
    
//    [self bubbleSort];
//    [self quickSortWithArrM:self.arrM left:0 right:(int)self.arrM.count - 1];
//    [self selectSort];
//    [self binarySearch:1];
//    [self isPrime];
    
//    [self fibonacciWithNum:40];
    
}


/**
 判断ip是否合法
 */
- (BOOL)isValidIP:(NSString *)ipStr {
    if (nil == ipStr) {
        return NO;
    }    
    NSArray *ipArray = [ipStr componentsSeparatedByString:@"."];
    if (ipArray.count == 4) {
        
        for (int i = 0; i < ipArray.count;i++ ) {
            int ipnumber = [ipArray[i] intValue];
            if (!(ipnumber>=0 && ipnumber<=255)) {
                return NO;
            }
            // 剔除第一位不能为0 的情况
            if (i == 0 && ipnumber <= 0 ) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
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
 插入排序  前提是该数组已经是一个有序表
 */
- (void)insertSort {
    int i,j;
    for ( i = 2; i <= self.arrM.count - 1; i++) {
        if ([self.arrM[i] intValue] < [self.arrM[i-1] intValue]) { // 需要将self.arrM[i-1]插入到有序表中
            self.arrM[0] = self.arrM[i];  // 设置哨兵
            for ( j = i - 1; [self.arrM[j] intValue] > [self.arrM[0] intValue]; j--) {
                self.arrM[j+1] = self.arrM[j]; // 记录后移
            }
            self.arrM[j+1] = self.arrM[0]; // 插入到正确的位置
        }
    }
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

/**
 求一个集合的子集 位运算
 */
- (NSArray *)subsetOfSet:(NSSet *)set {
    NSMutableArray *mutableArray = [NSMutableArray new];
    NSArray *arr = [set allObjects];
    for (int i = 0; i<pow(2, arr.count); i++) {
        int j = i;
        int n = 0;
        NSMutableString *str = [NSMutableString new];
        while (j != 0) {
            if ((j&1) == 1) {
                [str appendString:arr[n]];
            }
            j = j>>1;
            n++;
        }
        [mutableArray addObject:str];
    }
    return mutableArray.copy;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
