//
//  LLLinkedStorageVC.m
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/30.
//  Copyright © 2017年 liushaohua. All rights reserved.
/**
  单链表结构和顺序存储结构的优缺点
 
 存储分配分配方式:
     顺序存储结构用一段连续的存储单元依次存储线性表的数据元素
     单链表采用链式存储结构用一组任意的存储单元存放线性表的元素
 时间性能:
     查找:
         顺序存储结构 O(1);
         单链表 O(n);
     插入和删除
         顺序存储结构需要平均移动表长一半的元素  时间为 O(n)
         单链表在线出某位置的指针后插入和删除  时间仅为 O(1)
 控件性能:
     顺序存储结构需要预分配存储空间,分大了,浪费, 分小了,易发生上溢
     单链表不需要分配存储空间,只要有就可以分配,元素个数也不受限制
 
 */


#import "LLLinkedStorageVC.h"
#import "LLLinkNode.h"

@interface LLLinkedStorageVC ()

@end

@implementation LLLinkedStorageVC{
    LLLinkNode *_link;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatLinkChain];
    [self printLinkChain:_link];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //   [self printLinkChain: [self revertChain:_link]];
    //    [self printLinkChain:[self recrusiveRevertChain:_link]];
    //    [self printLinkChain:[self deleteLinkNodeWithChain:_link]];
    [self printLinkChain:[self deleteLinkChain:_link]];
//    [self printLinkChain:[self insertNode:_link index:7 data:100]];
//    [self printLinkChain:[self deleteNode:_link index:2 data:1]];
    
}

/**
 尾插法 逆序链表
 */
- (LLLinkNode *)revertChain:(LLLinkNode *)link {
    LLLinkNode *p = link;
    p = p->next;
    link->next = NULL;
    while (p != NULL) {
        LLLinkNode *q = p;
        p = p->next;
        q->next = link->next;
        link->next = q;
    }
    return link;
}

/**
 递归法 逆序链表
 */
- (LLLinkNode *)recrusiveRevertChain:(LLLinkNode *)header {
    LLLinkNode *current, *headerNext;
    if (header == NULL || header->next == NULL) return header;
    current = header;
    headerNext = header->next;
    header = [self recrusiveRevertChain:headerNext];
    
    headerNext->next = current;
    current->next = NULL;
    return header;
}

/**
 删除链表中的一个节点
 */
- (LLLinkNode *)deleteNode:(LLLinkNode *)header index:(int)i data:(int)data {
    int j = 1;
    LLLinkNode *p,*q;
    p = header;
    while (p->next && j < i) {
        p = p->next;
        ++j;
    }
    if ( !(p->next) || j > i) {
        return header;
    }
    q = p->next;
    p->next = q->next;
    data = q->elem;
    free(q);
    return header;
}

/**
 链表中插入一个节点
 */
- (LLLinkNode *)insertNode:(LLLinkNode *)header index:(int)i data:(int)data {
    int j = 1;
    LLLinkNode *p,*q;
    p = header;
    while (p && j < i) { //  寻找 第 i-1 个节点
        p = p->next;
        ++j;
    }
    if (!p || j>i) {
        return header; // 返回原链表
    }
    q = (LLLinkNode *)malloc(sizeof(LLLinkNode));// 生成新节点
    q->elem = data;
    q->next = p->next;
    p->next = q;
    return header;
}

/**
 删除链表
 */
- (LLLinkNode *)deleteLinkChain:(LLLinkNode *)header {
    LLLinkNode *p,*q;
    p = header->next;
    while (p) {
        q = p->next;
        free(p);
        p = q;
    }
    header->next = NULL;
    return header;
}


/**
 创建链表
 */
- (void)creatLinkChain {
    _link = initLinkNode();
    LLLinkNode *p = _link;
    for (int i = 0; i <= 10; i++) {
        LLLinkNode *node = malloc(sizeof(LLLinkNode));
        node->elem = i;
        node->next = NULL;
        p->next = node;
        p = node;
    }
}

/**
 打印链表
 */
- (void)printLinkChain:(LLLinkNode *)p {
    
    p = p->next;
    while (p != NULL) {
        NSLog(@"LinkChain:%d",p->elem);
        p = p->next;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

