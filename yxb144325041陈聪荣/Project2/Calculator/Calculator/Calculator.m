//
//  Calculator.m
//  Calculator
//
//  Created by 陈聪荣 on 14/11/12.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (id)init{
    if(self = [super init]){
        momery = 0.0;
    }
    return self;
}

//单步操作
- (double) singleStepOperation:(NSString *) oldValue withOper:(NSString *) oper{
    double oldValueDouble = [oldValue doubleValue];
    if ([oper isEqualToString:@"±"]) { //取反操作
        oldValueDouble =  -oldValueDouble;
    }else if([oper isEqualToString:@"%"]){ //百分号操作
        oldValueDouble =  oldValueDouble/100;
    }else{
        //M寄存操作
        if([oper isEqualToString:@"M+"]){
            oldValueDouble = momery + oldValueDouble;
            momery = oldValueDouble;
        }else if([oper isEqualToString:@"M-"]){
            oldValueDouble = momery - oldValueDouble;
            momery = oldValueDouble;
        }else if([oper isEqualToString:@"MC"]){
            momery = 0.0;
            oldValueDouble = momery;
        }else if([oper isEqualToString:@"MR"]){
            oldValueDouble = momery;
        }
    }
    return oldValueDouble;
}


//带括号的浮点型四则混合运算
- (double) multiStepOperation:(NSString *) expression{
    return [handleContainBrackets(expression) doubleValue];
}
//判断四则运算的优先级
int prior(NSString *op) {
    if ([op isEqualToString:@"+"] || [op isEqualToString:@"-"])
        return 1;
    if ([op isEqualToString:@"×"] || [op isEqualToString:@"÷"])
        return 2;
    return 0;
}
//判断是不是数学计算符，不包含”(“，“)”
BOOL isOper(NSString *s){
    if([s isEqualToString:@"+"]) return YES;
    if([s isEqualToString:@"-"]) return YES;
    if([s isEqualToString:@"×"]) return YES;
    if([s isEqualToString:@"÷"]) return YES;
    return NO;
}

//匹配浮点数^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$
NSNumber *handleContainBrackets(NSString *middle){
    //检查算式的正确性TODO
    //将数字和运算符截取出来加入数组
    NSMutableArray *middleArray = [NSMutableArray arrayWithCapacity:20];
    NSMutableString *temp = [NSMutableString stringWithCapacity:20];
    //标示正在组成浮点数
    BOOL flag = NO;
    for (int i=0; i<middle.length; i++) {
        char ch = [middle characterAtIndex:i];
        if((ch >='0' && ch <= '9') || ch=='.'){
            [temp appendString:[NSString stringWithFormat:@"%c", ch]];
            flag = YES;
        }else{
            if(flag){
                [middleArray addObject:temp];
                temp = [NSMutableString stringWithCapacity:20];
                flag = NO;
            }
            [middleArray addObject:[NSString stringWithFormat:@"%c", ch]];
        }
    }
    if(flag){
        [middleArray addObject:temp];
    }
    //将带括号的中缀表达式转换为后缀表达式
    NSMutableArray *stack = [NSMutableArray arrayWithCapacity:20];
    NSMutableArray *lastArray = [NSMutableArray arrayWithCapacity:20];
    for (int i = 0; i<middleArray.count; i++) {
        NSString *s = [middleArray objectAtIndex:i];
        if([s isEqualToString: @"("]){
            [stack addObject:s];
        }else{
            if([s isEqualToString: @")"]){
                while (![[stack lastObject] isEqualToString:@"("]) {
                    [lastArray addObject:[stack lastObject]];
                    [stack removeLastObject];
                }
                [stack removeLastObject];
            }else if(isOper(s)){
                if ([stack count] == 0){
                    [stack addObject:s];
                }else{
                    if (prior(s) > prior([stack lastObject])) {
                        [stack addObject:s];
                    }else{
                        while ([stack count ]!= 0 && prior(s) <= prior([stack lastObject])) {
                            [lastArray addObject:[stack lastObject]];
                            [stack removeLastObject];
                        }
                        [stack addObject:s];
                    }
                }
            }else{
                [lastArray addObject:s];
            }
        }
    }
    while (stack.count != 0) {
        [lastArray addObject:[stack lastObject]];
        [stack removeLastObject];
    }
    //计算后缀表达式的值
    for (int i=0; i<lastArray.count; i++) {
        NSString *s = [lastArray objectAtIndex:i];
        //判断是否为运算符,数字压入栈底
        if(!isOper(s)){
            [stack addObject:[NSNumber numberWithFloat:[s floatValue]]];
        }else{
            double right = [[stack lastObject]doubleValue];
            [stack removeLastObject];
            double left = [[stack lastObject]doubleValue];
            [stack removeLastObject];
            double result = 0.0;
            if([s isEqualToString:@"+"]){
                result = left + right;
            }else if([s isEqualToString:@"-"]){
                result = left - right;
            }else if([s isEqualToString:@"×"]){
                result = left * right;
            }else if([s isEqualToString:@"÷"]){
                result = left / right;
            }
            [stack addObject:[NSNumber numberWithDouble:result]];
        }
    }
    return [stack lastObject];
}


@end
