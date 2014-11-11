//
//  ViewController.h
//  CaculatorHW
//
//  Created by StarJade on 14-11-8.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import <UIKit/UIKit.h>

//1、将每个按键的无需响应的情况剔除后交给Model部分处理
//2、管理Memory的保存情况并控制M的显示。
//取余符号用 m 代表
@interface ViewController : UIViewController

// 动作过滤函数

//数字与小数点
- (void)numberActionFilter:(char)ch;
//操作符
- (void)opActionFilter:(char)ch;



@end

