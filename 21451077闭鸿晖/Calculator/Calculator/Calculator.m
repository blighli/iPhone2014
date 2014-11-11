//
//  Calculator.m
//  Calculator
//
//  Created by turbobhh on 11/5/14.
//  Copyright (c) 2014 org.bhh.homework. All rights reserved.
//

#import "Calculator.h"
#import "MyStack.h"

@implementation Calculator
static NSString* ERROR=@"表达式不合法";
static double MR=0;
+(NSString*)mr{
    return [NSString stringWithFormat:@"%lf",MR];
}
+(void)mc{
    MR=0;
}
+(void)mPlus:(NSString*)plus{
    if ([plus isEqualToString:ERROR]) return;
    MR+=[plus doubleValue];
}
+(void)mSubtract:(NSString*)sub{
    if ([sub isEqualToString:ERROR]) return;
    MR-=[sub doubleValue];
}

typedef struct MyNumber{
    double value;
    bool isSuccess;//标示解析数字过程中，表达式是否合法
}MyNumber;

//解析数字,同时改编主循环的i,返回结构体，
+(MyNumber)getNumber:(int*)i exp:(NSString*)exp{
    
    MyNumber myNumber;
    myNumber.value=0;
    myNumber.isSuccess=true;
    NSMutableString* number=[[NSMutableString alloc] init];
    int p=*i;
    
    while (p<exp.length&&(([exp characterAtIndex:p]<='9'&&[exp characterAtIndex:p]>='0')||
                          [exp characterAtIndex:p]=='.')) [number appendFormat:@"%c",[exp characterAtIndex:p++]];
    
    int count=0;
    for (int j=0; j<number.length; j++) {
        if ([number characterAtIndex:j]=='.') ++count;
        if (count>1){ myNumber.isSuccess=false;return myNumber; }//小数点个数大于1不合法
    }
    
    
    *i=p-1;//更新主循环的i
    myNumber.value=[number doubleValue];
    return myNumber;
}

//中缀式转后缀式
+(NSArray*)getPostExp:(NSString*)exp{
    MyStack* stack=[[MyStack alloc] init];
    NSMutableArray* postExp=[[NSMutableArray alloc] init];

    int p=0;//开始时判断第一个字符是否为+或-
    if ([exp characterAtIndex:p]=='+'||[exp characterAtIndex:p]=='-') {
        p++;
        char op=[exp characterAtIndex:p];
        MyNumber myNumber= [self getNumber:&p exp:exp];
        if (op=='+') [postExp addObject:  [NSString stringWithFormat:@"%lf",myNumber.value]];
        else [postExp addObject:  [NSString stringWithFormat:@"%lf",-myNumber.value]];
        p++;

    }
    for (int i=p; i<exp.length; i++) {
        char ch=[exp characterAtIndex:i];
        switch (ch) {
            case '+':
            case '-':
                while (!stack.isEmpty&&![stack.top isEqualToString:@"("]) [postExp addObject:[stack pop]];
                [stack push:[NSString stringWithFormat:@"%c",ch]];
                break;
            case '*':
            case '/':
            case '%':
                while (!stack.isEmpty&&([stack.top isEqualToString:@"*"]||
                                        [stack.top isEqualToString:@"/"]||
                                        [stack.top isEqualToString:@"%"]))
                    [postExp addObject:[stack pop]];
                [stack push:[NSString stringWithFormat:@"%c",ch]];
                
                break;
            case '(':
                [stack push:[NSString stringWithFormat:@"%c",ch]];
                //左括号右边是+号或-号,则把符号连带数字加入后缀是末尾
                if (i+1<exp.length&&([exp characterAtIndex:i+1]=='-'||[exp characterAtIndex:i+1]=='+')) {
                    char op=[exp characterAtIndex:i+1];
                    i+=2;//移到数字开头
                    MyNumber myNumber=[self getNumber:&i exp:exp];
                    if (!myNumber.isSuccess) return nil;
                    if (op=='+') [postExp addObject:  [NSString stringWithFormat:@"%lf",myNumber.value]];
                    else [postExp addObject:  [NSString stringWithFormat:@"%lf",-myNumber.value]];
                    
                    
                }
                break;
            case ')':
                if (stack.isEmpty) return nil;
                while (![stack.top isEqualToString:@"("]) [postExp addObject:[stack pop]];
                //不合法判断
                if (stack.isEmpty) return nil;
                [stack pop];
                break;
            default:{
                //生成数字
                MyNumber myNumber=[self getNumber:&i exp:exp];
                if (!myNumber.isSuccess) return nil;
                [postExp addObject:  [NSString stringWithFormat:@"%lf",myNumber.value]];
                break;
            }
        }
    }
    while (!stack.isEmpty) [postExp addObject:[stack pop]];
    
    return postExp;
    
}

+(NSString*)calculate:(NSString*)exp{
    NSArray* postExp= [Calculator getPostExp:exp];
    //表达式不合法返回后缀是array为nil
    if (!postExp) return ERROR;
    
    MyStack* stack=[[MyStack alloc] init];
    for (int i=0; i<postExp.count; i++) {
        char ch=[postExp[i] characterAtIndex:0];
        
        if ((ch=='+'||ch=='-'||ch=='*'||ch=='/'||ch=='%')&&
            ((NSString*)postExp[i]).length==1) {//若长度不为1，则是一个符号加上一个数字
            
            if (stack.isEmpty) return ERROR;
            double num2=[[stack pop] doubleValue];
            if (stack.isEmpty) return ERROR;
            double num1=[[stack pop] doubleValue];
            switch (ch) {
                case '+':
                    [stack push:[NSNumber numberWithDouble:num1+num2]];
                    break;
                case '-':
                    [stack push:[NSNumber numberWithDouble:num1-num2]];
                    break;
                case '*':
                    [stack push:[NSNumber numberWithDouble:num1*num2]];
                    break;
                case '/':
                    [stack push:[NSNumber numberWithDouble:num1/num2]];
                    break;
                case '%':{
                    //不是整数不能%
                    const int x=1e-10;
                    if ((num1-(long long)num1)>x||(num2-(long long)num2)) return ERROR;
                    [stack push:[NSNumber numberWithDouble:(long long)num1%(long long)num2]];
                    break;
                }
            }
        }else [stack push:[NSNumber numberWithDouble:[postExp[i] doubleValue]]];
    }
    //若合法，最后栈中应该只有一个元素
    if (stack.isEmpty||stack.count>1) return ERROR;
    return [ NSString stringWithFormat:@"%lf",[[stack pop] doubleValue]];
}

@end
