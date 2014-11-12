//
//  Stack.m
//  calc
//
//  Created by zhou on 14/11/6.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "Stack.h"

@implementation Stack
- (id)init
{
    if (self = [super init])
    {
        self.stackArr = [[NSMutableArray alloc] init];
    }

    return self;
}

- (void)push:(id)item
{
    if (item != nil)
    {
        
        [self.stackArr addObject:item];
    }
}

- (void)pop
{
    NSUInteger size = [self.stackArr count];
    if (size > 0)
    {
        [self.stackArr removeObjectAtIndex:size - 1];
    }
}

/**
 *  返回栈顶元素， 如果stack 为空，则返回nil
 *
 *  @return item
 */
- (id)top
{
    id item = nil;
    NSUInteger size = [self.stackArr count];
    if (size > 0)
    {
        item = self.stackArr[size - 1];
    }

    return item;
}

- (BOOL)isEmpty
{
    return [self.stackArr count] == 0;
}

- (void)empty
{
    [self.stackArr removeAllObjects];
}

@end
