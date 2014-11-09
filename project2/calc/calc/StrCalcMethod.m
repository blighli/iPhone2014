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

    if ([rnum doubleValue] == 0)
    {
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

+ (NSString *)calcWithOpType:(NSString *)lstr withRStr:(NSString *)rstr withOP:(OPTYPE)op
{
    NSString *result=@"";
    switch (op)
    {
        case PLUS:

            result = [StrCalcMethod deciPlus:lstr withString:rstr];

            break;
        case MINUS:
            result = [StrCalcMethod deciMinus:lstr withString:rstr];
            break;

        case DIVIDE:
            if ([rstr doubleValue] == 0)
            {
                result = @"除数不能为零";
                break;
            }
            result = [StrCalcMethod deciDivide:lstr withString:rstr];
            break;
        case MULTIPLY:
            result = [StrCalcMethod deciMultiply:lstr withString:rstr];
            break;
            
            
        case PERCENT:
            result = [StrCalcMethod deciMultiply:lstr withString:@"0.01"];
            break;
        case SGN:
            result = [StrCalcMethod deciMultiply:lstr withString:@"-1"];
            break;
        default:
            break;
    }
    return result;
}

@end
