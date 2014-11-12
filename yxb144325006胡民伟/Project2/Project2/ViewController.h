//
//  ViewController.h
//  Project2
//
//  Created by Cocoa on 14/11/4.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cal.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong,nonatomic) Cal *cal;
@property (strong,nonatomic) NSString *currentExpr;
@property (strong,nonatomic) NSString *memoryValue;

//输入表达式
- (IBAction)inputExpr:(UIButton *)sender;

//AC清空
- (IBAction)ALLClear:(UIButton *)sender;

//计算结果
- (IBAction)calResult:(UIButton *)sender;

//回删
- (IBAction)backDelete:(UIButton *)sender;

//清空寄存器
- (IBAction)memoryClear:(UIButton *)sender;

//寄存器加运算
- (IBAction)memoryAdding:(UIButton *)sender;

//寄存器减运算
- (IBAction)memorySubtraction:(UIButton *)sender;

//显示寄存器值
- (IBAction)memoryShow:(UIButton *)sender;

@end

