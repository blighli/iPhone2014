//
//  counter.m
//  Counter
//
//  Created by  sephiroth on 14/11/3.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import "counter.h"
#import "NSString+Operator.h"

@implementation counter
@synthesize result;
@synthesize Arithmetic;

-(id) init
{
    if (self=[super init]) {
        arryForNum=[NSMutableArray arrayWithCapacity:15];
        arryForOperator=[NSMutableArray arrayWithCapacity:15];
        Arithmetic=[NSMutableString stringWithString:@"5.5*2-2*(2-3)-6/(2*3)"];
        result=0;
    }
    return self;
}

-(id) initWithString:(NSString*) string
{
    if (self=[super init]) {
        arryForNum=[NSMutableArray arrayWithCapacity:15];
        arryForOperator=[NSMutableArray arrayWithCapacity:15];
        Arithmetic=[NSMutableString stringWithString:string];
        result=0;
    }
    return self;    return self;
}

//将加减乘除的优先级用数字表示，0为数字，1，2为加减，3，4为乘除，－1为左括号，－2为右括号
-(NSNumber *) division:(NSString *) operator
{
    if ([operator isEqualToString:@"+"]) {
        return [NSNumber numberWithInt:1];
    }
    else if ([operator isEqualToString:@"*"])
    {
        return [NSNumber numberWithInt:3];
    }
    else if ([operator isEqualToString:@"-"])
    {
        return [NSNumber numberWithInt:2];
    }
    else if ([operator isEqualToString:@"/"])
    {
        return [NSNumber numberWithInt:4];
    }
    else if([operator isEqualToString:@"("])
        return [NSNumber numberWithInt:-1];
    return [NSNumber numberWithInt:-2];
}


//分割字符串
-(void) divisionWithOperator
{
    NSMutableString* copyArithmetic;
    copyArithmetic=[Arithmetic mutableCopy];
    int oldPositon=0;
    NSRange head;
    head.location=0;
    head.length=1;
    int position=1;    
    for(;[copyArithmetic length]>0;position++)
    {
        if([[copyArithmetic substringToIndex:1] isOperator])
        {
            //如果第一个就是符号
            if(position==1||(position-oldPositon==1))
            {
                [arryForOperator addObject:[self division:[copyArithmetic substringToIndex:1]]];
                [arryForNum addObject:[NSNumber numberWithFloat:0]];
            }
            else
            {
                NSRange range;
                range.location=oldPositon;
                range.length=position-oldPositon;
                NSNumber *num;
                num=[NSNumber numberWithFloat:[[Arithmetic substringWithRange:range] floatValue]];
                [arryForNum addObject:num];
                [arryForOperator addObject:[NSNumber numberWithFloat:0]];
                [arryForOperator addObject:[self division:[copyArithmetic substringToIndex:1]]];
                [arryForNum addObject:[NSNumber numberWithFloat:0]];
            }
            oldPositon=position;
        }
        //copyArithmetc砍头
       [copyArithmetic deleteCharactersInRange:head];
    }
    
    //如果最后一个不是符号，继续截取
    if(oldPositon<[Arithmetic length])
    {
        [arryForNum addObject:[Arithmetic substringFromIndex:oldPositon]];
        [arryForOperator addObject:[NSNumber numberWithInt:0]];
    }
}

-(float) caculationFrombegin:(int) begin ToEnd:(int) end
{
    int positionleft=-1;
    int positionright=-1;
    int position=begin;
    if(/*[arryForOperator count]==1*/end-begin==1)
    {
        return [arryForNum[begin] floatValue];
    }
    else
    {
        for (int i=begin; i<end; i++) {
            if ([arryForOperator[i] intValue]==-1) {
                positionleft=i;
            }
            else if([arryForOperator[i] intValue]==-2)
            {
                positionright=i;
                float num=[self caculationFrombegin:positionleft+1 ToEnd:positionright];
                /*
                NSLog(@"l=%d,r=%d",positionleft,positionright);
                NSLog(@"posl=%d,num=%f",positionleft,num);
                getchar();
                */
                arryForNum[positionleft]=[NSNumber numberWithFloat:num];
                [arryForNum removeObjectAtIndex:positionleft+1];
                [arryForNum removeObjectAtIndex:positionleft+1];
                arryForOperator[positionleft]=[NSNumber numberWithInt:0];
                [arryForOperator removeObjectAtIndex:positionleft+1];
                [arryForOperator removeObjectAtIndex:positionleft+1];
                return [self caculationFrombegin:begin ToEnd:[arryForNum count]];
            }
            else if([arryForOperator[i] intValue]>0&&[arryForOperator[i] intValue]/3>=[arryForOperator[position] intValue]/3)
                position=i;
        }
  
        NSLog(@"pos=%d",position);
        switch ([arryForOperator[position] intValue]) {
            case 1:
                //加法，缺一个开头为正负号
                arryForNum[position-1]=[NSNumber numberWithFloat:[arryForNum[position-1] floatValue]+[arryForNum[position+1] floatValue]];
                [arryForNum removeObjectAtIndex:position];
                [arryForNum removeObjectAtIndex:position];
                [arryForOperator removeObjectAtIndex:position];
                [arryForOperator removeObjectAtIndex:position];
                break;
            case 2:
                //减法，缺一个开头为正负号
                arryForNum[position-1]=[NSNumber numberWithFloat:[arryForNum[position-1] floatValue]-[arryForNum[position+1] floatValue]];
                [arryForNum removeObjectAtIndex:position];
                [arryForNum removeObjectAtIndex:position];
                [arryForOperator removeObjectAtIndex:position];
                [arryForOperator removeObjectAtIndex:position];
                break;
            case 3:
                arryForNum[position-1]=[NSNumber numberWithFloat:[arryForNum[position-1] floatValue]*[arryForNum[position+1] floatValue]];
                [arryForNum removeObjectAtIndex:position];
                [arryForNum removeObjectAtIndex:position];
                [arryForOperator removeObjectAtIndex:position];
                [arryForOperator removeObjectAtIndex:position];
                break;
            case 4:
                arryForNum[position-1]=[NSNumber numberWithFloat:[arryForNum[position-1] floatValue]/[arryForNum[position+1] floatValue]];
                [arryForNum removeObjectAtIndex:position];
                [arryForNum removeObjectAtIndex:position];
                [arryForOperator removeObjectAtIndex:position];
                [arryForOperator removeObjectAtIndex:position];
                break;
            default:
                break;
        }
        return [self caculationFrombegin:begin ToEnd:end-2];
       
    }
}

-(NSString*) print
{
    [self divisionWithOperator];
    return [NSString stringWithFormat:@"%f",[self caculationFrombegin:0 ToEnd:[arryForNum count]]];
}
@end