//
//  ResultStack.m
//  calc
//
//  Created by zhou on 14/11/4.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "ResultStack.h"
#import "StrCalcMethod.h"

@interface ResultStack ()
@property int LbraceCount;

@end

@implementation ResultStack

- (id)init
{
    if (self = [super init])
    {
        self.console = @"0";
        self.memoryReg = @"0";
        self.expersion = @"";

        self.LbraceCount = 0;

        self.isLastPushItemUnaryable = NO;
        self.isConsoleWriteToStackable = NO;

        self.opStackArr = [[Stack alloc] init];
        [self.opStackArr push:[[Operation alloc] initWithOPS:NUL]];
        self.valueStackArr = [[Stack alloc] init];
    }

    return self;
}

- (void)pushNum:(NSString *)number
{
    //如果上次push item不可一元操作，则这之后期待输入新的右值。因此console清零
    if (!self.isLastPushItemUnaryable)
    {
        self.console = @"0";
    }

    // limit the length of number
    if (self.console.length < 16)
    {
        // limit the 0 on the top

        if ([self.console isEqualToString:@"0"])
        {
            if ([number isEqualToString:@"."])
            {
                [self pushDot];
            }
            else
            {
                self.console = @"";
                self.console = [self.console stringByAppendingString:number];
            }
        }
        else
        {
            if ([number isEqualToString:@"."])
            {
                [self pushDot];
            }
            else
            {
                self.console = [self.console stringByAppendingString:number];
            }
        }
    }
    self.isLastPushItemUnaryable = YES;
    self.isConsoleWriteToStackable = YES;
}

// limit the . is show only once
- (void)pushDot
{
    NSRange range = [self.console rangeOfString:@"."];
    if (range.length == 0 && range.location == NSNotFound)
    {
        self.console = [self.console stringByAppendingString:@"."];
    }
}

- (void)popNum
{
    NSUInteger length = self.console.length;
    if (length > 1)
    {
        self.console = [self.console substringToIndex:length - 1];
    }
    else
    {
        self.console = @"0";
    }
}

