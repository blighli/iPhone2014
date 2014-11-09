//
//  ResultStack.h
//  calc
//
//  Created by zhou on 14/11/4.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Operation.h"


@interface ResultStack : NSObject
@property NSString *console;   //实时显示输入屏幕
@property NSString *memoryReg; //寄存器
@property NSString *expersion; //显示历史输入算式（无优先级）


@property Stack* opStackArr; //操作符栈
@property Stack* valueStackArr; //数值栈


@property BOOL isLastPushItemUnaryable;   //上一次push的item是否可一元操作（eg: number、sgn、percent）
@property BOOL isConsoleWriteToStackable;  //记录console label可否被写入数值栈(eg:中途显示的结果就不可写入)



- (id)init;
- (void)pushNum:(NSString *)number;
- (void)pushDot;
- (void)popNum;
-(void) pushOp:(OPTYPE)operater;
- (void)clear;

- (void)memoryAdd;
- (void)memoryMinus;
- (void)memoryClear;
- (void)memoryRead;

@end
