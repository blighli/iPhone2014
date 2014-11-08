//
//  ExprSolver.m
//  SimpleCalculator
//
//  Created by YilinGui on 14-11-4.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import "ExprSolver.h"

@interface ExprSolver()
@property (nonatomic) BOOL isExprValid;
@property (nonatomic) BOOL divideZeroError;
@property (nonatomic) BOOL modNonIntError;
@property (nonatomic, strong) NSMutableArray *operandStack;
@property (nonatomic, strong) NSMutableArray *operationStack;
@end

@implementation ExprSolver

@synthesize isExprValid = _isExprValid;
@synthesize divideZeroError = _divideZeroError;
@synthesize modNonIntError = _modNonIntError;
@synthesize operandStack = _operandStack;
@synthesize operationStack = _operationStack;

// 判断是否为整形：
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

// 判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

// 计算两个数的运算
- (double)calcNum1:(double)num1 Operation:(NSString *)op Num2:(double)num2 {
    double result = 0.0;
    
    if ([op isEqualToString:@"+"]) {
        result = num1 + num2;
    } else if ([op isEqualToString:@"-"]) {
        result = num2 - num1;
    } else if ([op isEqualToString:@"x"]) {
        result = num1 * num2;
    } else if ([op isEqualToString:@"/"]) {
        if (num1 == 0.0) self.divideZeroError = YES;
        result = num2 / num1;
    } else if ([op isEqualToString:@"%"]) {
        if (![self isPureInt:[NSString stringWithFormat:@"%g", num1]] ||
            ![self isPureInt:[NSString stringWithFormat:@"%g", num2]]) {
            self.modNonIntError = YES;
        } else {
            result = (int)num2 % (int)num1;
        }
    }
    
    return result;
}

