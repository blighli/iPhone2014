//
//  Calculator.m
//  calculator
//
//  Created by 黄盼青 on 14/11/8.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

@synthesize operatorStack,outputValueArray,priority;

//初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        outputValueArray=[[NSMutableArray alloc]init];
        operatorStack=[[NSMutableArray alloc]init];
        priority=[[NSMutableDictionary alloc]init];
        [self settingPriority];//初始化优先级约定
    }
    return self;
}

//设置优先级约定
-(void)settingPriority{
    [priority setValue:[NSNumber numberWithInt:0] forKey:@"+"];//加
    [priority setValue:[NSNumber numberWithInt:0] forKey:@"-"];//减
    [priority setValue:[NSNumber numberWithInt:1] forKey:@"×"];//乘
    [priority setValue:[NSNumber numberWithInt:1] forKey:@"÷"];//除
    [priority setValue:[NSNumber numberWithInt:2] forKey:@"("];//左括号
    [priority setValue:[NSNumber numberWithInt:2] forKey:@")"];//右括号
}

//清空栈
-(void)clearStack{
    [operatorStack removeAllObjects];
    [outputValueArray removeAllObjects];
}


//推入输出值数组
-(void)pushOutputValue:(NSString *)withInputValue{
    if(![self orContainsString:withInputValue withContains:@[@"(",@")"]])
    {
        [outputValueArray addObject:withInputValue];
    }
}

//中缀转后缀
-(void)pushOperatorStack:(NSString *)withOperatorSymbol{
    
    //空栈时直接入栈
    if(operatorStack.count==0)
    {
        [operatorStack addObject:withOperatorSymbol];
    }else
    {
        
        //判断是否遇到右括号，如果遇到又括号，直接出栈到最近的左括号为止
        if([withOperatorSymbol isEqualToString:@")"])
        {
            while(![[operatorStack lastObject]isEqualToString:@"("] && [operatorStack lastObject]!=nil)
            {
                [outputValueArray addObject:[operatorStack lastObject]];
                [operatorStack removeLastObject];
            }
            [operatorStack removeLastObject];
        }
        
        
        
        //判断栈顶元素与输入的操作符之间的优先级关系
        NSInteger priorityCompareValue=[self comparePriority:[operatorStack lastObject] withOperator:withOperatorSymbol];
        if(priorityCompareValue<0)
        {
            [operatorStack addObject:withOperatorSymbol];
        }else
        {
            if([self orContainsString:[operatorStack lastObject] withContains:@[@"(",@")"]])
            {
                [operatorStack addObject:withOperatorSymbol];
            }
            else
            {
                
                [outputValueArray addObject:[operatorStack lastObject]];
                [operatorStack removeLastObject];
                
                //递归继续查找栈顶是否大于等于新运算符
                [self pushOperatorStack:withOperatorSymbol];
                
            }
        }
    }
}

//全部出栈
-(void)popAllOperatorStack{
    while(operatorStack.lastObject)
    {
        [self pushOutputValue:[operatorStack lastObject]];
        [operatorStack removeLastObject];
    }
}


//查找NSString内是否存在某些字符中的一个
-(BOOL)orContainsString:(NSString *) origin withContains:(NSArray *) contains{
    if(contains)
    {
        for(int i=0;i<contains.count;i++)
        {
            if([origin isEqualToString:contains[i]])
                return YES;
        }
    }
    return NO;
}

//判断操作符优先级
-(NSInteger)comparePriority:(NSString *)operator1 withOperator:(NSString *)operator2{
    NSInteger operatorNumber1=[[priority valueForKey:operator1] integerValue];
    NSInteger operatorNumber2=[[priority valueForKey:operator2] integerValue];
    return operatorNumber1-operatorNumber2;
}

//后缀表达式求值
-(NSDecimalNumber *)calculateOutputResult{
    while(outputValueArray.count>1)
    {
        for(int i=0;i<outputValueArray.count;i++)
        {
            if([self orContainsString:outputValueArray[i] withContains:@[@"+",@"-",@"×",@"÷"]])
            {
                NSString *_firstNumber=outputValueArray[i-1];
                NSString *_secondNumber=outputValueArray[i-2];
                
                NSDecimalNumber *_result=[self basicCalculate:outputValueArray[i] withNumber1:_firstNumber withNumber2:_secondNumber];
                
                outputValueArray[i]=[_result description];
                [outputValueArray removeObjectAtIndex:i-1];
                [outputValueArray removeObjectAtIndex:i-2];
                break;
                
            }
        }
    }
    return [NSDecimalNumber decimalNumberWithString:[outputValueArray lastObject]];
}

//基础运算
-(NSDecimalNumber *)basicCalculate:(NSString *)symbol withNumber1:(NSString *)number1 withNumber2:(NSString *)number2{
    
    //加运算
    if([symbol isEqualToString:@"+"])
    {
        NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:number1];
        NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:number2];
        
        return [_num2 decimalNumberByAdding:_num1];
    }
    
    //减运算
    if([symbol isEqualToString:@"-"])
    {
        NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:number1];
        NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:number2];
        
        return [_num2 decimalNumberBySubtracting:_num1];
    }
    
    //乘运算
    if([symbol isEqualToString:@"×"])
    {
        NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:number1];
        NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:number2];
        
        return [_num2 decimalNumberByMultiplyingBy:_num1];
    }
    
    //除运算
    if([symbol isEqualToString:@"÷"])
    {
        NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:number1];
        NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:number2];
        
        return [_num2 decimalNumberByDividingBy:_num1];
    }
    
    return nil;
}


@end