- (void)runStack
{
    Operation *opLast = [self.opStackArr top];



    if (opLast.opType == RBRACE)
    {
        [self.opStackArr pop];
        [self runStack];
        opLast = [self.opStackArr top];
    }
    
    else if (opLast.opType == LBRACE)
    {
        [self.opStackArr pop];
        opLast = [self.opStackArr top];
       // [self runStack];
        //return;
    }

    //操作栈为空时,停止递归
    if (opLast.opType == NUL)
    {
        return;
    }
    else if (opLast.opType != NUL && opLast.opType != LBRACE && opLast.opType != RBRACE)
    {
        NSString *rvalue = [self.valueStackArr top];
        [self.valueStackArr pop];                    //弹出右值
        NSString *lvalue = [self.valueStackArr top]; //读取左值
        [self.valueStackArr pop];                    //弹出左值

        NSString *result = [StrCalcMethod calcWithOpType:lvalue withRStr:rvalue withOP:opLast.opType];
        [self.valueStackArr push:result]; //更新值栈
        [self.opStackArr pop];            //弹出上次操作符

        [self runStack];
    }
}
- (void)pushOp:(OPTYPE)opEnum
{
    if (!self.isLastPushItemUnaryable && opEnum != LBRACE)
    {
        return;
    }

    Operation *opLast = [self.opStackArr top];
    if (self.isConsoleWriteToStackable && opEnum != LBRACE)
    {
        [self.valueStackArr push:self.console];
    }

    Operation *opNow = [[Operation alloc] initWithOPS:opEnum];

    //弹出所有栈
    if (opNow.opType == EQUAL)
    {
        [self runStack];
        self.console = [self.valueStackArr top];
        self.expersion = @"";
        self.LbraceCount = 0;

        self.isLastPushItemUnaryable = YES;

        return;
    }

    NSString *rvalue = [self.valueStackArr top];

    if (opNow.isBinaryOperator)
    {
        if (opNow.priority < opLast.priority) // 将之前的栈中的高优先级的操作计算掉
        {
            [self runStack];
            [self.opStackArr push:opNow];
            if (opNow.opType != LBRACE && opLast.opType != RBRACE && self.isLastPushItemUnaryable)
            {
                self.expersion = [self.expersion stringByAppendingString:rvalue];
            }

            self.expersion = [self.expersion stringByAppendingString:opNow.name]; //更新表达式label

            self.isLastPushItemUnaryable = NO; //双目运算符不可被一元操作符运算
        }
        else if (opNow.priority == opLast.priority) //相同优先级可以合并前两个操作值的计算结果,并存入堆栈
        {
            if (opLast.opType == LBRACE)
            {
                return;
            }
            if (opNow.opType == RBRACE)
            {
                if (self.LbraceCount >= 0)
                {
                    [self.opStackArr push:opNow];
                    self.LbraceCount--;
                }
            }
            else
            {
                [self.valueStackArr pop];                    //弹出右值
                NSString *lvalue = [self.valueStackArr top]; //读取左值
                [self.valueStackArr pop];                    //弹出左值
                NSString *result = [StrCalcMethod calcWithOpType:lvalue withRStr:rvalue withOP:opLast.opType];
                [self.valueStackArr push:result]; //更新值栈
                [self.opStackArr pop];            //弹出上次操作符
                [self.opStackArr push:opNow];     //更新操作符栈
                //   [self runStack];
                //  [self.opStackArr push:opNow];
                if (opNow.opType != LBRACE && self.isLastPushItemUnaryable)
                {
                    self.expersion = [self.expersion stringByAppendingString:rvalue];
                }
            }

            if (opNow.opType == RBRACE)
            {
                if (self.LbraceCount >= 0)
                {
                    self.expersion = [self.expersion stringByAppendingString:opNow.name]; //更新表达式label
                    self.isConsoleWriteToStackable = NO;
                    self.isLastPushItemUnaryable = YES;
                }
            }
            else
            {
                self.expersion = [self.expersion stringByAppendingString:opNow.name]; //更新表达式label
                self.isLastPushItemUnaryable = NO;                                    //双目运算符不可被一元操作符运算
            }
        }
        else //仅仅push到操作符栈,不计算
        {
            //如果push 的是 Lbrace 则将优先级调至最低
            if (opNow.opType == LBRACE)
            {
                opNow.priority = InLBracePri;

                self.LbraceCount++;
            }

            if (opNow.opType == RBRACE)
            {
                if (self.LbraceCount >= 0)
                {
                    [self.opStackArr push:opNow];
                    self.LbraceCount--;
                }
            }

            else
            {
                [self.opStackArr push:opNow]; //更新操作符栈
            }

            if (opNow.opType != LBRACE && self.isLastPushItemUnaryable)
            {
                self.expersion = [self.expersion stringByAppendingString:rvalue];
            }

            if (opNow.opType == RBRACE)
            {
                if (self.LbraceCount >=0)
                {
                    self.expersion = [self.expersion stringByAppendingString:opNow.name]; //更新表达式label
                    self.isConsoleWriteToStackable = NO;
                    self.isLastPushItemUnaryable = YES;
                }
            }
            else
            {
                self.expersion = [self.expersion stringByAppendingString:opNow.name]; //更新表达式label
                self.isLastPushItemUnaryable = NO;                                    //双目运算符不可被一元操作符运算
            }
        }
    }
    else
    {
        //单目运算符 立刻更新值栈,操作栈不变

        NSString *lvalue = [self.valueStackArr top]; //读取左值
        [self.valueStackArr pop];

        // 对于单目运算 RStr is not necessary
        NSString *result = [StrCalcMethod calcWithOpType:lvalue withRStr:@"" withOP:opNow.opType];
        [self.valueStackArr push:result]; //更新值栈

        self.isLastPushItemUnaryable = YES; //单目运算符可被一元操作符运算
        self.isConsoleWriteToStackable = NO;
    }

    if ([self.valueStackArr top] == nil)
    {
        self.console = @"0";
    }
    else
        self.console = [self.valueStackArr top]; // 更新计算结果label
}

- (void)clear
{
    self.console = @"0";
    self.expersion = @"";

    [self.opStackArr empty];
    [self.opStackArr push:[[Operation alloc] initWithOPS:NUL]];

    [self.valueStackArr empty];
}

- (void)memoryClear
{
    self.memoryReg = @"0";
}
- (void)memoryAdd
{
    self.memoryReg = [StrCalcMethod deciPlus:self.memoryReg withString:self.console];
}

- (void)memoryMinus
{
    if (![self.memoryReg isEqualToString:@""])
    {
        self.memoryReg = [StrCalcMethod deciMinus:self.memoryReg withString:self.console];
    }
}

- (void)memoryRead
{
    self.console = self.memoryReg;
}

@end
