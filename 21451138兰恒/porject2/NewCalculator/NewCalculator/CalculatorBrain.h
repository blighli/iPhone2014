//
//  CalculatorBrain.h
//  NewCalculator
//
//  Created by lh on 14-11-4.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
- (void) pushNumber:(double) operand;
- (double) popNumeber;
- (double) getTopNumber;

- (void) pushOperation:(NSString*) operand;
- (NSString*) popOperatoin;
- (NSString*) getTopOperation;

- (int) precess:(NSString*)op1 And:(NSString *)op2;
- (double)operate:(NSString *)op second:(double) x third:(double) y;

-(double) dealWhitString:(NSString *)content;

@end
