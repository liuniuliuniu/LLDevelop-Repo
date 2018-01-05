//
//  LLDoubleLinkedViewController.m
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/30.
//  Copyright © 2017年 liushaohua. All rights reserved.
/**
 
 双向链表:是单链表的每个结点中,在设置一个指向其前驱结点的指针域
 
 */



#import "LLDoubleLinkedViewController.h"
#import "LLDoubleLinkNode.h"

@interface LLDoubleLinkedViewController ()

@end

@implementation LLDoubleLinkedViewController {
    
    LLDulNode *_linkNode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatLinkChain];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        
    [self printLinkChain:_linkNode];
}

- (void)creatLinkChain {
    _linkNode = initDoubleLinkNode();
    LLDulNode *p = _linkNode;
    for (int i = 0; i<10; i++) {
        LLDulNode *node = malloc(sizeof(LLDulNode));
        node->data = i;
        p->next = node;
        node->prior = p;
        node->next = _linkNode;
        _linkNode->prior = node;
        p = node;
    }
}


- (void)printLinkChain:(LLDulNode *)linkNode {
    LLDulNode *p = linkNode;
    p = p->next;
    while (p != linkNode) {
        NSLog(@"%zd",p->data);
        p = p->next;
    }
}




@end
