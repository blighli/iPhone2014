//
//  ViewController.h
//  Calculator
//
//  Created by 葛 云波 on 14/11/7.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Stack.h"

@interface ViewController : UIViewController{
    double cache;//缓存
    BOOL hasCache;//是否有缓存
    
    double op1;//存储操作数1
    double op2;//存储操作数2
    double result;//上一次计算的结果缓存
    
    NSString* opc;//当前操作数
    NSInteger lastOp;//上一次操作
    NSInteger isError;//是否存在错误
    int opi;//当前操作数序号
    bool hasPoint;//是否输入了小数点
    int lastInput;//上一次输入的类型，1:数字；2:操作符
}
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *cacheSta;

//------------------------------------------------------------
-(id) init;

//重置状态
-(void) reset;
-(void) resetAll;

//通用的显示刷新
-(void)display:(NSString*) display;
-(void)displayResult:(NSString*)Result;
-(void)displayError:(NSInteger)ErrorID;
-(void)setStatusInfo:(id)ctrl title:(NSString*)title;

//缓存操作
-(void)saveCache;
-(void)saveAntiCache;
-(void)readCache;
-(void)clearCache;

//删除一位数字
-(void)deleteANumber;

//取反
-(void)antiNumber;

//核心处理方法
-(void)inputACommand:(NSInteger)cmd;
-(void)inputANumber:(NSInteger)number;
-(void)inputAOperator:(NSInteger)opt;

//计算结果
-(double)getResult
    :(double)number1
    :(double)number2
    :(NSInteger)operation;
//---------------------------------------------------------------
//按钮的回调

- (IBAction)inputCommand:(id)sender;

- (IBAction)inputNumberic:(id)sender;

- (IBAction)inputOperator:(id)sender;
















@end

