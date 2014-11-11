//
//  calAchieve.m
//  calculator
//
//  Created by ___FULLUSERNAME___ on 14-11-5.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "calAchieve.h"
#import "stack.h"

@interface calAchieve()

@property (nonatomic)double mem;
@property(nonatomic)NSArray *doubleOperate;
@property(nonatomic)BOOL error;

@end
@implementation calAchieve

@synthesize mem=_mem;
@synthesize doubleOperate=_doubleOperate;
@synthesize error=_error;

-(id)init
{
    if(self = [super init])
    {
        _doubleOperate=[NSArray arrayWithObjects:@"+(",@"-(",@"*(",@"/(",@"((",@")+",@")-",@")*",@")/",@"))",nil];
        _mem=0;
        _error=NO;
    }
    return self;
}
//string 转成中缀表达式
-(NSMutableArray *)stringToInfix:(NSString *)expression
{
    NSMutableArray *infix=[[NSMutableArray alloc]init];
    NSMutableString *digit=[[NSMutableString alloc]init];
    NSString *operate=[[NSMutableString alloc]init];
    for (int i=0; i<expression.length; i++) {
        char bit=[expression characterAtIndex:i];
        if ((bit>='0' && bit<='9')||bit=='.') {
            [digit appendFormat:@"%c",bit];
        }else
        {
            if (![digit isEqualToString:@""]) {
                NSNumber *num=[NSNumber numberWithDouble:[digit doubleValue]];
                [infix addObject:num];
                [digit setString:@""];
            }
            operate=[NSString stringWithFormat:@"%c",bit];
            [infix addObject:operate];
        }
    }
    if (![digit isEqualToString:@""]) {
        NSNumber *num=[NSNumber numberWithDouble:[digit doubleValue]];
        [infix addObject:num];
        [digit setString:@""];
    }
    return infix;
}
//判断符号优先级
-(int) prior:(NSString *)op
{
    if([op isEqualToString:@"+"]||[op isEqualToString:@"-"])
		return 1;
	if([op isEqualToString:@"*"]||[op isEqualToString:@"/"])
		return 2;
	return 0;
}
//中缀变后缀
-(NSMutableArray *)infixToSuffix:(NSMutableArray *)stack
{
    
    Stack *op=[[Stack alloc]init];//中间过渡的栈
    NSMutableArray *suffix=[[NSMutableArray alloc]init];
    for (id obj in stack) {
        if([obj isKindOfClass:[NSNumber class]])
        {
            [suffix addObject:obj];
        }else
		{
            NSString *oper=obj;
			if([oper isEqualToString:@"("])
				[op push:@"("];
			else
			{
				if([oper isEqualToString:@")"])
				{
					while(![[op top] isEqualToString:@"("])
					{
						[suffix addObject:[op top]];
						[op pop];
					}
					[op pop];
				}
				else
				{
					if([op empty])
					{
						[op push:oper];
					}
					else
					{
						if([self prior:oper]>[self prior:[op top]])
							[op push:oper];
						else
						{
							while(![op empty]&&[self prior:oper]<=[self prior:[op top]])
							{
								[suffix addObject:[op top]];
								[op pop];
							}
							[op push:oper];
						}
					}
				}
			}
		}
    }
    //把所有栈弹出
    while(![op empty])
	{
		[suffix addObject:[op top]];
		[op pop];
	}
    return suffix;
}
//后缀表达式
-(NSString *)result:(NSString *)expression
{
    expression= [self expressionJudge:expression];
    if (self.error) {
        return @"ERROR";
    }
    else{
        NSMutableArray *suffix=[[NSMutableArray alloc]init];
        suffix=[self infixToSuffix:[self stringToInfix:expression]];
        Stack *st=[[Stack alloc]init];
        double result=0;
        double aa=0;
        double bb=0;
        double cc=0;
        
        for(id obj in suffix)
        {
            if([obj isKindOfClass:[NSNumber class]])
            {
                //    NSLog(@"1");
                [st push:obj];
            }
            else{
                aa=[[st pop] doubleValue];
                bb=[[st pop] doubleValue];
                cc=0;
                NSString *str=[NSString stringWithString:obj];
                char a=[str characterAtIndex:0];
                switch (a) {
                    case '+':
                        cc=aa+bb;
                        break;
                    case '-':
                        cc=bb-aa;
                        break;
                    case '*':
                        cc=aa*bb;
                        break;
                    case '/':
                        if (aa==0) {
                            return @"ERROR";
                        }
                        cc=bb/aa;
                        break;
                    default:
                        break;
                }
                NSNumber *c1=[NSNumber numberWithDouble:cc];
                [st push:c1];
            }
        }
        result=[[st pop] doubleValue];
        return [NSString stringWithFormat:@"%g",result];
    }
    
}
-(void)mClear
{
    self.mem=0;
}
-(void)mPlus:(double)m
{
    self.mem=self.mem+m;
}
-(void)mMinus:(double)m
{
    self.mem=self.mem-m;
}
-(double)mRead
{
    return  self.mem;
}
-(BOOL)operate1:(NSString *)op1 operate2:(NSString *)op2
{
    NSString *op1op2=[NSString stringWithFormat:@"%@%@",op1,op2];
    for (NSString * str in self.doubleOperate) {
        if ([op1op2 isEqualToString:str]) {
            return YES;
        }
    }
    return NO;
}

-(NSString *)expressionJudge:(NSString *)expression
{
    NSMutableString *expr2=[NSMutableString stringWithString:expression];
    for (int i=0; i<expr2.length; i++) {
        char b=[expr2 characterAtIndex:i];
        if (b=='(' && i>=1) {
            char a=[expr2 characterAtIndex:i-1];
            if (a>='0'&&a<='9') {
                [expr2 insertString:@"*" atIndex:i];
                i=i+1;
            }
        }
        if(b==')' && i+1<expr2.length)
        {
            char a=[expr2 characterAtIndex:i+1];
            if(a>='0'&&a<='9')
            {
                [expr2 insertString:@"*" atIndex:i+1];
                i=i+1;
            }
        }
    }
    int left=0;
    for (int i=0;i<expr2.length;i++) {
        char b=[expr2 characterAtIndex:i];
        if (b=='(') {
            left++;
        }
        if (b==')') {
            left--;
        }
        if (left<0) {
            self.error=YES;
            break;
        }
    }
    if (left>0)
        while (left--) {
            [expr2 appendFormat:@")"];
        }
    return expr2;
}
	@end