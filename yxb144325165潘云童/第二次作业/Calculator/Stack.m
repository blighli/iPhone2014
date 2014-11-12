//
//  Stack.m
//  Calculator
//
//  Created by Joker on 14/11/4.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

#import "Stack.h"

@implementation Stack
@synthesize top;
@synthesize data;

-(id)init
{
    self = [super init];
    if(self)
    {
        data = [[NSMutableArray alloc] init];
        top = [[NSString alloc] init];
    }
    return self;
}

-(void)push:(NSString *)object
{
    [data addObject:object];
}

-(NSString *)pop
{
    NSString *retStr = nil;
    if([data count] > 0)
    {
        retStr = [data objectAtIndex:([data count] - 1)];
        [data removeObjectAtIndex:([data count] - 1)];
    }
    return retStr;
}

-(BOOL)isEmpty
{
    if([data count] > 0)
        return NO;
    return YES;
}

-(NSString *)getStackTop
{
    return [data objectAtIndex:([data count] - 1)];
}

-(void)clearStack
{
    [data removeAllObjects];
}

-(int) getStackCount
{
    return (int)[data count];
}

@end
