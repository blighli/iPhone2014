//
//  Calculator.m
//  Machine
//
//  Created by Chen.D.guanhong on 14/11/8.
//  Copyright (c) 2014年 Chen.D.guanhong. All rights reserved.
//

#import "Calculator.h"

@interface Calculator()
@property (strong,nonatomic) NSMutableArray *valStack;
@property (strong,nonatomic) NSMutableArray *stack;
@end

@implementation Calculator
@synthesize valStack = _valStack;


-(NSMutableArray *)valStack
{
    if (_valStack == nil) {
        _valStack = [[NSMutableArray alloc]init];
    }
    return _valStack;
}

-(NSMutableArray *)stack
{
    if (_stack == nil) {
        _stack = [[NSMutableArray alloc]init];
    }
    return _stack;
}
//操作数进栈(用于计算结果)
-(void)pushVal:(double)operand
{
    [self.valStack addObject:[NSNumber numberWithDouble:operand]];
}
//操作数出栈（用于计算结果）
-(double)popVal
{
    NSNumber *operand = [self.valStack lastObject];
    if(self.valStack)[self.valStack removeLastObject];
    return [operand doubleValue];
}


//进栈（用于中缀转后缀）
-(void)push:(NSString *)s
{
    [self.stack addObject:s];
}
//出栈（用于中缀转后缀）
-(void)pop
{
    if (self.stack) [self.stack removeLastObject];
}
//求栈顶元素（用于中缀转后缀）
-(NSString *)top
{
    return [self.stack lastObject];
}
//优先级（用于中缀转后缀）
-(int)level:(NSString *)s
{
    int level = 0;
    if ([s isEqualToString:@"("])
        level = 0;
    if ([s isEqualToString:@"+"]||[s isEqualToString:@"-"])
        level = 1;
    if ([s isEqualToString:@"*"]||
        [s isEqualToString:@"/"]||
        [s isEqualToString:@"%"])
        level = 2;
    return level;
}

//字符串转为NSString的数组，每个NSString代表一个操作数或者运算符
-(NSMutableArray *)stringParser:(NSString *)str
{
    NSMutableArray *expression = [[NSMutableArray alloc]init];
    NSCharacterSet *operators = [NSCharacterSet characterSetWithCharactersInString:@"+-*/%()"];
    NSUInteger len = str.length;
    NSString *number =@"";
    for (int i = 0; i < len; ++i) {
        char c = [str characterAtIndex:i];
        //如果是符号，符号之前的那个数字进数组，然后符号直接进数组
        if ([operators characterIsMember:c]) {
            if (![number isEqualToString:@""]) {
                [expression addObject:number];
                number = @"";
            }
            [expression addObject:[NSString stringWithFormat:@"%c",c]];
        }
        //如果是数字，暂时存入number
        else
            number = [number stringByAppendingString:[NSString stringWithFormat:@"%c",c]];
        //通常最后一个字符不是符号，需要特殊处理最后呆在number里的数字
        if (i == len - 1 && ![number isEqualToString:@""]) {
            [expression addObject:number];
        }
    }
    return expression;
}

//遍历NSString数组,中缀转后缀
-(NSMutableArray *)in2Post:(NSMutableArray *)infix
{
    NSMutableArray *postfix = [[NSMutableArray alloc]init];
    NSUInteger len = [infix count];
    for (int i = 0; i < len; ++i) {
        NSString *s = infix[i];
        //s为(直接进栈
        if ([s isEqualToString:@"("]) [self push:s];
        //s为+ or -,与栈顶比较优先级，小于等于的话栈顶元素出栈,最后s进栈
        else if ([self level:s] == 1){
            while ([self.stack count] && [self level:s]<=[self level:[self top]]) {
                [postfix addObject:[self top]];
                [self pop];
            }
            [self push:s];
        }
        //s为* or / or %，直接进栈
        else if ([self level:s] == 2)  [self push:s];
        //s为 ),栈内(之前的全部出栈
        else if ([s isEqualToString:@")"]) {
            while ([self.stack count]) {
                if ([[self top] isEqualToString:@"("]) {
                    [self pop];
                    break;
                }
                [postfix addObject:[self top]];
                [self pop];
            }
        }
        //数字直接进postfix
        else
            [postfix addObject:s];
    }
    //最后弹出栈内剩余符号进postfix
      while ([self.stack count]) {
        [postfix addObject:[self top]];
        [self pop];
    }
    
    return postfix;
}
//利用后缀数组表达式求值
-(double)evaluate:(NSMutableArray *)postfix
{
    NSUInteger len = [postfix count];
    for (int i = 0; i < len; ++i) {
        if ([postfix[i] isEqualToString:@"+"])
        {
            double b = [self popVal];
            double a = [self popVal];
            [self pushVal:a + b];
        }
        else if ([postfix[i] isEqualToString:@"-"])
        {
            double b = [self popVal];
            double a = [self popVal];
            //当只剩一个元素，后pop的a值为0，结果为-b，所以不用特意处理负数开头的情况
            [self pushVal:a - b];
        }
        else if ([postfix[i] isEqualToString:@"*"])
        {
            double b = [self popVal];
            double a = [self popVal];
            [self pushVal:a * b];
        }
        else if ([postfix[i] isEqualToString:@"/"])
        {
            double b = [self popVal];
            double a = [self popVal];
            [self pushVal:a / b];
        }
        else if ([postfix[i] isEqualToString:@"%"])
        {
            double b = [self popVal];
            double a = [self popVal];
            [self pushVal:(double)((int)a%(int)b)];
        }
        else
            [self pushVal:[postfix[i] doubleValue]];
    }
    return [self popVal];
}

@end
