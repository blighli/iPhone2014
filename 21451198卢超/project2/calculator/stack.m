//
//  stack.m
//  calculator
//
//  Created by ___FULLUSERNAME___ on 14-11-5.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "stack.h"


@implementation Stack
@synthesize count;
- (id)init
{
    if( self=[super init] )
    {
        stack_array = [[NSMutableArray alloc] init];
        count = 0;
    }
    return self;
}

- (void)push:(id)anObject
{
    [stack_array addObject:anObject];
    count = stack_array.count;
}
- (NSString *)pop
{
    NSString *obj = nil;
    if(stack_array.count > 0)
    {
        obj = [stack_array lastObject];
        [stack_array removeLastObject];
        count = stack_array.count;
    }
    return obj;
}
- (NSString *)top
{
    NSString *obj = nil;
    if(stack_array.count > 0)
    {
        obj = [stack_array lastObject];
    }
    return obj;
}
- (void)clear
{
    [stack_array removeAllObjects];
    count = 0;
}
-(BOOL)empty
{
    if(count==0)
        return YES;
    else
        return NO;
}
@end