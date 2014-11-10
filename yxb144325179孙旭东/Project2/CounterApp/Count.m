//
//  Count.m
//  Counter2
//
//  Created by  sephiroth on 14/11/6.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import "Count.h"
#import "NSString+Operator.h"
static float sum;
@implementation Count
@synthesize result;
@synthesize Arithmetic;
@synthesize sum;

+(float) sumget
{
    return sum;
}

+(void) sumpluse:(float)num
{
    sum+=num;
}
+(void) sumsub:(float)num
{
    sum-=num;
}
-(id) init
{
    if (self=[super init]) {
        arry=[NSMutableArray arrayWithCapacity:15];
        positionleft=[NSMutableArray arrayWithCapacity:15];
        Arithmetic=[NSMutableString stringWithString:@""];
        sum=0;
    }
    return self;
}

-(id) initWithString:(NSString *) string
{
    if (self=[super init]) {
        arry=[NSMutableArray arrayWithCapacity:15];
        positionleft=[NSMutableArray arrayWithCapacity:15];
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
                if ([positionleft count]==0) {
                    arry[0]=@"wrong input";
                    return;
                }
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
    
    if([positionleft count]>0)
    {
        arry[0]=@"You should never do this again!";
        return;
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
    @try{
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
    @catch(NSException *ex)
    {
        arry[0]=@"You shold never do this";
    }
}

-(NSString *) output
{
    [self divisionWithOperator];
 //   [self caculationFromBegin:2 ToEnd:[arry count]];
    self.result=arry[0];
    //NSLog(@"%d",[arry count]);
    [arry removeObjectAtIndex:0];
    return result;
}

@end
