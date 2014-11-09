//
//  NSMutableArray+stack.m
//  MyCaculate
//
//  Created by LFR on 14/11/7.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import "NSMutableArray+stack.h"

@implementation NSMutableArray (stack)
- (void)push:(id)parm {
    [self addObject:parm];
}

- (BOOL)isEmpty {
    if ([self count]) {
        return false;
    }
    return true;
}

- (id)top {
    id item = nil;
    if (!self.isEmpty) {
        item = [self objectAtIndex:([self count]-1)];
    }
    return  item;
}

- (id)pop
{
    id item = [self top];
    if (item) {
        [self removeObjectAtIndex:([self count]-1)];
    }
    return  item;
}

-(void)clear
{
    [self removeAllObjects];
}

@end
