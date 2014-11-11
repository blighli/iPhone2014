//
//  MyStack.m
//  Calculator
//
//  Created by 黄耀彬 on 14-11-8.
//  Copyright (c) 2014年 黄耀彬. All rights reserved.
//

#import "MyStack.h"

@implementation MyStack

- (id) init
{
    if(self = [super init])
    {
        stack=[[NSMutableArray alloc] init];
        size=0;
    }
    return (self);
}

- (id) top
{
    if(size >0)
        return [stack objectAtIndex:size-1];
    else
        return nil;
}

- (id) topAndPop
{
    id obj = nil;
    if (size>0) {
        obj=[stack lastObject];
        [stack removeLastObject];
        size--;
    }
    return obj;
}

- (void) pop
{
    if(size>0)
    {
        [stack removeLastObject];
        size--;
    }
}

- (void) push:(id)element
{
    [stack addObject:element];
    size++;
}

- (BOOL) isEmpty
{
    return size==0;
}

- (void) clear
{
    [stack removeAllObjects];
    size=0;
}

@end
