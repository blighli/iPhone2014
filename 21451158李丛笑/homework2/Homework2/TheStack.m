//
//  TheStack.m
//  Homework2
//
//  Created by 李丛笑 on 14/11/7.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheStack.h"
@implementation TheStack


-(void) Push:(char *)s Ch:(char)ch Top:(int)top
{
    s[top] = ch;
    top++;
    //NSLog(@"nstop is %d",top);
}


-(char) Pop:(char *)s Top:(int)top
{
    char e = s[top-1];
    s[top-1] = '\0';
    top--;
    return e;
}


-(int)PriorityCompare:(char *)new Str2:(char *)old

{
    int a, b;
    int result = 0;
    if (new == '+' ||new =='-'){
        a = 1;
    }
    else{
        a = 2;
    }
    if (old == '+' ||old =='-') {
        b = 1;
    }
    else{
        b = 2;
    }
    if (a<=b) {
        result = 3;
    }
    else{
        result = 4;
    }
    
    return result;
    
}



@end
