//
//  ViewController.m
//  LLDataStructures
//
//  Created by 奥卡姆 on 2017/12/20.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "ViewController.h"
#import "LLLinkedStorageVC.h"
#import "LLAlgorithmViewController.h"
#import "LLOrderStorageVC.h"
#import "LLDoubleLinkedViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (IBAction)algorithmAction:(id)sender {
    LLAlgorithmViewController *algorithmVC = [LLAlgorithmViewController new];
    [self.navigationController pushViewController:algorithmVC animated:YES];
}

- (IBAction)doubleLinkStorageAction:(id)sender {
    LLDoubleLinkedViewController *vc = [LLDoubleLinkedViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}




- (IBAction)linkedStorageAction:(id)sender {
    LLLinkedStorageVC *vc = [LLLinkedStorageVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)orderStorageAction:(id)sender {
    LLOrderStorageVC *vc = [LLOrderStorageVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
