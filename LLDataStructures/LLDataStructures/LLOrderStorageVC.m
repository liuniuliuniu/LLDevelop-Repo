//
//  LLOrderStorageVC.m
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/30.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLOrderStorageVC.h"
#include "LLOrderNode.h"

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0
typedef int Status;


@interface LLOrderStorageVC ()

@end

@implementation LLOrderStorageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /**
     顺序存储线性表
     
     优点:
         无需为表示表中元素之间逻辑关系而增加额外的存储空间
         可以快速的存取表中任意位置的元素
     
     缺点:
         插入和删除操作需要移动大量元素
         当线性表长度变化较大时,难以确定存储空间的容量
         造成存储空间的浪费          
     */
}

// 向顺序线性表中删除一个元素 删除算法
Status ListDelete(Sqlist *L,int i,ElemtType e){

    int k;
    if (L->length == 0)  return ERROR;

    if (i < L->length || i > L->length) return ERROR;
    
    e = L->data[i-1];
    if (i <= L->length) {
        for (k = i ; k<L->length; k++) {
            L->data[k-1] = L->data[k];
        }
    }
    L->length--;
    return OK;
}


// 向顺序线性表中插入一个元素  插入算法
Status ListInsert(Sqlist *L,int i,ElemtType e){
    int k;
    if (L->length == MAXSIZE) {
        return ERROR;
    }
    if (i < 1 || i > L->length+1) {
        return ERROR;
    }
    if (i <= L->length) {
        for (k = L->length - 1 ; k >= i - 1; k--) {
            L->data[k+1] = L->data[k];
        }
    }
    L->data[i-1] = e;
    L->length++;
    return OK;
}





@end
