//
//  Counter.m
//  Counter
//
//  Created by Mac on 14-11-7.
//  Copyright (c) 2014年 Mac. All rights reserved.
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
    
    
    if(oldPositon<[Arithmetic length])
    {
        [arryForNum addObject:[Arithmetic substringFromIndex:oldPositon]];
        [arryForOperator addObject:[NSNumber numberWithInt:0]];
    }
}

-(float) caculationFrombegin:(int) begin ToEnd:(int) end
{
    @try{
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
                //加法
                arryForNum[position-1]=[NSNumber numberWithFloat:[arryForNum[position-1] floatValue]+[arryForNum[position+1] floatValue]];
                [arryForNum removeObjectAtIndex:position];
                [arryForNum removeObjectAtIndex:position];
                [arryForOperator removeObjectAtIndex:position];
                [arryForOperator removeObjectAtIndex:position];
                break;
            case 2:
                //减法
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
    @catch(NSException *ex)
    {
        @throw ex;
    }
}

-(NSString*) print
{
    @try {
    [self divisionWithOperator];
    }
    @catch(NSException *ex)
    {
        
    }
    return [NSString stringWithFormat:@"%f",result=[self caculationFrombegin:0 ToEnd:[arryForNum count]]];
}
@end
