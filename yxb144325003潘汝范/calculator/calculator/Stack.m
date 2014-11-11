//
//  Stack.m
//  calculator
//
//  Created by Van on 14/11/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "Stack.h"

@implementation Stack

@synthesize array;

- (Stack*) init{
    if (self){
        array = [[NSMutableArray alloc] initWithCapacity:50];
    }
    return self;
}
- (void) push:(id) object
{
    [array addObject:object ];
}

- (id) pop{
    if ([array count ] < 1)
        return nil;
    id item =[array lastObject];
    [array removeLastObject];
    return item;
}

- (int) size
{
    return (int)[array count];
}

- (BOOL) empty
{
    return [array count] == 0;
}

- (id) peek
{
    if ([array count] < 1)
        return nil;
    
    return [array lastObject];
}

@end
