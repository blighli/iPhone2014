//
//  Util.m
//  Calculator
//
//  Created by Mz on 14-11-4.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "Util.h"

@implementation Util
+ (bool)isNumber:(unichar)c {
    return (c >= '0' && c <= '9') || c == '.';
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
@end
