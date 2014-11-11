//
//  Calculate.m
//  Calculator
//
//  Created by 周舟 on 9/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "Calculate.h"

@implementation Calculate

- (instancetype)init
{
    
    if (self = [super init]) {
        
    }
    return self;
}

- (NSString *)calculateWithExpress:(NSString *)express
{
    
    NSMutableArray *lastExpress = [self producePostExpress:express];
   
    return [self handlePostExpress:lastExpress];
}

- (NSMutableArray *)producePostExpress:(NSString *)express
{
    NSMutableArray *lastexpress = [NSMutableArray array];
    NSMutableString * tmpstrings = [[NSMutableString alloc] init];//数字
    NSMutableArray * operations = [[NSMutableArray alloc] init];//操作符
    char tmp;
    char popchar;
    char empty;
    int length = (int)[express length];
    for (int i=0; i<length;i++)
    {
        tmp = [express characterAtIndex:i];
        if ((tmp>='0'&&tmp<='9')||tmp=='.')
        {
            NSString * string = [[NSString alloc] initWithFormat:@"%c",tmp];
            [tmpstrings appendString:string];
            if (i!=length-1) {
                continue;
            }
        }
        if ([tmpstrings length]>0||(i==length-1)) {
            NSString * string = [NSString stringWithString:tmpstrings];
            [lastexpress addObject:string];
            int lens = (int)[tmpstrings length];
            [tmpstrings deleteCharactersInRange:NSMakeRange(0, lens)];
            if (tmp>='0'&&tmp<='9'&&(i==length-1)) {
                break;
            }
            
        }
        popchar = [[operations lastObject] characterAtIndex:0];
        if (popchar== empty) {
            NSString *string = [[NSString alloc] initWithFormat:@"%c",tmp];
            [operations addObject:string];
            continue;
        }else
        {
            if (popchar=='('&&tmp!=')')
            {
                NSString * string = [NSString stringWithFormat:@"%c",tmp];
                [operations addObject:string];
            }else if(tmp ==')')
            {
                while (popchar!='(')
                {
                    NSString * string = [NSString stringWithFormat:@"%c",popchar];
                    [lastexpress addObject:string];
                    [operations removeLastObject];
                    popchar =[[operations lastObject] characterAtIndex:0];
                    if (popchar==empty)
                    {

                        return 0;
                    }
                }
                if (popchar=='(') {
                    [operations removeLastObject];
                }
                
            }else if(tmp =='(')
            {
                NSString * string = [[NSString alloc] initWithFormat:@"%c",tmp];
                [operations addObject:string];
            }else
            {
                    while ([self poprityWithChar:popchar]>=[self poprityWithChar:tmp]) {
                    NSString * popstring = [[NSString alloc] initWithFormat:@"%c",popchar];
                    [lastexpress addObject:popstring];
                    [operations removeLastObject];
                    popchar = [[operations lastObject] characterAtIndex:0];
                }
                NSString *string = [[NSString alloc] initWithFormat:@"%c",tmp];
                
                [operations addObject:string];
            }
        }
    
    }
    for (int i=(int)[operations count]-1; i>=0; i--)
    {
        [lastexpress addObject:[operations objectAtIndex:i]];
    }
    return lastexpress;
}


- (NSString *)handlePostExpress:(NSArray *) lastExpress
{
    NSString * tmpstring;
    NSMutableArray * numberArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[lastExpress count]; i++)
    {
        tmpstring = [lastExpress objectAtIndex:i];
        if ([tmpstring length]>1)
        {
            [numberArray addObject:tmpstring];
        }
        else if ([tmpstring length]==1)
        {
            char key = [tmpstring characterAtIndex:0];
            if (key>='0'&&key<='9')
            {
                [numberArray addObject:tmpstring];
            }
            else
            {
                NSString * string;
                float number1 = [[numberArray lastObject] floatValue];
                [numberArray removeLastObject];
                float number2 = [[numberArray lastObject] floatValue];
                [numberArray removeLastObject];
                char key = [tmpstring characterAtIndex:0];
                switch (key)
                {
                    case '+':
                        string =[NSString stringWithFormat:@"%f",number2+number1];
                        break;
                    case '-':
                        string =[NSString stringWithFormat:@"%f",number2-number1];
                        break;
                    case 'x':
                        string =[NSString stringWithFormat:@"%f",number2*number1];
                        break;
                    case '/':
                        string =[NSString stringWithFormat:@"%f",number2/number1];
                        break;
                    case '%':
                        string =[NSString stringWithFormat:@"%d",((int)number2%(int)number1)];
                        break;
                    default:
                        break;
                }
                [numberArray addObject:string];
            }
        }
    }
    return [numberArray lastObject];
}

/**
 *  获取运算符优先级
 *
 *  @param tmp <#tmp description#>
 *
 *  @return <#return value description#>
 */
-(int)poprityWithChar:(char)tmp
{
    int value=0;
    switch (tmp) {
        case 'x':
        case '/':
        case '%':
            value =3;
            break;
        case '+':
        case '-':
            value =2;
            break;
        default:
            break;
    }
    return value;
}
@end
