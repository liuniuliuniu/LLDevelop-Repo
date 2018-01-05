//
//  LLStack.h
//  LLDataStructures
//
//  Created by niuniu on 2018/1/4.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#ifndef LLStack_h
#define LLStack_h

#include <stdio.h>


/*
**********栈的顺序存储结构**********
 */
typedef int Status;
#define MAXSIZE 20
typedef int SElemtType;

// 节点的节点结构
typedef struct SqStack {
    SElemtType data[MAXSIZE];
    int top; // 用于栈顶指针
}SqStack;


// 进栈操作  插入元素e为新的栈顶元素
Status Push(SqStack *S,SElemtType e);

// 出栈操作
Status Pop(SqStack *S,SElemtType e);




/*
 **********栈的链式存储结构**********
 */
typedef struct StackNode {
    SElemtType data;
    struct StackNode *next;
}StackNode,*LinkStackPtr;

typedef struct LinkStack {
    LinkStackPtr top;
    int count;
}LinkStack;

// 链栈 插入新的元素e为新的栈顶元素
Status LinkPush(LinkStack *S,SElemtType e);


Status LinkPop(LinkStack *S,SElemtType e);




#endif /* LLStack_h */
