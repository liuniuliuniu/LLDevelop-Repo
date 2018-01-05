//
//  LLOrderLinkNode.h
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/30.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#ifndef LLOrderNode_h
#define LLOrderNode_h
#include <stdio.h>

#define MAXSIZE 20
typedef int ElemtType;
typedef struct Sqlist{
    ElemtType data[MAXSIZE]; // 数组存取数据元素, 最大值为 MAXSIZE
    int length; // 线性表当前长度
}Sqlist;



#endif /* LLOrderLinkNode_h */
