//
//  LLLinkNode.h
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/20.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#ifndef LLLinkNode_h
#define LLLinkNode_h


typedef int LLElemType;

typedef struct LLLinkNode {
    LLElemType elem;
    struct LLLinkNode *next;
}LLLinkNode;

// 初始化链表节点
void * initLinkNode(void);

#endif /* LLLinkNode_h */
