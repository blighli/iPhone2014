//
//  InfixToPostfix.m
//  calculator
//
//  Created by Van on 14/11/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "InfixToPostfix.h"
#import "Stack.h"

@implementation InfixToPostfix

- (NSString*) parseInfix: (NSString*) infixExpression{
    if ( ! [self hasBalancedBrackets:infixExpression]){
        NSLog(@"表达式出错，括号不匹配");
        return nil;
    }
    Stack * opStack = [[Stack alloc] init];
    NSMutableString * output = [NSMutableString stringWithCapacity:[infixExpression length]];
    NSArray * tokens = [self tokenize: infixExpression];
    for (NSString *token in tokens){
        if ([self precedenceOf:token] != 0){
            NSString *op = [opStack peek];
            NSLog(@"op is %@",op);
            while (op && [self precedenceOf:op] != 0 &&
                   [self precedenceOf: op isHigherOrEqualThan: token]) {
                [output appendString: [NSString stringWithFormat: @"%@ ", [opStack pop]]];
                op = [opStack peek];
            }
            [opStack push:token];
            
        } else if ([token compare: @"("] ==0){
            [opStack push:token];
        } else if ([token compare: @")"] ==0) {
            NSString  * op = [opStack pop];
            while ( op  && ([op compare: @"("] != 0)){
                [output appendString: [NSString stringWithFormat: @"%@ ", op]];
                op = [opStack pop];
            }
            if ( ! op || ([op compare: @"("]  != 0)){
                NSLog(@"Error : unbalanced brackets in expression");
                return nil;
            }
        } else {
            [output appendString: [NSString stringWithFormat: @"%@ ", token]];
        }
    }
    while (! [opStack empty]) {
        [output appendString: [NSString stringWithFormat: @"%@ ", [opStack pop]]];
    }
    return [output stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
//处理表达式
- (NSArray*) tokenize: (NSString*) expression {
    NSMutableArray * tokens = [NSMutableArray arrayWithCapacity:[expression length]];
    NSLog(@"expression is %@",expression);
    unichar c;
    NSMutableString * numberBuf = [NSMutableString stringWithCapacity: 25];
    int length = (int)[expression length];
    BOOL nextMinusSignIsNegativeOperator = YES;
    
    for (int i = 0; i< length; i++){
        c = [expression characterAtIndex: i];
        switch (c) {
            case '+':
            case '/':
            case '*':
                nextMinusSignIsNegativeOperator = YES;
                [self addNumber: numberBuf andToken: c toTokens:tokens];
                break;
            case '(':
            case ')':
                nextMinusSignIsNegativeOperator = NO;
                [self addNumber: numberBuf andToken: c toTokens:tokens];
                break;
            case '-':
                if (nextMinusSignIsNegativeOperator){
                    nextMinusSignIsNegativeOperator = NO;
                    [numberBuf appendString : [NSString stringWithCharacters: &c length:1]];
                } else {
                    nextMinusSignIsNegativeOperator = YES;
                    [self addNumber: numberBuf andToken: c toTokens:tokens];
                }
                
                break;
            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
            case '0':
            case '.':
                nextMinusSignIsNegativeOperator = NO;
                [numberBuf appendString : [NSString stringWithCharacters: &c length:1]];
                break;
            case ' ':
                break;
            default:
                NSLog(@"出现无法识别的字符串");
                break;
        }
    }
    if ([numberBuf length] > 0)
        [tokens addObject:  [NSString stringWithString: numberBuf]];
    NSLog(@"token is %@",tokens);
    return tokens;
}

- (void) addNumber:(NSMutableString*) numberBuf andToken:(unichar) token toTokens : (NSMutableArray*) tokens{
    if ([numberBuf length] > 0){
        [tokens addObject:  [NSString stringWithString: numberBuf]];
        [numberBuf setString:@""];
    }
    [tokens addObject: [NSString stringWithCharacters: &token length:1]];			
}

//比较运算的优先级
- (BOOL) precedenceOf: (NSString*) operator isHigherOrEqualThan: (NSString*) otherOperator{
    return  [self precedenceOf: operator]  >=  [self precedenceOf: otherOperator];
}
//根据运算符给出运算的优先级
- (NSUInteger) precedenceOf: (NSString*) operator{
    if ([operator compare: @"+"] == 0 )
        return 1;
    else if ([operator compare: @"-"] == 0 )
        return 1;
    else if ([operator compare: @"*"] == 0 )
        return 2;
    else if ([operator compare: @"/"] == 0 )
        return 2;
    else //其他无效的操作符
        return 0;
}
//param mark 判断括号是否成对出现
- (BOOL) hasBalancedBrackets:(NSString*) expression{
    
    unichar c;
    int opened = 0, closed = 0;
    
    for (int i = 0; i< [expression length] ; i++){
        c = [expression characterAtIndex: i];
        if (c == '(') opened++;
        else if (c == ')') closed++;
    }
    return opened == closed;
}

@end
