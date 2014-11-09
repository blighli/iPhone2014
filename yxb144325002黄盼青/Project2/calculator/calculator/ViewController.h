//
//  ViewController.h
//  calculator
//
//  Created by 黄盼青 on 14/11/4.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *displayScreen;//计算器显示屏
@property (strong,nonatomic) Calculator *calculator;//计算器
@property (strong,nonatomic) NSString *currentInputNumber;//当前输入值
@property (strong,nonatomic) NSString *memoryValue;//寄存器
@property (strong, nonatomic) IBOutlet UILabel *memoryLabel;//寄存器标签

//输入数字
- (IBAction)inputNumbers:(UIButton *)sender;
//AC清空
- (IBAction)ACClear:(id)sender;

//输入操作符
- (IBAction)inputOperators:(UIButton *)sender;

//输出结果
- (IBAction)inputResult:(id)sender;

//回删
- (IBAction)backDelete:(id)sender;

//清空寄存器
- (IBAction)memoryClear:(id)sender;

//寄存器加运算
- (IBAction)memoryAdding:(id)sender;

//寄存器减运算
- (IBAction)memorySubtraction:(id)sender;

//显示寄存器值
- (IBAction)memoryRead:(id)sender;

//计算百分数
- (IBAction)percentOperators:(id)sender;
@end

