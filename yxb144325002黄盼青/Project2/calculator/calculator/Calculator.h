//
//  Calculator.h
//  calculator
//
//  Created by 黄盼青 on 14/11/8.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

@property (strong,nonatomic) NSMutableDictionary *priority;//优先级约定
@property (strong,nonatomic) NSMutableArray *operatorStack;//运算符栈
@property (strong,nonatomic) NSMutableArray *outputValueArray;//输出值数组（储存后缀表达式）

//初始化优先级设置
-(void)settingPriority;

//清空栈
-(void)clearStack;

//推入输出值数组
-(void)pushOutputValue:(NSString *)withInputValue;


//查找NSString内是否存在某些字符中的一个
-(BOOL)orContainsString:(NSString *) origin withContains:(NSArray *) contains;

//中缀转后缀
-(void)pushOperatorStack:(NSString *)withOperatorSymbol;

//全部出栈
-(void)popAllOperatorStack;

//判断操作符优先级
-(NSInteger)comparePriority:(NSString *)operator1 withOperator:(NSString *)operator2;

//后缀表达式求值
-(NSDecimalNumber *)calculateOutputResult;

//基础运算
-(NSDecimalNumber *)basicCalculate:(NSString *)symbol withNumber1:(NSString *)number1 withNumber2:(NSString *)number2;
@end
