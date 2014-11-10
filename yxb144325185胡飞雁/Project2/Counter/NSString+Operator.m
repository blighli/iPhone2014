//
//  NSString+Operator.m
//  Counter
//
//  Created by Mac on 14-11-7.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "NSString+Operator.h"

@implementation NSString(Operator)
-(BOOL) isOperator
{
    return ([self hasSuffix:@"+"]
            ||[self hasSuffix:@"-"]
            ||[self hasSuffix:@"*"]
            ||[self hasSuffix:@"/"]
            ||[self hasSuffix:@"("]
            ||[self hasSuffix:@")"]);}
@end
