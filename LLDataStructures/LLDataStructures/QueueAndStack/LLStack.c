//
//  LLStack.c
//  LLDataStructures
//
//  Created by niuniu on 2018/1/4.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#include "LLStack.h"
#include <stdlib.h>
#include <malloc/malloc.h>

// 进栈操作  插入元素e为新的栈顶元素
Status Push(SqStack *S,SElemtType e){
    if (S->top == MAXSIZE - 1) {
        return 0;
    }
    S->top++; // 栈顶指针增加1
    S->data[S->top] = e; // 将新插入的元素赋值给栈顶空间
    return 1;
}

// 若栈不空，则删除S的栈顶元素，用e返回其值，并返回1 否则返回0
Status Pop(SqStack *S,SElemtType e) {
    if (S->top == -1) {
        return 0;
    }
    e = S->data[S->top]; // 将要删除的栈顶元素赋值给 e
    S->top--; // 栈顶指针减一
    return 1;
}


// 链栈 插入新的元素e为新的栈顶元素
Status LinkPush(LinkStack *S,SElemtType e) {
    LinkStackPtr p = (LinkStackPtr)malloc(sizeof(StackNode));
    p->data = e;
    p->next = S->top;// 把当前的栈顶元素赋值给新结点的直接后继，
    S->top = p;// 将新的结点s赋值给栈顶指针 
    S->count++;
    return 1;
}

// 若栈不空，则删除S的栈顶元素，用e返回其值，并返回ok，否则返回error
Status LinkPop(LinkStack *S,SElemtType e) {
    LinkStackPtr p;
    if (!S) {
        return 0;
    }
    e = S->top->data;
    p = S->top; // 将栈顶结点赋值给p
    S->top = S->top->next; // 使得栈顶指针下移一位，指向后一结点
    free(p);// 释放结点p
    S->count--;
    return 1;
}


