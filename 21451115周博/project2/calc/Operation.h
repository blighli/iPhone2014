//
//  Operation.h
//  calc
//
//  Created by zhou on 14/11/6.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PriorityConstants.h"

typedef NS_ENUM(NSUInteger, OPTYPE)
{
    NUL = 0,
    PLUS,
    MINUS,
    MULTIPLY,
    DIVIDE,
    EQUAL,
    SGN,
    PERCENT,
    LBRACE,
    RBRACE
};

@interface Operation : NSObject

@property NSString* name;
@property NSUInteger priority;
@property BOOL isBinaryOperator;
@property OPTYPE opType;

-(id) initWithOPS:(OPTYPE)op;

@end
