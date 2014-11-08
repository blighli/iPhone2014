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
@property (strong,nonatomic) NSMutableArray *opStack;
@end

@implementation Calculator
@synthesize valStack = _valStack;
@synthesize opStack = _opStack;


-(NSMutableArray *)valStack
{
    if (_valStack == nil) {
        _valStack = [[NSMutableArray alloc]init];
    }
    return _valStack;
}
-(NSMutableArray *)opStack
{
    if (_opStack == nil) {
        _opStack = [[NSMutableArray alloc]init];
    }
    return _opStack;
}
//操作数进栈
-(void)pushVal:(double)operand
{
    [self.valStack addObject:[NSNumber numberWithDouble:operand]];
}
//操作数出栈
-(double)popVal
{
    NSNumber *operand = [self.valStack lastObject];
    if(self.valStack)[self.valStack removeLastObject];
    return [operand doubleValue];
}
//运算符进栈
-(void)pushOp:(NSString *)op
{
    [self.opStack addObject:op];
}
//运算符出栈
-(NSString *)popOp
{
    NSString *op = [self.opStack lastObject];
    if (self.opStack) [self.opStack removeLastObject];
    return op;
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
        if ([operators characterIsMember:c]) {
            if (![number isEqualToString:@""]) {
                [expression addObject:number];
                number = @"";
            }
            [expression addObject:[NSString stringWithFormat:@"%c",c]];
        }
        else
            number = [number stringByAppendingString:[NSString stringWithFormat:@"%c",c]];
        if (i == len - 1 && ![number isEqualToString:@""]) {
            [expression addObject:number];
        }
    }
    [expression insertObject:@"(" atIndex:0];
    [expression addObject:@")"];
    return expression;
}

//遍历NSString数组利用栈求表达式的值
-(double)evaluate:(NSMutableArray *)expression
{
    while ([expression count] > 0) {
        NSString *s = [expression firstObject];
        if ([s isEqualToString:@"("])
            [self pushOp:s];
        else if ([s isEqualToString:@"+"])
            [self pushOp:s];
        else if ([s isEqualToString:@"-"])
            [self pushOp:s];
        else if ([s isEqualToString:@"*"])
            [self pushOp:s];
        else if ([s isEqualToString:@"/"])
            [self pushOp:s];
        else if ([s isEqualToString:@"%"])
            [self pushOp:s];
        else if ([s isEqualToString:@")"])
        {
            while (self.opStack.count) {
                NSString *op = [self popOp];
                if ([op isEqualToString:@"("])  break;
                double result = [self popVal];
                if ([op isEqualToString:@"+"])
                    result = [self popVal] + result;
                else if ([op isEqualToString:@"-"])
                    result = [self popVal] - result;
                else if ([op isEqualToString:@"*"])
                    result = [self popVal] * result;
                else if ([op isEqualToString:@"/"])
                    result = [self popVal] / result;
                else if ([op isEqualToString:@"%"])
                    result = (int)[self popVal] % (int)result;
                [self pushVal:(double)result];
            }
        }
        else
            [self pushVal:[s doubleValue]];
        [expression removeObjectAtIndex:0];
    }
    return  [self popVal];
}

@end
