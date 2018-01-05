//
//  LLLinkNode.c
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/20.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#include "LLLinkNode.h"
#include <stdlib.h>

void * initLinkNode() {    
    LLLinkNode *p = malloc(sizeof(LLLinkNode));
    p->elem = 0;
    p->next = NULL;
    return p;
}


