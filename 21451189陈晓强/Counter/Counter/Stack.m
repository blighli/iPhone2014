//
//  Stack.m
//  Counter
//
//  Created by 陈晓强 on 14/11/8.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "Stack.h"

@implementation Stack

- (instancetype)init
{
    [super self];
    _stack = [[NSMutableArray alloc] init];
    _stackTop = 0;
    return self;
}
- (void)push:(NSString *)symbol{
    [_stack addObject:symbol];
    _stackTop++;
}

- (NSString *)pop{
    NSString *symbol;
    symbol = [_stack objectAtIndex:--_stackTop];
    [_stack removeObjectAtIndex:_stackTop];
    return symbol;
}

- (NSString *)getTop
{
    return [_stack objectAtIndex:_stackTop-1];
}
- (BOOL)isEmpty
{
    BOOL isEmpty = NO;
    if ([_stack count] == 0) {
        isEmpty = YES;
    }
    return isEmpty;
}
@end
