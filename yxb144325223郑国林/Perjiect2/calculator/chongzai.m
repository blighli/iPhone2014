//
//  zhongzai.m
//  001
//
//  Created by CST-112 on 14-11-9.
//  Copyright (c) 2014年 CST-112. All rights reserved.
//

#import "chongzai.h"

@implementation NSString(chongzai)
-(BOOL) isOperator
{
    return ([self hasSuffix:@"+"]
            ||[self hasSuffix:@"-"]
            ||[self hasSuffix:@"*"]
            ||[self hasSuffix:@"/"]
            ||[self hasSuffix:@"("]
            ||[self hasSuffix:@")"]);}
@end
