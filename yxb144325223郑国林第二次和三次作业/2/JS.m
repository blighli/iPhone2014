//
//  JS.m
//  001
//
//  Created by CST-112 on 14-11-9.
//  Copyright (c) 2014年 CST-112. All rights reserved.
//

#import "JS.h"
#import "chongzai.h"


@implementation JS
@synthesize result;
@synthesize Arithmetic;
@synthesize sum;


-(id) init
{
    if (self=[super init]) {
        arry=[NSMutableArray arrayWithCapacity:10];
        positionleft=[NSMutableArray arrayWithCapacity:10];
        Arithmetic=[NSMutableString stringWithString:@"2+3"];
        sum=0;
    }
    return self;
}

-(id) initWithString:(NSString *) string
{
    if (self=[super init]) {
        arry=[NSMutableArray arrayWithCapacity:10];
        positionleft=[NSMutableArray arrayWithCapacity:10];
        Arithmetic=[NSMutableString stringWithString:string];
        sum=0;
        
    }
    return self;
}

-(float) sumPluse
{
    return sum+=[result floatValue];
}

-(float) sumSub
{
    return sum-=[result floatValue];
}


//分割字符串
-(void) divisionWithOperator
{
    NSMutableString* copyArithmetic;
    copyArithmetic=[Arithmetic mutableCopy];
    int oldPositon=0;
    
    NSRange head=NSMakeRange(0, 1);
    
    int position=1;
    int positionright=-1;
    NSString * point;
    
    for(;[copyArithmetic length]>0;position++)
    {
        if([point=[copyArithmetic substringToIndex:1] isOperator])
        {
            //如果第一个就是符号
            if(position==1||(position-oldPositon==1))
            {
                [arry addObject:[copyArithmetic substringToIndex:1]];
                
            }
            else
            {
                NSRange range;
                range.location=oldPositon;
                range.length=position-oldPositon-1;
                //NSNumber *num;
                //num=[NSNumber numberWithFloat:[[Arithmetic substringWithRange:range] floatValue]];
                [arry addObject:[Arithmetic substringWithRange:range]];
                [arry addObject:[copyArithmetic substringToIndex:1]];
            }
            oldPositon=position;
            
            
            if ([point isEqualToString:@")"])
            {
                positionright=[arry count]-1;
                int left=[positionleft[[positionleft count]-1] intValue];
                
                
                [self caculationFromBegin:left+1 ToEnd:positionright];
                [arry removeObjectAtIndex:left];
                [arry removeObjectAtIndex:left+1];
                [positionleft removeObjectAtIndex:[positionleft count]-1];
                
                /*
                 NSLog(@"***********");
                 
                 for (NSInteger i=0; i<[arry count]; i++) {
                 NSLog(@"index %d has %@",i,arry[i]);
                 }
                 */
                
            }
            else if([point isEqualToString:@"("])
            {
                [positionleft addObject:[NSNumber numberWithInteger:[arry count]-1]];
            }
        }
        //copyArithmetc砍头
        [copyArithmetic deleteCharactersInRange:head];
    }
    
    //如果最后一个不是符号，继续截取
    if(oldPositon<[Arithmetic length])
    {
        [arry addObject:[Arithmetic substringFromIndex:oldPositon]];
    }
    [self caculationFromBegin:0 ToEnd:[arry count]];
}

-(void) caculationFromBegin:(int) begin ToEnd:(int) end
{
    /*
     for (NSInteger i=0; i<[arry count]; i++) {
     NSLog(@"index %d has %@",i,arry[i]);
     }
     */
    
    int operator=0;
    int position=begin;
    while (end-begin>1)
    {
        for (int i=begin; i<end; i++)
        {
            if([arry[i] isEqualToString:@"+"])
            {
                operator=1;
                position=i;
            }
            else if ([arry[i] isEqualToString:@"-"])
            {
                operator=2;
                position=i;
            }
            else if ([arry[i] isEqualToString:@"*"])
            {
                operator=3;
                position=i;
                break;
            }
            else if([arry[i] isEqualToString:@"/"])
            {
                operator=4;
                position=i;
                break;
            }
        }
        
        float num=3;
        
        switch (operator) {
            case 1:
                if(position==begin)
                {
                    num=0+[arry[position+1] floatValue];
                    arry[position]=[NSString stringWithFormat:(@"%f"),num];
                    [arry removeObjectAtIndex:position+1];
                    end--;
                }
                else
                {
                    num=[arry[position-1] floatValue]+[arry[position+1] floatValue];
                    arry[position-1]=[NSString stringWithFormat:(@"%f"),num];
                    [arry removeObjectAtIndex:position];
                    [arry removeObjectAtIndex:position];
                    end-=2;
                }
                break;
            case 2:
                if(position==begin)
                {
                    num=0-[arry[position+1] floatValue];
                    arry[position]=[NSString stringWithFormat:(@"%f"),num];
                    [arry removeObjectAtIndex:position+1];
                    end--;
                }
                else
                {
                    num=[arry[position-1] floatValue]-[arry[position+1] floatValue];
                    arry[position-1]=[NSString stringWithFormat:(@"%f"),num];
                    [arry removeObjectAtIndex:position];
                    [arry removeObjectAtIndex:position];
                    end-=2;
                }
                break;
            case 3:
                num=[arry[position-1] floatValue]*[arry[position+1] floatValue];
                arry[position-1]=[NSString stringWithFormat:(@"%f"),num];
                [arry removeObjectAtIndex:position];
                [arry removeObjectAtIndex:position];
                end-=2;
                break;
                
            case 4:
                num=[arry[position-1] floatValue]/[arry[position+1] floatValue];
                arry[position-1]=[NSString stringWithFormat:(@"%f"),num];
                [arry removeObjectAtIndex:position];
                [arry removeObjectAtIndex:position];
                end-=2;
                break;
                
            default:
                break;
        }
    }
}

-(NSString *) output
{
    [self divisionWithOperator];
    //   [self caculationFromBegin:2 ToEnd:[arry count]];
    self.result=arry[0];
    return result;
}

@end