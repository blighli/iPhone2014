//
//  Express.m
//  Express
//
//  Created by Mac on 14-11-6.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "Express.h"
#import "Stack.h"

@implementation Express

-(id) init:(NSString *)expStrParam
{
    if(self=[super init]){
        _expStr = expStrParam ;
        _value=@"";
        errorcode = NOERROR;
    }
    return self;
}

-(BOOL) isBracketMatch
{
    BOOL match=YES;
    NSUInteger size=[_expStr length];
    const char *c_expStr= [_expStr UTF8String];
    Stack *stackOp = [[Stack alloc] init];//'()'
    for (NSUInteger i=0; i<size; ++i) {
        if(c_expStr[i] == '('){
            [stackOp push:[NSNumber numberWithChar:c_expStr[i]]];
        }else if(c_expStr[i] == ')'){
            if([stackOp empty]==NO){
                [stackOp pop];
            }else{
                errorcode = MISMATCHBRACKET;
                match=NO;
                break;
            }
        }
    }
    if([stackOp empty]==NO) {
        match = NO;
        errorcode = MISMATCHBRACKET;
    }
    return match;
}

-(int) errorCode
{
    if([self isBracketMatch]==YES)
        [self calExp];
    return errorcode;
}

-(NSMutableArray *) parseToNSMutableArray
{
    NSMutableArray* arry=[[NSMutableArray alloc] init];
    NSUInteger size=[_expStr length];
    NSUInteger start = 0,end=0;
    const char *c_expStr= [_expStr UTF8String];
    for(NSUInteger i =0 ;i<size;++i){
        if((c_expStr[i]=='-' && i==0) || (c_expStr[i]=='-' && c_expStr[i-1]=='(') )
            continue;
        if(c_expStr[i]=='+' || c_expStr[i]=='-' || c_expStr[i]=='*' || c_expStr[i]=='/' || c_expStr[i]=='%'|| c_expStr[i]=='(' || c_expStr[i]==')'){
            end=i;
            NSRange range = NSMakeRange(start, end-start);
            NSString *s_value=[_expStr substringWithRange:range];
            if([s_value isEqualToString:@""]==NO)
                [arry addObject:s_value];
            NSNumber *opNum = [NSNumber numberWithChar:c_expStr[i]];
            [arry addObject:opNum];
            start = i + 1;
        }
        if(i+1 == size){//处理最后一个操作数
            NSRange range = NSMakeRange(start, i+1-start);
            NSString *s_value=[_expStr substringWithRange:range];
            if([s_value isEqualToString:@""]==NO)
                [arry addObject:s_value];
        }
    }
    return arry;
}

-(BOOL) calExp
{
    NSMutableArray* arry=[self parseToNSMutableArray];
    NSUInteger size = [arry count];
    Stack *stackOperands = [[Stack alloc] init];//操作数栈
    Stack *stackOperators = [[Stack alloc] init];//操作符
    
    for(NSUInteger i=0;i<size;++i){
        id object = [arry objectAtIndex:i];
        if([object isKindOfClass:[NSNumber class]]==YES){//操作符,括号等
            NSNumber * cur_op = object;
            char cur_c = [cur_op charValue];
            
            if([stackOperators empty] == YES  || cur_c=='('){
                [stackOperators push:cur_op];
            }else{
                NSNumber* pre_op=[stackOperators top];
                char pre_c= [pre_op charValue];
                
                while([stackOperators empty]==NO && (  cur_c==')' ||  outOfStackPriority(cur_c)<= innerOfStackPriority(pre_c)) ){
                    
                    [stackOperators pop];//操作符出栈
                    if(pre_c=='(') break;
                    
                    if([stackOperands empty]==YES || [stackOperands size]==1) {
                        errorcode = OPERATORERROR;
                        return NO;
                    }
                    //两个操作数出栈并把计算结果入栈
                    double y=[[stackOperands top] doubleValue];
                    [stackOperands pop];
                    
                    if(pre_c == '/' && (y-0>-0.000001) && (y-0<0.000001)){
                        errorcode = DIVIDEZEROR;
                        return NO;
                    }
                    
                    double x=[[stackOperands top] doubleValue];
                    [stackOperands pop];
                    double z=cal(pre_c,x,y);
                    [stackOperands push:[NSString stringWithFormat:@"%f",z]];
                    
                    //继续取操作符栈顶元素
                    if([stackOperators empty]==NO){
                        NSNumber* pre_op=[stackOperators top];
                        pre_c= [pre_op charValue];
                    }
                }
                if(cur_c!=')')//不是括号操作符入栈
                    [stackOperators push:cur_op];
            }
        }else{
            [stackOperands push:[arry objectAtIndex:i]];
        }
    }
    while([stackOperands empty]==NO  && [stackOperators empty]==NO){
        if([stackOperands empty]==YES || [stackOperands size]==1) {
            errorcode = OPERATORERROR;
            return NO;
        }
        
        double y=[[stackOperands top] doubleValue];
        [stackOperands pop];
        double x=[[stackOperands top] doubleValue];
        [stackOperands pop];
        NSNumber* cur_op=[stackOperators top];
        [stackOperators pop];
        char cur_c= [cur_op charValue];
        
        if(cur_c == '/' && (y-0>-0.000001) && (y-0<0.000001)){
            errorcode = DIVIDEZEROR;
            return NO;
        }
        
        double z = cal(cur_c,x,y);
        NSString* result =[NSString stringWithFormat:@"%f",z];
        [stackOperands push: result];
    }
    
    if([stackOperands empty]==NO){
        if([stackOperators empty] == NO || [stackOperands size]>1){
            errorcode = OPERATORERROR;
            return NO;
        }
        _value = [stackOperands top];
        [stackOperands pop];
    }
    return YES;
}

-(void) calExp:(NSString *) param operator:(char)op;
{
    double x = [_expStr doubleValue];
    double y = [param doubleValue];
    double z = cal(op,x,y);
    _value = [NSString stringWithFormat:@"%f",z];
}

-(NSString *) getValue
{
    if(errorcode == NOERROR){
       double dValue = [_value doubleValue];
//        long int x =(int) dValue;
//        double e=dValue-x;
//        if(e<0.000001 && e>-0.000001)
            _value = [NSString stringWithFormat:@"%g",dValue];
    }
    return _value;
}

@end


double cal(char c,double x,double y)
{
    double z;
    switch (c) {
        case '+':
            z=x+y;
            break;
        case '-':
            z=x-y;
            break;
        case '*':
            z=x*y;
            break;
        case '/':
            z=x/y;
            break;
        case '%':
            z=((int)x) % ((int)y);
            break;
        default:
            break;
    }
    return z;
}

int outOfStackPriority(char c)
{
    int prior;
    switch (c) {
        case '+':
            prior=1;
            break;
        case '-':
            prior=1;
            break;
        case '*':
            prior=3;
            break;
        case '/':
            prior=3;
            break;
        case '%':
            prior =3;
            break;
        case '(':
            prior=5;
            break;
        case ')':
            prior=0;
            break;
        default:
            break;
    }
    return prior;
}



int innerOfStackPriority(char c)
{
    int prior;
    switch (c) {
        case '+':
            prior=2;
            break;
        case '-':
            prior=2;
            break;
        case '*':
            prior=4;
            break;
        case '/':
            prior=4;
            break;
        case '%':
            prior = 4;
        case '(':
            prior=0;
            break;
        case ')':
            prior=5;
            break;
        default:
            break;
    }
    return prior;
}
