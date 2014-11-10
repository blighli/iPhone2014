//
//  InfixCalculator.h
//  CaculatorHW
//
//  Created by StarJade on 14-11-8.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "InfixToPostfix.h"
#import "PostfixCalculator.h"

@interface InfixCalculator : NSObject {
	InfixToPostfix *itp;
	PostfixCalculator *postCalc;
}

- (instancetype) init;
- (NSDecimalNumber*) computeExpression: (NSString*) infixExpression;

@end
