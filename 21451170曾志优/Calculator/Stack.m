//
//  Stack.m
//  Express
//
//  Created by Mac on 14-11-6.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "Stack.h"

@implementation Stack
-(id) init
{
    if(self=[super init]){
        _base=[[NSMutableArray alloc] init];
        top=0;
    }
    return (self);
}

-(BOOL) empty
{
    return top==0? YES:NO;
}

-(void) push:(id) element
{
    [_base insertObject:element atIndex:top++];
}

-(void) pop
{
    --top;
}

-(id) top
{
    int temp=top-1;
    return [_base objectAtIndex:temp];
}

-(int) size
{
    return top;
}
@end
