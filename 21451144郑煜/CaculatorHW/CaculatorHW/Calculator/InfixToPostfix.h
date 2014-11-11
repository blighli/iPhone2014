//
//  InfixToPostfix.h
//  CaculatorHW
//
//  Created by StarJade on 14-11-8.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SimpleStack.h"


@interface InfixToPostfix : NSObject {
	NSDictionary * operatorPrecedence;
}

- (instancetype) init;

- (NSString*) parseInfix: (NSString*) infixExpression;

@end
