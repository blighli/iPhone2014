//
//  Calculator.h
//  calculator
//
//  Created by icy on 14-11-12.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#ifndef calculator_Calculator_h
#define calculator_Calculator_h


#endif

#import <Foundation/Foundation.h>

@interface Calculator : NSObject


- (void)pushOperation:(NSString *)operation;
- (double)result:(BOOL)secondEq;
- (void)zero;
- (void)pushNumberInStack:(double)aDouble  andBool:(BOOL)aBool;

@end