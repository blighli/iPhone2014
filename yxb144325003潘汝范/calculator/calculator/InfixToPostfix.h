//
//  InfixToPostfix.h
//  calculator
//
//  Created by Van on 14/11/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfixToPostfix : NSObject

- (NSString*) parseInfix: (NSString*) infixExpression;
- (NSArray*) tokenize: (NSString*) expression;
- (NSUInteger) precedenceOf: (NSString*) operator;
- (BOOL) hasBalancedBrackets:(NSString *)expression;
- (BOOL) precedenceOf : (NSString*) operator isHigherOrEqualThan: (NSString*) otherOperator;
- (void) addNumber:(NSMutableString*) numberBuf andToken:(unichar) token toTokens : (NSMutableArray*) tokens;

@end
