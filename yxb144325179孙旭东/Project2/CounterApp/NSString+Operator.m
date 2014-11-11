//
//  NSString+Operator.m
//  Counter
//
//  Created by  sephiroth on 14/11/3.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
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
