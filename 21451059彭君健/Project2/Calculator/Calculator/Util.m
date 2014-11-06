//
//  Util.m
//  Calculator
//
//  Created by Mz on 14-11-4.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "Util.h"

@implementation Util
+ (bool)isOperator:(unichar)c {
    return c == '%' || c == '/' || c == 'x' || c == '-' || c == '+';
}

+ (bool)isNumber:(unichar)c {
    return (c >= '0' && c <= '9') || c == '.';
}

+ (bool)isBrackets:(unichar)c {
    return c == '(' || c == ')';
}

+ (double)readDouble:(NSString *)s atIndex:(int*)index {
    int i = *index;
    while (i < s.length && [self isNumber:[s characterAtIndex:i]]) i++;
    NSRange range = {*index, i - *index};
    *index = i;
    return [[s substringWithRange:range] doubleValue];
}

+ (double)readPart:(NSString *)s atIndex:(int *)index {
    double res = [self readDouble:s atIndex:index];
    while (*index < s.length) {
        switch ([s characterAtIndex:*index]) {
            case 'x':
                *index += 1;
                if (*index >= s.length) return res;
                res *= [self readDouble:s atIndex:index];
                break;
            case '%':
                *index += 1;
                if (*index >= s.length) return res;
                res = (int)res % (int)[self readDouble:s atIndex:index];
                break;
            case '/':
                *index += 1;
                if (*index >= s.length) return res;
                res /= [self readDouble:s atIndex:index];
                break;
            default:
                return res;
        }
    }
    return res;
}

+ (double)calculate:(NSString *)s {
    int index = 0;
    double res = [self readPart:s atIndex:&index];
    while (index < s.length) {
        switch ([s characterAtIndex:index]) {
            case '+':
                index += 1;
                if (index >= s.length) return res;
                res += [self readPart:s atIndex:&index];
                break;
            case '-':
                index += 1;
                if (index >= s.length) return res;
                res -= [self readPart:s atIndex:&index];
                break;
            default:
                return res;
        }
    }
    return res;
}

+ (double)expr:(NSString *)s {
    NSMutableArray *st = [NSMutableArray arrayWithCapacity:10];
    [st addObject:[NSMutableString stringWithString:@""]];
    NSString *tmp;
    for (int i = 0; i < s.length; i++) {
        unichar c = [s characterAtIndex:i];
        switch (c) {
            case '(':
                [st addObject:[NSMutableString stringWithFormat:@""]];
                break;
            case ')':
                tmp = [[NSNumber numberWithDouble:[self calculate:[st lastObject]]] stringValue];
                [st removeLastObject];
                [(NSMutableString*)[st lastObject] appendString:tmp];
                break;
            default:
                [((NSMutableString*)[st lastObject]) appendFormat:@"%c", c];
                break;
        }
    }
    return [self calculate:[st lastObject]];
}
@end
