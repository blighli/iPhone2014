//
//  Calculator brain.h
//  Calculator
//
//  Created by SXD on 14/11/10.
//  Copyright (c) 2014年 SXD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)preformOperation:(NSString *)operation;

@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
