//
//  LLDoubleLinkNode.c
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/30.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#include "LLDoubleLinkNode.h"
#include <stdlib.h>

void * initDoubleLinkNode(){
    LLDulNode *p = malloc(sizeof(LLDulNode));
    p->data = 0;
    p->prior = p;
    p->next = p;
    return p;
}
