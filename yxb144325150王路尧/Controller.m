//
//  Controller.m
//  iPhone
//
//  Created by 王路尧 on 14/11/8.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import "Controller.h"

@implementation NSString(operator)
-(BOOL) isOperator;
{
    return ([self hasSuffix:@"+"]
            ||[self hasSuffix:@"-"]
            ||[self hasSuffix:@"*"]
            ||[self hasSuffix:@"/"]
            ||[self hasSuffix:@"("]
            ||[self hasSuffix:@")"]);
}

@end