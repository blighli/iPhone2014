//
//  PostfixCalculator.h
//  calculator
//
//  Created by Van on 14/11/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"
@interface PostfixCalculator : NSObject
{
    NSArray* operators;
    Stack* stack;
}
- (NSDecimalNumber *) compute:(NSString*) postfixExpression;

- (NSDecimalNumber *) computeOperator:(NSString*) operator withFirstOperand:(NSDecimalNumber*) firstOperand withSecondOperand:(NSDecimalNumber*) secondOperand;
@end
