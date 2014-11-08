//
//  Calculator.m
//  Project2
//
//  Created by 陆钟豪 on 14/11/5.
//  Copyright (c) 2014年 陆钟豪. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (instancetype) init {
    self = [super init];
    _display = @"0";
    _nowOp = @"";
    _opStack = [NSMutableArray new];
    _numStack = [NSMutableArray new];
    _leftBracketCount = 0;
    _m = [NSDecimalNumber decimalNumberWithString:@"0"];
    _isError = false;
    return self;
}

+ (NSUInteger) computeSignificantDigit:(NSString*) numStr{
    NSUInteger sum = 0;
    for(NSUInteger i = 0; i < [numStr length]; ++i) {
        unichar c = [numStr characterAtIndex:i];
        if('0' <= c && c <= '9') {
            ++sum;
        }
    }
    return sum;
}

- (void) setDisplay:(NSString*) display {
    if([display containsString:@"e"]) {
        NSDecimalNumber* num = [NSDecimalNumber decimalNumberWithString:display];
        _display = [NSString stringWithFormat:@"%.9e", [num doubleValue]];
    }
    else if([Calculator computeSignificantDigit:display] > 9){
        NSDecimalNumber* num = [NSDecimalNumber decimalNumberWithString:display];
        _display = [NSString stringWithFormat:@"%.9e", [num doubleValue]];
    }
    else {
        _display = display;
    }
}

- (void) calculateStack:(NSInteger) max_priority {
    @try {
        NSString* op = [_opStack lastObject];
        while([_opStack count] > 0 && [Calculator getPriority:op] <= max_priority) {
            if([op isEqualToString:@"("]) {
                [_opStack removeLastObject];
                --_leftBracketCount;
                break;
            }
            [_opStack removeLastObject];
            NSDecimalNumber* postNum = [_numStack lastObject];
            [_numStack removeLastObject];
            NSDecimalNumber* preNum =  [_numStack lastObject];
            [_numStack removeLastObject];
            NSDecimalNumber* resultNum;
            if([op isEqualToString:@"+"]) {
                resultNum = [preNum decimalNumberByAdding:postNum];
            }
            else if([op isEqualToString:@"-"]) {
                resultNum = [preNum decimalNumberBySubtracting:postNum];
            }
            else if([op isEqualToString:@"×"]) {
                resultNum = [preNum decimalNumberByMultiplyingBy:postNum];
            }
            else if([op isEqualToString:@"÷"]){
                resultNum = [preNum decimalNumberByDividingBy:postNum];
            }
            [_numStack addObject:resultNum];
            op = [_opStack lastObject];
        }
    }
    @catch (NSException *exception) {
        [self reset];
        _isError = true;
        [_numStack addObject:[NSDecimalNumber decimalNumberWithString:@"0"]];
    }
}

- (NSString*) pressNum: (NSInteger) num {
    if([_nowOp isEqualToString:@""])
    {
        if([_display containsString:@"e"]) {
            [self setDisplay:[NSString stringWithFormat:@"%ld", (long)num]];
        }
        else if([_display containsString:@"e"] || [Calculator computeSignificantDigit:_display] >= 9) {
            return _display;
        }
        else {
            if([_display isEqualToString:@"0"]) [self setDisplay:@""];
            [self setDisplay:[_display stringByAppendingFormat:@"%ld", (long)num]];
        }
    }
    else {
        // 入栈运算符和操作数
        [_opStack addObject:_nowOp];
        _nowOp = @"";
        NSDecimalNumber* displayNum = [NSDecimalNumber decimalNumberWithString:_display];
        [_numStack addObject:displayNum];
        
        // 清空操作数，键入用户输入
        [self setDisplay:@"0"];
        [self pressNum:num];
    }
    return _display;
}

- (NSString*) pressPoint {
    if([_nowOp isEqualToString:@""]) {
        if([_display containsString:@"e"]) {
            [self setDisplay:[_display stringByAppendingString:@"0."]];
        }
        else if([_display containsString:@"e"] || [Calculator computeSignificantDigit:_display] >= 9) {
            return _display;
        }
        else {
            if([_display containsString:@"."]) return _display;
            [self setDisplay:[_display stringByAppendingString:@"."]];
        }
    }
    else {
        // 入栈运算符和操作数
        [_opStack addObject:_nowOp];
        _nowOp = @"";
        NSDecimalNumber* displayNum = [NSDecimalNumber decimalNumberWithString:_display];
        [_numStack addObject:displayNum];
        
        // 清空操作数，键入用户输入
        [self setDisplay:@"0"];
        [self pressPoint];
    }
    return _display;
}

