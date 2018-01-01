//
//  LLDoubleLinkNode.h
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/30.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#ifndef LLDoubleLinkNode_h
#define LLDoubleLinkNode_h

#include <stdio.h>

typedef int LLElemType;

typedef struct LLDulNode {
    LLElemType data;
    struct LLDulNode *prior; // 前驱指针
    struct LLDulNode *next; //  后驱指针
}LLDulNode;

void * initDoubleLinkNode(void);

#endif /* LLDoubleLinkNode_h */
