//
//  Calculator.h
//  Project2
//
//  Created by 陆钟豪 on 14/11/5.
//  Copyright (c) 2014年 陆钟豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject
{
    NSString*           _display;               // 显示的数字
    NSString*           _nowOp;                 // 当前运算符
    NSMutableArray*     _opStack;               // 运算符栈
    NSMutableArray*     _numStack;              // 操作符栈
    NSInteger           _leftBracketCount;      // 运算符栈中左括号的数量
    NSString*           _continueOp;            // 连续运算符
    NSDecimalNumber*    _continueNum;           // 连续运算操作数
    NSDecimalNumber*    _m;                     // M存储器
    BOOL                _isError;
}

- (instancetype) init;
- (NSString*) pressNum: (NSInteger) num;
- (NSString*) pressPoint;
- (NSString*) reset;
- (NSString*) pressOperator: (NSString*) op;
- (NSString*) pressEqual;
- (NSString*) pressLeftBracket;
- (NSString*) pressRightBracket;
- (NSString*) pressPercent;
- (NSString*) pressSign;
- (NSString*) pressBackspace;
- (void) pressMPlus;
- (void) pressMSub;
- (void) pressMClear;
- (NSString*) pressMRead;
- (BOOL) isError;

+ (NSInteger) getPriority:(NSString*) op;

@end