// 重写getter
- (NSMutableArray *)operandStack {
    if (_operandStack == nil) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

// 重写getter
- (NSMutableArray *)operationStack {
    if (_operationStack == nil) {
        _operationStack = [[NSMutableArray alloc] init];
    }
    return _operationStack;
}

/* 私有方法 */

// 操作数入栈
- (void)pushOperand:(double)operand {
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

// 操作数出栈
- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

// 操作符入栈
- (void)pushOperation:(NSString *)operation {
    [self.operationStack addObject:operation];
}

// 操作符出栈
- (NSString *)popOperation {
    NSString *operationObject = [self.operationStack lastObject];
    if (operationObject) [self.operationStack removeLastObject];
    return operationObject;
}

// 预处理，分离表达式每个token
- (NSMutableArray *)getExprTokenArray:(NSString *)expr {
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    int i = 0, j = 0;
    BOOL negNum = NO;
    for (; i < [expr length]; ++i) {
        NSString *rangeStr = [NSString stringWithFormat:@"%d 1", i];
        NSString *numRangeStr = [NSString stringWithFormat:@"%d %d", j, i-j];
        if ([[expr substringWithRange:NSRangeFromString(rangeStr)] isEqualToString:@"+"] ||
            [[expr substringWithRange:NSRangeFromString(rangeStr)] isEqualToString:@"-"] ||
            [[expr substringWithRange:NSRangeFromString(rangeStr)] isEqualToString:@"x"] ||
            [[expr substringWithRange:NSRangeFromString(rangeStr)] isEqualToString:@"/"] ||
            [[expr substringWithRange:NSRangeFromString(rangeStr)] isEqualToString:@"("] ||
            [[expr substringWithRange:NSRangeFromString(rangeStr)] isEqualToString:@")"] ||
            [[expr substringWithRange:NSRangeFromString(rangeStr)] isEqualToString:@"%"] ) {
            
            if ([[expr substringWithRange:NSRangeFromString(rangeStr)] isEqualToString:@"-"]) {
                if (i == 0 || [[expr substringWithRange:NSRangeFromString([NSString stringWithFormat:@"%d 1", i-1])] isEqual: @"("]) {
                    negNum = YES;
                    continue;
                }
            }
            
            if ([[expr substringWithRange:NSRangeFromString(numRangeStr)] isEqualToString:@""]) {
                [resultArr addObject:[expr substringWithRange:NSRangeFromString(rangeStr)]];
            } else {
                if (negNum) {
                    [resultArr addObject:[@"-" stringByAppendingString:[expr substringWithRange:NSRangeFromString(numRangeStr)]]];
                    negNum = NO;
                } else {
                    [resultArr addObject:[expr substringWithRange:NSRangeFromString(numRangeStr)]];
                }
                [resultArr addObject:[expr substringWithRange:NSRangeFromString(rangeStr)]];
            }
            j = i + 1;
        }
    }
    if (![[resultArr lastObject] isEqualToString:@")"]) {
        [resultArr addObject:[expr substringWithRange:NSRangeFromString([NSString stringWithFormat:@"%d %lu", j, [expr length]-j])]];
    }
    return resultArr;
}

// 运算符优先级
- (int)getPriorityOfOperation:(NSString *)operation {
    int priority = 0;
    if ([operation isEqualToString:@"%"]) {
        priority = 3;
    } else if ([operation isEqualToString:@"x"] ||
               [operation isEqualToString:@"/"]) {
        priority = 2;
    } else if ([operation isEqualToString:@"+"] ||
               [operation isEqualToString:@"-"]) {
        priority = 1;
    }
    
    return priority;
}

/* 公有方法 */

// 算术表达式求值
- (double)getValueOfExpr:(NSString *)expr {
    double result = 0.0;
    NSMutableArray *tokenArr = [self getExprTokenArray:expr];
    //NSLog(@"%@", [tokenArr description]);
    for (int i = 0; i < [tokenArr count]; ++i) {
        //NSLog(@"%@", [[tokenArr objectAtIndex:i] description]);
        // 当前元素是数值
        if ([self isPureFloat:[tokenArr objectAtIndex:i]] ||
            [self isPureInt:[tokenArr objectAtIndex:i]]) {
            //NSLog(@"%@", [[tokenArr objectAtIndex:i] description]);
            [self pushOperand:[[tokenArr objectAtIndex:i] doubleValue]];  // 操作数入栈
        } else {  // 当前元素为操作符
            if ([self.operationStack count] == 0) {  // 操作符栈空，操作符入栈
                [self pushOperation:[tokenArr objectAtIndex:i]];
            } else if ([self getPriorityOfOperation:[tokenArr objectAtIndex:i]] >
                       [self getPriorityOfOperation:[self.operationStack lastObject]]) {
                // 当前操作符优先级大于栈顶操作符优先级，当前操作符入栈
                [self pushOperation:[tokenArr objectAtIndex:i]];
            } else if ([[tokenArr objectAtIndex:i] isEqualToString: @"("]) {
                // 左括号直接入栈
                [self pushOperation:[tokenArr objectAtIndex:i]];
            } else if ([[tokenArr objectAtIndex:i] isEqualToString: @")"]) {
                // 对右括号特殊判断，操作符出栈计算，直到碰到左括号
                while (1) {
                    NSString *stackTopOperation = [self popOperation];  // 栈顶操作符出栈
                    if ([self.operationStack count] == 0 ||
                        [stackTopOperation isEqualToString:@"("]) {
                        break;
                    }
                    double num1 = [self popOperand];
                    double num2 = [self popOperand];
                    [self pushOperand:[self calcNum1:num1 Operation:stackTopOperation Num2:num2]];
                }
                
            } else {
                // 栈顶操作符出栈，操作数出栈，计算结果作为新操作数入栈
                // 直至栈顶操作符优先级低于当前操作符优先级或操作符栈空，当前操作符入栈
                while (1) {
                    NSString *stackTopOperation = [self popOperation];  // 栈顶操作符出栈
                    double num1 = [self popOperand];
                    double num2 = [self popOperand];
                    [self pushOperand:[self calcNum1:num1 Operation:stackTopOperation Num2:num2]];
                    // 退出条件
                    if ([self.operationStack count] == 0 ||
                        [self getPriorityOfOperation:[tokenArr objectAtIndex:i]] >
                        [self getPriorityOfOperation:[self.operationStack lastObject]]) {
                        [self pushOperation:[tokenArr objectAtIndex:i]];
                        break;
                    }
                }  /* END while */
            }
        }
    }  /* END for */
    
    while (1) {
        // 退出条件
        if ([self.operationStack count] == 0 ||
            [self.operandStack count] == 1) {
            break;
        }
        NSString *stackTopOperation = [self popOperation];  // 栈顶操作符出栈
        double num1 = [self popOperand];
        double num2 = [self popOperand];
        [self pushOperand:[self calcNum1:num1 Operation:stackTopOperation Num2:num2]];
    }  /* END while */
    
    if ([self.operationStack count] == 0 &&
        [self.operandStack count] == 1) {
        self.isExprValid = YES;
        result = [[self.operandStack lastObject] doubleValue];
    } else {
        self.isExprValid = NO;
    }
    
    [self.operandStack removeAllObjects];
    [self.operationStack removeAllObjects];
    _operandStack = nil;
    _operationStack = nil;
    
    //NSLog(@"%g", result);
    return result;
}

- (NSString *)getValueOfExprInStringFormat:(NSString *)expr {
    self.isExprValid = NO;
    self.divideZeroError = NO;
    self.modNonIntError = NO;
    NSString *resultStr = nil;
    
    // 调用getValueOfExpr，如果表达式合法，在该方法中将isExprValid设为YES
    double resultNum = [self getValueOfExpr:expr];
    
    if (self.divideZeroError) {
        resultStr = @"Cannot divide 0!";
        return resultStr;
    }
    
    if (self.modNonIntError) {
        resultStr = @"Only intergers have % operation!";
        return resultStr;
    }
    
    if (self.isExprValid) {
        resultStr = [NSString stringWithFormat:@"%g", resultNum];
    } else {
        resultStr = @"Invalid Expression!";
    }
    
    return resultStr;
}

@end
