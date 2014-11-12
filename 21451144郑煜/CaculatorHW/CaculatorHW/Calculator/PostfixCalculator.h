//
//  PostfixCalculator.h
//  CaculatorHW
//
//  Created by StarJade on 14-11-8.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//
	

#import <Foundation/Foundation.h>
#import "SimpleStack.h"

@interface PostfixCalculator : NSObject {
	NSArray* operators;
	SimpleStack* stack;
}


- (instancetype) init;
- (NSDecimalNumber *) compute:(NSString*) postfixExpression;
@end
