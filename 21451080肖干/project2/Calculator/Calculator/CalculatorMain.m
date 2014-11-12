//
//  CalculatorMain.m
//  Calculator
//
//  Created by xiaoo_gan on 11/6/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "CalculatorMain.h"

@implementation CalculatorMain

@synthesize memeryNumber;
@synthesize result;
@synthesize bracketCount;
@synthesize valueStackLacation;

- (NSMutableArray *) numberStack {
    if (!_numberStack) {
        _numberStack = [NSMutableArray arrayWithCapacity:20];
    }
    return _numberStack;
}
- (NSMutableArray *) operationStack {
    if (!_operationStack) {
        _operationStack = [NSMutableArray arrayWithCapacity:20];
    }
    return _operationStack;
}
- (NSMutableArray *) valueStack {
    if (!_valueStack) {
        _valueStack = [NSMutableArray arrayWithCapacity:50];
    }
    return _valueStack;
}

//计算主体
- (void) answerOperation:(NSString *) valueText {
    [self postfixToSuffix:valueText];
    [self evalPostfix];
    result = [self lastNumberStack];
    [self clearAll];
}

//判断是否是操作符
-(BOOL) isOperation:(NSString *)op {
    if ([@"+" isEqualToString:op]) {
        return YES;
    } else if ([@"-" isEqualToString:op]) {
        return YES;
    } else if ([@"×" isEqualToString:op]) {
        return YES;
    } else if ([@"÷" isEqualToString:op]) {
        return YES;
    }
    return NO;
}

//判断是否是数字字符
- (BOOL) isNumber:(NSString *)num {
    if([@"0" isEqualToString:num]) {
        return YES;
    } else if([@"1" isEqualToString:num]) {
        return YES;
    } else if([@"2" isEqualToString:num]) {
        return YES;
    } else if([@"3" isEqualToString:num]) {
        return YES;
    } else if([@"4" isEqualToString:num]) {
        return YES;
    } else if([@"5" isEqualToString:num]) {
        return YES;
    } else if([@"6" isEqualToString:num]) {
        return YES;
    } else if([@"7" isEqualToString:num]) {
        return YES;
    } else if([@"8" isEqualToString:num]) {
        return YES;
    } else if([@"9" isEqualToString:num]) {
        return YES;
    } else if([@"." isEqualToString:num]) {
        return YES;
    } else {
        return NO;
    }
}
//判断操作符的优先级
- (NSInteger) priority:(NSString *)op {
    if ([@"(" isEqualToString:op]) {
        return 0;
    } else if ([@"+" isEqualToString:op] || [@"-" isEqualToString:op]) {
        return 1;
    } else if ([@"×" isEqualToString:op] || [@"÷" isEqualToString:op]) {
        return 2;
    } else {
        return -1;
    }
}
//将中缀表达式转为后缀表达式
- (void) postfixToSuffix:(NSString *) postfix {
    NSInteger i = 0;
    [self addOperationStack:@"＝"];
    while (![[self subValueStack:postfix index:i] isEqualToString:@"＝"]) {
        NSString *iValueStack = [self subValueStack:postfix index:i];
        if ([self isNumber:iValueStack]) {
            [self.valueStack addObject:iValueStack];
        } else if([@"(" isEqualToString:iValueStack]) {
            [self addOperationStack:iValueStack];
        } else if([@")" isEqualToString:iValueStack]) {
            while (![@"(" isEqualToString:[self lastOperationStack]]) {
                [self.valueStack addObject:[self lastOperationStack]];
                [self.operationStack removeLastObject];
            }
            [self.operationStack removeLastObject];
        } else if([self isOperation:iValueStack]) {
            [self.valueStack addObject:@" "];
            while ([self priority:[self lastOperationStack]] >= [self priority:iValueStack]) {
                [self.valueStack addObject:[self lastOperationStack]];
                [self.operationStack removeLastObject];
            }
            [self addOperationStack:iValueStack];
        }
        i ++;
    }
    while ([self lastOperationStack] != nil) {
        [self.valueStack addObject:[self lastOperationStack]];
        [self.operationStack removeLastObject];
    }
}

