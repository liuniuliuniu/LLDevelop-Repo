//
//  LLQueue.c
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/31.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#include "LLQueue.h"
#include <stdlib.h>
#include <malloc/malloc.h>


void initQueue(LLLinkQueue **q) {
    *q = malloc(sizeof(LLLinkQueue));
    (*q)->front = (*q)->rear = (QNode *)malloc(sizeof(QNode));
    (*q)->front->next = NULL;
}

void enQueue(LLLinkQueue *queue, QElemtType elem) {
    QueuePtr temp = malloc(sizeof(QNode));
    if (temp && queue->rear) {
        temp->data = elem;
        temp->next = NULL;
        queue->rear->next = temp;
    }
}

QElemtType deQueue(LLLinkQueue *q) {
    if (q->rear == q->front) {
        return 0;
    }
    QueuePtr temp = q->front->next;
    if (q->front->next == q->rear) {
        q->rear = q->front;
    }
    q->front->next = q->front->next->next;
    return temp->data;
}

size_t LLQueueSize(LLLinkQueue *q) {
    QNode *p = q->front;
    int totalSize = 0;
    while (p != q->rear && p) {
        size_t size = malloc_size(p);
        totalSize += size;
        p = p->next;
    }
    return totalSize;
}

int LLQueueCount(LLLinkQueue *q) {
    QNode *temp = q->front;
    int count = 0;
    while (temp != q->rear) {
        count++;
        temp = temp->next;
    }
    return count;
}



