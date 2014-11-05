//
//  ResultStack.m
//  calc
//
//  Created by zhou on 14/11/4.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "ResultStack.h"
#import "StrCalcMethod.h"

@implementation ResultStack

- (id)init
{
    if (self = [super init])
    {
        self.console = @"0";
        self.memoryReg = @"0";
        self.expersion = @"";
        self.lvaueStack = @"";
        self.opStack = NUL;
        self.isLastPushNum = NO;
    }

    return self;
}

- (void)pushNum:(NSString *)number
{
    /**
   *  如果上次的操作符是等号，则重新开始新的计算
   *  TODO : 支持连续等号来重复上次操作（需要增加栈的一个深度）
   */
    if (self.opStack == EQUAL)
    {
        self.expersion = @"";
        self.lvaueStack = @"";
        self.opStack = NUL;
    }

    //如果上次操作不是一元操作符，则这之后期待输入右值。因此console清零
    if (!self.isLastPushNum)
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
    self.isLastPushNum = YES;
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

- (void)pushOperation:(Operation)operater
{
    //当前屏幕上的数值记录为右值
    NSString *rvalue = self.console;

    //当上一次输入为二元操作符时,在表达式记录栏记录右值
    if (operater != SGN && operater != PERCENT) {
          self.expersion = [self.expersion stringByAppendingString:rvalue];
    }
    
    
    

   // NSLog(@"运算前栈中op: %@,lv%@,rv%@,exp%@", OpString(self.opStack), self.lvaueStack, rvalue, self.expersion);

    // init 左值
    if (self.opStack == NUL && operater != SGN && operater != PERCENT)
    {
        self.lvaueStack = self.console;
    }
    //如果左值堆栈和操作符堆栈都不为空，且当前操作符是二元操作符则更新左值
    if (self.opStack != NUL && ![self.lvaueStack isEqualToString:@""] && operater!=SGN && operater != PERCENT)
    {
        switch (self.opStack)
        {
            case PLUS:
                self.lvaueStack =
                    [StrCalcMethod deciPlus:self.lvaueStack withString:rvalue];

                break;
            case MINUS:
                self.lvaueStack =
                    [StrCalcMethod deciMinus:self.lvaueStack withString:rvalue];
                break;

            case DIVIDE:
                if ([rvalue doubleValue] == 0)
                {
                    self.lvaueStack = @"除数不能为零";
                    break;
                }
                self.lvaueStack =
                    [StrCalcMethod deciDivide:self.lvaueStack withString:rvalue];
                break;
            case MULTIPLY:
                self.lvaueStack =
                    [StrCalcMethod deciMultiply:self.lvaueStack withString:rvalue];
                break;
            default:
                break;
        }

        //    case SGN:
        //        self.lvaueStack =
        //        [StrCalcMethod deciMultiply:self.lvaueStack withString:@"-1"];
        //        //self.expersion = self.lvaueStack ;
        //        break;
        //    case PERCENT:
        //        self.lvaueStack =
        //        [StrCalcMethod deciMultiply:self.lvaueStack withString:@"0.01"];
        //        //self.expersion = self.lvaueStack ;
        //        break;
    }
    
    
    //将当前操作符存入栈中，如果是一元操作符，则立刻更新左值，原操作符不变
    switch (operater)
    {
        case PLUS:
            self.expersion = [self.expersion stringByAppendingString:@"+"];
            self.isLastPushNum = NO;
            self.opStack = PLUS;
            self.console = self.lvaueStack;
            break;
        case MINUS:
            self.expersion = [self.expersion stringByAppendingString:@"−"];
            self.isLastPushNum = NO;
            self.opStack = MINUS;
            self.console = self.lvaueStack;
            break;
        case MULTIPLY:
            self.expersion = [self.expersion stringByAppendingString:@"×"];
            self.isLastPushNum = NO;
            self.opStack = MULTIPLY;
            self.console = self.lvaueStack;
            break;
        case DIVIDE:
            self.expersion = [self.expersion stringByAppendingString:@"÷"];
            self.isLastPushNum = NO;
            self.opStack = DIVIDE;
            self.console = self.lvaueStack;
            break;
        case EQUAL:
            self.expersion = @"";
            self.opStack = NUL;
            self.isLastPushNum = NO;
            self.opStack = EQUAL;
            self.console = self.lvaueStack;
            break;
        case SGN:
            rvalue =
                    [StrCalcMethod deciMultiply:rvalue withString:@"-1"];
            
            //self.expersion =  rvalue;
            self.isLastPushNum = YES;
            self.console = rvalue;
            break;
        case PERCENT:
            rvalue =
                   [StrCalcMethod deciMultiply:rvalue withString:@"0.01"];
             //self.expersion =  rvalue;
            self.isLastPushNum = YES;
            self.console = rvalue;
            break;

        default:
            break;
    }
    

  //  NSLog(@"运算后栈中op: %@,lv%@,rv%@,exp%@", OpString(self.opStack), self.lvaueStack, rvalue, self.expersion);
}

- (void)clear
{
    self.console = @"0";
    self.expersion = @"";

    self.opStack = NUL;
    self.lvaueStack = @"";
}

- (void)memoryClear
{
    self.memoryReg = @"0";
}
- (void)memoryWrite
{
    if ([self.console isEqualToString:@""])
    {
        self.memoryReg = @"0";
    }
    else
        self.memoryReg = self.console;
}

- (void)memoryRead
{
    self.console = self.memoryReg;
}

@end