//读取数值，即将字符串转化为数字
- (double) readNumber{
    double x = 0.0;
    NSInteger leftBracket = 0;
    while ([self isNumber:[self valueStackAtIndex:valueStackLacation]]) {
        if (![[self valueStackAtIndex:valueStackLacation] isEqualToString:@"."]) {
            double temp = [[self valueStackAtIndex:valueStackLacation] doubleValue];
            x = x * 10 + temp;
            valueStackLacation ++;
        } else {
            valueStackLacation ++;
            while ([self isNumber:[self valueStackAtIndex:valueStackLacation]]) {
                double temp = [[self valueStackAtIndex:valueStackLacation] doubleValue];
                x = x * 10 + temp;
                valueStackLacation ++;
                leftBracket ++;
            }
        }
    }
    while (leftBracket != 0) {
        x = x / 10.0;
        leftBracket --;
    }
    return x;
}

//计算
- (void) evalPostfix {
    valueStackLacation = 0;
    double num1, num2;
    while (![[self valueStackAtIndex:valueStackLacation] isEqualToString:@"＝"]) {
        if ([self isNumber:[self valueStackAtIndex:valueStackLacation]]) {
            [self addNumberStack:[self readNumber]];
        } else if([[self valueStackAtIndex:valueStackLacation] isEqualToString:@" "]) {
            valueStackLacation ++;
        } else {
            num1 = [self lastNumberStack];
            num2 = [self lastNumberStack];
            double num = [self operate:num2 operator:[self valueStackAtIndex:valueStackLacation] numb:num1];
            [self addNumberStack:num];
            valueStackLacation ++;
        }
    }
}

//读取字符栈中位置为index的字符
- (NSString *) valueStackAtIndex:(NSInteger) index {
    return [self.valueStack objectAtIndex:index];
}

//读取中缀字符串中的单个字符
- (NSString *) subValueStack:(NSString *) postfix index:(NSInteger) i {
    NSRange range = NSMakeRange(i, 1);
    return [postfix substringWithRange:range];
}

//将数值添加到数值栈中
- (void) addNumberStack:(double) number {
    [self.numberStack addObject:[NSNumber numberWithDouble:number]];
}

//读取数值栈的栈顶数值，并将其出栈
- (double) lastNumberStack {
    double num = [[self.numberStack lastObject] doubleValue];
    [self.numberStack removeLastObject];
    return num;
}

//将操作符添加到临时操作符栈中
- (void) addOperationStack:(NSString *)operation {
    [self.operationStack addObject:operation];
}

//返回临时操作符栈的栈顶字符
- (NSString *) lastOperationStack {
    return [self.operationStack lastObject];
}

//对操作符进行运算
- (double) operate:(double) a operator:(NSString *) op numb:(double) b {
    double tmp;
    if ([@"+" isEqualToString:op]) {
            tmp = a + b;
        } else if ([@"-" isEqualToString:op]) {
            tmp = a - b;
        } else if ([@"×" isEqualToString:op]) {
            tmp = a * b;
        } else if ([@"÷" isEqualToString:op]) {
            tmp = a / b;
        };
    return tmp;
}

//记忆功能

// 记忆数值清除
- (void) memClear {
    memeryNumber = 0;
    NSLog(@"MC: 记忆的数 = %g",memeryNumber);
}
// 将记忆数值和当前屏幕上的数值相加
- (void) memAdd:(double) number {
    memeryNumber = memeryNumber + number;
    NSLog(@"M+: 记忆的数 = %g",memeryNumber);
}
// 将记忆数值和当前屏幕上的数值相减
- (void) memSub:(double)memNum {
    memeryNumber = memeryNumber - memNum;
    NSLog(@"M-: 记忆的数 = %g",memeryNumber);
}

//清除所有数据
- (void) clearAll {
    [self.valueStack removeAllObjects];
    [self.numberStack removeAllObjects];
    [self.operationStack removeAllObjects];
    bracketCount = 0;
}

//纪录左括号数
- (void) addBracketCount {
    bracketCount ++;
}
- (void) subBrackCount {
    bracketCount --;
}

@end
