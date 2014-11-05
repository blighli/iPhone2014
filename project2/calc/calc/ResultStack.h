//
//  ResultStack.h
//  calc
//
//  Created by zhou on 14/11/4.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Operation) {
  NUL = 0,
  PLUS,
  MINUS,
  MULTIPLY,
  DIVIDE,
  EQUAL,
  SGN,
  PERCENT
};
#define OpString(enum)                                                         \
  [@[                                                                          \
    @"NUL",                                                                    \
    @"PLUS",                                                                   \
    @"MINUS",                                                                  \
    @"MULTIPLY",                                                               \
    @"DIVIDE",                                                                 \
    @"EQUAL",                                                                  \
    @"SGN",                                                                    \
    @"PERCENT"                                                                 \
  ] objectAtIndex:enum]

@interface ResultStack : NSObject
@property NSString *console;   //实时显示输入屏幕
@property NSString *memoryReg; //寄存器
@property NSString *expersion; //显示历史输入算式（无优先级）

@property NSString *lvaueStack; //左值堆栈
@property Operation opStack;    //操作符堆栈
@property BOOL isLastPushNum;   //上一次push是否是一元操作符（number、sgn、percent）

- (id)init;
- (void)pushNum:(NSString *)number;
- (void)pushDot;
- (void)popNum;
- (void)pushOperation:(Operation)operater;
- (void)clear;

- (void)memoryWrite;
- (void)memoryClear;
- (void)memoryRead;

@end
