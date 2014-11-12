//
//  PostfixCalculator.m
//  calculator
//
//  Created by Van on 14/11/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "PostfixCalculator.h"

@implementation PostfixCalculator

- (NSDecimalNumber*) compute:(NSString*) postfixExpression{
    stack = [[Stack alloc] init];
    operators = [NSArray arrayWithObjects: @"+", @"-", @"*", @"/", nil];

    NSString* strippedExpression = [postfixExpression stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray *tokens = [strippedExpression componentsSeparatedByString: @" "];
    
    for(NSString* token in tokens){
        
        if ([operators containsObject:token]){
            NSDecimalNumber* secondOperand = (NSDecimalNumber*) [stack pop];
            NSDecimalNumber* firstOperand= (NSDecimalNumber*) [stack pop];
            if (! (firstOperand && secondOperand)){
                return nil;
            }
            NSDecimalNumber * result =  [self computeOperator:token
                                             withFirstOperand: firstOperand
                                            withSecondOperand:secondOperand];
            
            if (result == [NSDecimalNumber notANumber])
                return result;
            
            [stack push:result];
            
        } else {
            NSDecimalNumber * operand = [NSDecimalNumber decimalNumberWithString : token];
            [stack push: operand];
        }
    }
    
    
    if ([stack size] != 1){
        return nil;
    } else {
        NSDecimalNumber * result = [stack pop];
        return result;
    }
}

- (NSDecimalNumber *) computeOperator:(NSString*) operator
                     withFirstOperand:(NSDecimalNumber*) firstOperand withSecondOperand:(NSDecimalNumber*) secondOperand
{
    NSDecimalNumber * result;
    
    if ([operator compare: @"+"] == 0)
    {
        result = [firstOperand decimalNumberByAdding: secondOperand];
    }else if ([operator compare: @"*"] == 0)
    {
        result = [firstOperand decimalNumberByMultiplyingBy: secondOperand];
    } else if ([operator compare: @"-"] == 0)
    {
        result = [firstOperand decimalNumberBySubtracting: secondOperand];
    }
    else if ([operator compare: @"/"] == 0)
    {
        if ([[NSDecimalNumber zero] compare: secondOperand] == NSOrderedSame){
            NSLog(@"Divide by zero !");
            return [NSDecimalNumber notANumber];
        }
        else 
            result = [firstOperand decimalNumberByDividingBy: secondOperand];	}
    
    return result;
}
@end
