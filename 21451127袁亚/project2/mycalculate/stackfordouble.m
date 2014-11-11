//
//  stackfordouble.m
//  mycalculate
//
//  Created by Frank Yuan on 14-11-6.
//  Copyright (c) 2014年 Frank Yuan. All rights reserved.
//

#import "stackfordouble.h"
#import "unit.h"

#define STACKSIZE 20;
@implementation stackfordouble{
    NSMutableArray* mystack;
}
-(id)init{
    self=[super init];
    int tmp=STACKSIZE;
    [self setSize:tmp];
    [self setTop:-1];
    mystack=[NSMutableArray arrayWithCapacity:[self size]];
    return self;
}
-(BOOL)IsEmpty{
    return [self top]==-1?YES:NO;
}
-(BOOL)IsFull{
    return [self top]==[self size]-1?YES:NO;
}
-(void)push:(double)element{
    if([self IsFull])
        if(![self AddSize])
            return;
    _top++;
    unit* tmp=[[unit alloc]init];
    [tmp setValue: element];
    [mystack insertObject:tmp atIndex:[self top]];
}
-(double)pop{
    if([self IsEmpty])return 0;
    unit* tmp=[[unit alloc]init];
    tmp=[mystack objectAtIndex:[self top]];
    [mystack removeObjectAtIndex:[self top]];
    _top--;
    return [tmp value];
}
-(double)gettop{
    if([self IsEmpty])return 0;
    unit* tmp=[[unit alloc]init];
    tmp=[mystack objectAtIndex:[self top]];
    return [tmp value];
}
-(BOOL)AddSize{
    [self setSize:[self size]*2];
    NSMutableArray* tmp=[NSMutableArray arrayWithCapacity:[self size]];
    [tmp addObjectsFromArray:mystack];
    return YES;
}
@end