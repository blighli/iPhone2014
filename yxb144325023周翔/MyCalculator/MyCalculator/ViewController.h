//
//  ViewController.h
//  MyCalculator
//
//  Created by 周翔 on 14/11/10.
//  Copyright (c) 2014年 周翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController    {
double ValueMR ;
double left;
double right;
double num1;//左操作数
double num2;//右操作数
BOOL FlagOp;//operator标志
BOOL JudgeLeft;
BOOL FlagDot;
BOOL JudgeBug;
BOOL JudgedotBug;
BOOL bug;
BOOL JudgeOp;
BOOL bug_x;
int rleft,rright;
int LenthDot;
int is_Operator;
NSString *Answer;
NSString *ori;
}

@property (weak, nonatomic) IBOutlet UILabel *display;

- (IBAction) ButtonNumber:(UIButton *)sender; //数字键入
- (IBAction) ButtonOperator:(UIButton *)sender;  //操作输入
- (IBAction) ButtonAC:(UIButton *)sender;    //AC清除
- (IBAction) ButtonSigntrs:(UIButton *)sender;  //正负号转换
- (IBAction) ButtonDot:(UIButton *)sender;   //加.
- (IBAction) Buttonequal:(UIButton *)sender;  //输出
- (IBAction) ButtonMC:(UIButton *)sender;  //MC
- (IBAction) ButtonMPlus:(UIButton *)sender;  //M+
- (IBAction)  ButtonMMinus:(UIButton*)sender;  //M-
- (IBAction) ButtonMR:(UIButton *)sender;  //MR

- (void) AllClear;
- (void) Processing:(int) concequence;    //计算结果
- (NSString *) changeFloat:(double)Right;    //转换类型


@end

