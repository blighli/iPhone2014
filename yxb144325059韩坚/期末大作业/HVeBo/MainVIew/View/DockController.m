//
//  DockController.m
//  HVeBo
//
//  Created by HJ on 14/12/14.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "DockController.h"
#import "Dock.h"

#define kDockHeight 44

@interface DockController () <DockDelegate>

@end
@implementation DockController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加Dock
    [self addDock];
}

#pragma mark 添加Dock
- (void)addDock
{
    Dock *dock = [[Dock alloc] init];
    dock.frame = CGRectMake(0, self.view.frame.size.height - kDockHeight, self.view.frame.size.width, kDockHeight);
    dock.delegate = self;
    [self.view addSubview:dock];
    _dock = dock;
}

#pragma mark dock的代理方法
- (void)dock:(Dock *)dock itemSelectedFrom:(NSInteger)from to:(NSInteger)to
{
    if (to < 0 || to >= self.childViewControllers.count) return;
    
    // 0.移除旧控制器的view
    UIViewController *oldVc = self.childViewControllers[from];
    [oldVc.view removeFromSuperview];
    
    // 1.取出即将显示的控制器
    UIViewController *newVc = self.childViewControllers[to];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - kDockHeight;
    newVc.view.frame = CGRectMake(0, 0, width, height);
    
    // 2.添加新控制器的view到MainController上面
    [self.view addSubview:newVc.view];
    //得到最新的控制器
    _selectController = newVc;
}
@end
