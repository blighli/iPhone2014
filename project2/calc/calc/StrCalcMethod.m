//
//  StrCalcMethod.m
//  calc
//
//  Created by zhou on 14/11/5.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "StrCalcMethod.h"

@implementation StrCalcMethod

+ (NSString *)deciMultiply:(NSString *)lstr withString:(NSString *)rstr
{
    NSDecimalNumber *lnum = [NSDecimalNumber decimalNumberWithString:lstr];
    NSDecimalNumber *rnum = [NSDecimalNumber decimalNumberWithString:rstr];

    NSDecimalNumber *result = [lnum decimalNumberByMultiplyingBy:rnum];

    return [result stringValue];
}

+ (NSString *)deciDivide:(NSString *)lstr withString:(NSString *)rstr
{
    NSDecimalNumber *lnum = [NSDecimalNumber decimalNumberWithString:lstr];
    NSDecimalNumber *rnum = [NSDecimalNumber decimalNumberWithString:rstr];

    if ([rnum doubleValue]==0) {
        return @"除数不能为零";
    }
    NSDecimalNumber *result = [lnum decimalNumberByDividingBy:rnum];

    return [result stringValue];
}

+ (NSString *)deciPlus:(NSString *)lstr withString:(NSString *)rstr
{
    NSDecimalNumber *lnum = [NSDecimalNumber decimalNumberWithString:lstr];
    NSDecimalNumber *rnum = [NSDecimalNumber decimalNumberWithString:rstr];

    NSDecimalNumber *result = [lnum decimalNumberByAdding:rnum];

    return [result stringValue];
}

+ (NSString *)deciMinus:(NSString *)lstr withString:(NSString *)rstr
{
    NSDecimalNumber *lnum = [NSDecimalNumber decimalNumberWithString:lstr];
    NSDecimalNumber *rnum = [NSDecimalNumber decimalNumberWithString:rstr];

    NSDecimalNumber *result = [lnum decimalNumberBySubtracting:rnum];

    return [result stringValue];
}

@end
