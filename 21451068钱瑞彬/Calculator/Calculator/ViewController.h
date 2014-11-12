//
//  ViewController.h
//  Calculator
//
//  Created by apple on 14-11-5.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


// 当前数字
@property (nonatomic) NSMutableString* num;

// 是否为小数
@property (nonatomic) BOOL isPoint;

// 当前过程
@property (nonatomic) NSMutableString* pro;

// 左括号个数
@property (nonatomic) double bracketCount;

// 运算结果
@property (nonatomic) double result;

// 是否记忆数字
@property (nonatomic) BOOL isMemory;

// 记忆数字
@property (nonatomic) double memoryNum;

// 前一个操作符
@property (nonatomic) char preOp;


// M是否显示
@property (weak, nonatomic) IBOutlet UILabel *M;
// 计算过程
@property (weak, nonatomic) IBOutlet UITextView *process;

// 输入的数字
@property (weak, nonatomic) IBOutlet UILabel *Number;

// 连接字符串
- (NSString*)contact: (NSString*)s1 : (NSString*)s2;

// 是否为负数
- (BOOL)isNegate:(NSString*)s;


- (NSString*)showState:(id)sender;      // 哪个按钮被按下

- (IBAction)touchNumber:(id)sender;     // 数字事件
- (IBAction)touchPoint:(id)sender;      // 小数点事件

- (IBAction)touchNegate:(id)sender;     // 取负
- (IBAction)touchOperator:(id)sender;   // 运算符事件
- (IBAction)touchBracket:(id)sender;    // 括号

- (IBAction)touchBackSpace:(id)sender;  // X事件
- (IBAction)touchAC:(id)sender;         // AC事件

- (IBAction)touchM:(id)sender;          // M事件

- (IBAction)touchCalc:(id)sender;       // 等号事件




@end



