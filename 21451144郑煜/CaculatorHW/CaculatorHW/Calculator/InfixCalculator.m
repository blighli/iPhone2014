//
//  InfixCalculator.m
//  CaculatorHW
//
//  Created by StarJade on 14-11-8.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//


#import "InfixCalculator.h"


@implementation InfixCalculator

- (InfixCalculator*) init{
	self = [super init];
	if (self){
		itp = [[InfixToPostfix alloc] init];
		postCalc = [[PostfixCalculator alloc] init];
	}
	return self;
}



- (NSDecimalNumber*) computeExpression: (NSString*) infixExpression {
    
    NSLog(@"infixExpression:%@",infixExpression);
	NSString* postfixExpression = [itp parseInfix: infixExpression];
	
    NSLog(@"postfixExpression:%@",postfixExpression);
	if (postfixExpression) {
		return [postCalc compute: postfixExpression];
	}
	
	return nil;
}

@end