- (NSString*) pressOperator: (NSString*) op {
    _nowOp = op;
    [_numStack addObject:[NSDecimalNumber decimalNumberWithString:_display]]; // 显示数入栈
    [self calculateStack:[Calculator getPriority:op]]; // 计算运算栈中的算式
    [self setDisplay:[[_numStack lastObject] stringValue]];
    [_numStack removeLastObject];
    return _display;
}


- (NSString*) pressEqual {
    if([_nowOp isEqualToString:@"="]) {
        [_numStack addObject:[NSDecimalNumber decimalNumberWithString:_display]]; // 显示数入栈
        [_opStack addObject:_continueOp];   // 连续运算符入栈
        [_numStack addObject:_continueNum]; // 连续运算操作数入栈
        [self calculateStack:[Calculator getPriority:@"="]]; // 计算运算栈中的算式
        [self setDisplay:[[_numStack lastObject] stringValue]];
        [_numStack removeLastObject];
    }
    else if([_opStack count] > 0 || ![_nowOp isEqualToString:@""]){
        NSDecimalNumber* displayNum = [NSDecimalNumber decimalNumberWithString:_display];
        if(![_nowOp isEqualToString:@""]) {
            // 入栈运算符和操作数
            [_opStack addObject:_nowOp];
            [_numStack addObject:displayNum];
        }
        _nowOp = @"=";
        [_numStack addObject:displayNum]; // 显示数入栈
        _continueOp = [_opStack lastObject];
        _continueNum = [_numStack lastObject];
        [self calculateStack:[Calculator getPriority:@"="]]; // 计算运算栈中的算式
        [self setDisplay:[[_numStack lastObject] stringValue]];
        [_numStack removeLastObject];
    }
    return _display;
}

- (NSString*) reset {
    [self setDisplay:@"0"];
    _nowOp = @"";
    [_opStack removeAllObjects];
    [_numStack removeAllObjects];
    _leftBracketCount = 0;
    _isError =false;
    return _display;
}


- (NSString*) pressLeftBracket {
    [_opStack addObject:@"("];
    ++_leftBracketCount;
    return _display;
}

- (NSString*) pressRightBracket {
    if(_leftBracketCount == 0) return _display;
    [_numStack addObject:[NSDecimalNumber decimalNumberWithString:_display]]; // 显示数入栈
    [self calculateStack:[Calculator getPriority:@")"]]; // 计算运算栈中的算式
    [self setDisplay:[[_numStack lastObject] stringValue]];
    [_numStack removeLastObject];
    return _display;
}

- (NSString*) pressPercent {
    [self setDisplay:[[[NSDecimalNumber decimalNumberWithString:_display] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]] stringValue]];
    return _display;
}

- (NSString*) pressSign {
    [self setDisplay:[[[NSDecimalNumber decimalNumberWithString:_display] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]] stringValue]];
    return _display;
}

- (NSString*) pressBackspace {
    if([_nowOp isEqualToString:@"="]) {
        _nowOp = @"";
    }
    if([_nowOp isEqualToString:@""]) {
        if([_display containsString:@"e"]) {
            [self setDisplay:@"0"];
        }
        else {
            [self setDisplay:[_display substringToIndex:[_display length] - 1]];
            if([_display isEqualToString:@""]) [self setDisplay:@"0"];
        }
    }
    else {
        _nowOp = @"";
    }
    return _display;
}


- (void) pressMPlus {
    NSDecimalNumber* displayNum = [NSDecimalNumber decimalNumberWithString:_display];
    _m = [_m decimalNumberByAdding:displayNum];
}

- (void) pressMSub {
    NSDecimalNumber* displayNum = [NSDecimalNumber decimalNumberWithString:_display];
    _m = [_m decimalNumberByAdding:displayNum];
}

- (void) pressMClear {
    _m = [NSDecimalNumber decimalNumberWithString:@"0"];
}

- (NSString*) pressMRead {
    [self setDisplay:[_m stringValue]];
    return _display;
}

- (BOOL) isError {
    return _isError;
}

+ (NSInteger) getPriority:(NSString*) op {
    if([op isEqualToString:@"+"] || [op isEqualToString:@"-"]) {
        return 1;
    }
    else if([op isEqualToString:@"×"] || [op isEqualToString:@"÷"]) {
        return 2;
    }
    else if([op isEqualToString:@"("] || [op isEqualToString:@")"]) {
        return 1024;
    }
    else {
        return 2048;
    }
}

@end
