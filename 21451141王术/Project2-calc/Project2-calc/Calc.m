//
//  Calc.m
//  Project2-calc
//
//  Created by  ws on 11/7/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import "Calc.h"
@implementation Calc
//判断操作符
+ (bool)isOperator:(unichar)c {
    return c == '%' || c =='/' || c == 'x' || c == '-' || c == '+';
}
//判断数字
+ (bool)isNumber:(unichar)c {
    return (c >= '0' && c <= '9') || c == '.';
}
//判断括号
+ (bool)isBrackets:(unichar)c {
    return c == '(' || c == ')';
}
//读取数字
+ (double)readNumber:(NSString *)s atIndex:(int*)index {
    int i = *index;
    while (i < s.length && [self isNumber:[s characterAtIndex:i]]) i++;
    NSRange range = {*index, i - *index};
    *index = i;
    return [[s substringWithRange:range] doubleValue];
}
//乘除运输
+ (double)multiplication:(NSString *)s atIndex:(int *)index {
    double res = [self readNumber:s atIndex:index];
    while (*index < s.length) {
        switch ([s characterAtIndex:*index]) {
            case 'x':
                *index += 1;
                if (*index >= s.length) return res;
                res *= [self readNumber:s atIndex:index];
                break;
            case '%':
                *index += 1;
                if (*index >= s.length) return res;
                res = (int)res % (int)[self readNumber:s atIndex:index];
                break;
            case '/':
                *index += 1;
                if (*index >= s.length) return res;
                res /= [self readNumber:s atIndex:index];
                break;
            default:
                return res;
        }
    }
    return res;
}
//加减运算
+ (double)additon:(NSString *)s {
    int index = 0;
    double res = [self multiplication:s atIndex:&index];
    while (index < s.length) {
        switch ([s characterAtIndex:index]) {
            case '+':
                index += 1;
                if (index >= s.length) return res;
                res += [self multiplication:s atIndex:&index];
                break;
            case '-':
                index += 1;
                if (index >= s.length) return res;
                res -= [self multiplication:s atIndex:&index];
                break;
            default:
                return res;
        }
    }
    return res;
}
//字符串整体运算
+ (double)calculate:(NSString *)s {
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
                tmp = [[NSNumber numberWithDouble:[self additon:[st lastObject]]] stringValue];
                [st removeLastObject];
                [(NSMutableString*)[st lastObject] appendString:tmp];
                break;
            default:
                [((NSMutableString*)[st lastObject]) appendFormat:@"%c", c];
                break;
        }
    }
    return [self additon:[st lastObject]];
}
@end
