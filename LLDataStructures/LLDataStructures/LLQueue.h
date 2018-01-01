//
//  LLQueue.h
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/31.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#ifndef LLQueue_h
#define LLQueue_h

#include <stdio.h>

typedef int QElemtType;

// 节点的节点结构
typedef struct QNode {
    QElemtType data;
    struct QNode *next;
}QNode,*QueuePtr;

// 队列的链表结构
typedef struct LLLinkQueue{ // 队头队尾指针
    QueuePtr front;
    QueuePtr rear;
}LLLinkQueue;

// 初始化队列
void initQueue(LLLinkQueue **q);

// 进队
void enQueue(LLLinkQueue *queue, QElemtType elem);

// 出队
QElemtType deQueue(LLLinkQueue *q);

// 获得当前队列大小
size_t LLQueueSize(LLLinkQueue *q);

// 获得当前队列元素
int LLQueueCount(LLLinkQueue *q);

#endif /* LLQueue_h */
