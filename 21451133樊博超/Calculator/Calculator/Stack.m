//
//  Stack.m
//  Calculator
//
//  Created by 樊博超 on 14-11-9.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"

@implementation Stack
{
    NSMutableArray *stack;
    int top;
}






-(id)init{
    self = [super init];
    if (self) {
        stack = [[NSMutableArray alloc] init];
        top = 0;
        printf("init called\n");
    }
    return self;
}


-(NSString*)pop{
    id t;
    if (top == 0) {
        t = 0;
    }else{
        t = stack[--top];
       // [t autorelease];
    }
    printf("after pop\n");
    for (int i = 0; i < top; i++) {
        NSLog(@"%d = %@\n", i, stack[i]);
    }
    return t;
}


-(void)clear{
    for (int i = 0; i < top; i++) {
        [self pop];
    }
    
}




-(void)push:(NSString*)obj{
    NSString *new = [[NSString alloc] initWithString:obj];
    stack[top++] = new;
    printf("after push\n");
    for (int i = 0; i < top; i++) {
        NSLog(@"%d = %@\n", i, stack[i]);
    }
    return;
}


-(NSString *)gettop{
    if (top == 0) {
        return @"#";
    }else{
        return stack[top - 1];
    }
}

-(BOOL)isEmpty{
    if (top == 0) {
        return true;
    }
    else
        return false;
}


@end