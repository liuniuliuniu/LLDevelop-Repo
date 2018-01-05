//
//  LLTreeViewController.m
//  LLDataStructures
//
//  Created by niuniu on 2018/1/3.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import "LLTreeViewController.h"
#import "LLTree.h"

@interface LLTreeViewController ()

@end

@implementation LLTreeViewController{
    LLTree root;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}




/**
 二叉树的插入
 @param T 二叉树
 @param key 插入Key
 @return 成功返回true 失败返回false
 */
- (int)insertTree:(LLTree)T key:(int)key {
    LLTree path,sert;
    if (![self searchTree:T Key:key fatherT:NULL path:path]) { //  查找不成功
        sert = malloc(sizeof(LLTree));
        sert->data = key;
        sert->firstChild = sert->rightSib = NULL;
        if (!path) {
            T = sert;  // 插入s为新的跟结点
        }else if (key < path->data) {
            path->firstChild = sert;  // 插入s为左结点
        }else {
            path->rightSib = sert;  // 插入s为右结点
            return true;
        }
    }
    
    return false;
}

/**
 二叉树的查找

 @param T 二叉树
 @param key 查找二叉树中的key
 @param fatherT father指向T的双亲，最初设置为null
 @param path 若查找成功， 则指针p指向该数据元素结点，并返回true
 @return  否则指针p指向查找路径上访问的最后一个结点并返回false
 */
- (int)searchTree:(LLTree)T Key:(int)key fatherT:(LLTree)fatherT path:(LLTree)path {
    if (!T) {
        path = fatherT;
        return false;
    }else if (key == T->data) {
        path = T;
        return true;
    }else if (key < T->data) {
        return [self searchTree:T->firstChild Key:key fatherT:T path:path];
    }else {
        return [self searchTree:T->rightSib Key:key fatherT:T path:path];
    }
}


// 后序遍历二叉树
- (void)postOrderTraverse:(LLTree)T {
    if (T == NULL) return;
    [self preOrderTraverse:T->firstChild]; // 先后序遍历左子树
    [self preOrderTraverse:T->rightSib];// 在后序遍历右子树
    NSLog(@"%zd",T->data); // 显示结点数据， 可以更改为其他队结点操作
}

// 中序遍历二叉树
- (void)inOrderTraverse:(LLTree)T {
    if (T == NULL) return;
    [self preOrderTraverse:T->firstChild]; // 中序遍历左子树
    NSLog(@"%zd",T->data); // 显示结点数据， 可以更改为其他队结点操作
    [self preOrderTraverse:T->rightSib];// 最后中序遍历右子树
}

// 前序遍历二叉树
- (void)preOrderTraverse:(LLTree)T {
    if (T == NULL) return;
    NSLog(@"%zd",T->data);// 显示结点数据， 可以更改为其他队结点操作
    [self preOrderTraverse:T->firstChild];// 再先序遍历左子树
    [self preOrderTraverse:T->rightSib]; //  最后先序遍历右子树
}







//创建二叉树由于需要手动输入 此处就不创建了
//- (LLTree)createTree{
//
//
//
//
//
//}






@end
