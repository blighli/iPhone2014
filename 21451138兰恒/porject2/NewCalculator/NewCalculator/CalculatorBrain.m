//
//  CalculatorBrain.m
//  NewCalculator
//
//  Created by lh on 14-11-4.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *numberStack;
@property (nonatomic,strong) NSMutableArray *operatorStack;
@end

@implementation CalculatorBrain
@synthesize numberStack = _numberStack;
@synthesize operatorStack = _operatorStack;

- (NSMutableArray *)numberStack
{
    if(_numberStack == nil)
        _numberStack=[[NSMutableArray alloc] init];
    return _numberStack;
}
-(NSMutableArray *)operatorStack
{
    if(_operatorStack == nil)
        _operatorStack = [[NSMutableArray alloc]init];
    return _operatorStack;
}
- (void) pushNumber:(double) operand
{
    
    [self.numberStack addObject:[NSNumber numberWithDouble:operand]];
}
- (double) popNumeber
{
    int count = [self.numberStack count];
    if(count > 0)
    {
        NSNumber * oneNumber = [self.numberStack lastObject];
        [self.numberStack removeLastObject];
        return [oneNumber doubleValue];
        
    }
    else
    {
        NSLog(@"数字不够！");
        return -9999999;
    }
        
    
}

- (double) getTopNumber
{
    int count = [self.numberStack count];
    if(count > 0)
    {
        NSNumber * oneNumber = [self.numberStack lastObject];
        return [oneNumber doubleValue];
        
    }
    else
    {
        NSLog(@"数字不够！");
        return 0;
        
    }
        
    
}


- (void) pushOperation:(NSString*) operand
{
    [self.operatorStack addObject:operand];
    
}
- (NSString*) popOperatoin
{
    
    NSString* oneOperation;
    int count = [self.operatorStack count];
    if(count > 0)
    {
        oneOperation = [self.operatorStack lastObject];
        [self.operatorStack removeLastObject];
        return oneOperation;
    }
    else
    {
        oneOperation = @"!";
        return oneOperation;
        
    }
        

    
}
- (NSString*) getTopOperation
{
    int count = [self.operatorStack count];
    if(count > 0)
    {
        NSString* oneOperation = [self.operatorStack lastObject];
        //[self.operatorStack removeLastObject];
        return oneOperation;
    }
    else
        return 0;
    
}

- (int) precess:(NSString*)op1 And:(NSString *)op2
{
    int flag =0;
    char p1= [op1 cStringUsingEncoding:NSASCIIStringEncoding][0];
    char p2= [op2 cStringUsingEncoding:NSASCIIStringEncoding][0];
    switch (p1)
    {
        case '+':
            if(p2 == '*' ||p2 =='/'||p2=='(')
                flag = -1;
            else
                flag =1;
            break;
            
        case '-':
            if(p2 == '*' ||p2 =='/'||p2=='(')
                flag = -1;
            else
                flag =1;
            break;
            
        case '*':
            if(p2=='(')
                flag = -1;
            else
                flag =1;
            break;
        case '/':
            if(p2=='(')
                flag = -1;
            else
                flag =1;
            break;

        case '(':
            if(p2==')')
                flag = 0;
            else
                flag =-1;
            break;
        case ')':
            if(p2=='(' || p2 == '#')
                flag = 2;
            else
                flag =1;
            break;
        case '#':
            if(p2=='#')
                flag = 0;
            else
                flag =-1;
            break;

        default:
            break;
    }
    
    return  flag;
}

- (double)operate:(NSString *)op second:(double) x third:(double) y
{
    char p1= [op cStringUsingEncoding:NSASCIIStringEncoding][0];
    double z = 0.0;
    switch (p1) {
        case '+':
            z= x+y;
            break;
        case '-':
            z= x-y;
            break;
        case '*':
            z= x*y;
            break;
        case '/':
            z= x/y;
            break;
            
        default:
            break;
    }
    return z;
    
}

-(double) dealWhitString:(NSString *)content
{
    content = [content stringByAppendingString:@"#"];
    NSLog(@"%@",content);
    [self pushOperation:@"#"];
    
    int i =0,j =-1 ;
    double x=0,y=0,z=0;
    NSString *ch;
    int length = [content length];
    for(i = 0;i <length;i++)
    {
        ch = [content substringWithRange:NSMakeRange(i, 1)];
        if([ch isEqualToString: @"+"]||[ch isEqualToString: @"-"]||[ch isEqualToString: @"*"]||[ch isEqualToString:@"/"]||[ch isEqualToString:@")"]||[ch isEqualToString: @"("]||[ch isEqualToString: @"#"])
        {
            
            if(i-j != 1)
            {
                NSString *num = [content substringWithRange:NSMakeRange(j+1, i-j-1)];
                z = [num doubleValue];
                [self pushNumber:z];
                
            }
            
            switch ([self precess:[self getTopOperation] And:ch])
            {
                    
                case -1:
                    [self pushOperation:ch];
                    break;
                case 0:
                    ch = [self popOperatoin];
                    break;
                case 1:
                    ch = [self popOperatoin];
                    x = [self popNumeber];
                    y = [self popNumeber];
                    if(!(abs(y+9999999) <= 1e-15))
                    {
                        [self pushNumber:[self operate:ch second:y third:x]];
                        i--;

                    }
                    else
                    {
                        [self.operatorStack removeAllObjects];
                        [self.numberStack removeAllObjects];
                        return -999999;
                        
                    }
                        
                    break;
                    
                default:
                    
                    [self.operatorStack removeAllObjects];
                    [self.numberStack removeAllObjects];
                    return -999999;
                    break;
            }
            j = i;

            
        }

    }
    NSLog(@"%d",[self.operatorStack count]);
    if([self.operatorStack count] == 0 )
    {
        double a = [self getTopNumber];
        [self.numberStack removeAllObjects];
        
        return a;
    }
        
        
    else
    {
        [self.operatorStack removeAllObjects];
        [self.numberStack removeAllObjects];
        return -999999;
        
    }
        
}

@end
