//
//  LLTree.h
//  LLDataStructures
//
//  Created by niuniu on 2018/1/3.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#ifndef LLTree_h
#define LLTree_h

#include <stdio.h>

#define NULLKEY '?'

typedef int QElemtType;
typedef struct LLNode{
    QElemtType data;
    struct LLNode *firstChild,*rightSib;
}LLNode,*LLTree;


#endif /* LLTree_h */
