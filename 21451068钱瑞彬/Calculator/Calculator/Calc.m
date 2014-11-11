//
//  Calc.m
//  Calculator
//
//  Created by apple on 14-11-6.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Calc.h"
#include <math.h>


@implementation Calc

static double EPS = 1e-16;


// 比较优先级
- (int)cmp: (char)ch {
    switch(ch) {
        case '+':
        case '-': return 1;
        case '*':
        case '/':
        case '%': return 2;
        default : return 0;
    }
}


// 中缀表达式转变后缀表达式
- (void)change: (NSString*)s1 : (NSMutableString*)s2 {
    int top = 0;
    char s[9999];
    s[top++] = '#';
    
    //NSLog(@"%@", s1);
    
    int i = 0;
    while(i < [s1 length]) {
        char ch = [s1 characterAtIndex:i];
        if(ch == '(') {
            
            if(i+1 < [s1 length] && [s1 characterAtIndex:i+1] == '-') { // 负数
                i += 2;
                ch = [s1 characterAtIndex:i];
                [s2 appendString:@"_"];
                while( ch != ')') {
                    [s2 appendFormat:@"%c", ch];
                    i++;
                    ch = [s1 characterAtIndex:i];
                }
                [s2 appendFormat:@" "];
                i++;
            }
            else {
                s[top++] = ch;
                i++;
            }
        }
        else if(ch == ')') {
            while(s[top-1] != '(') {
                [s2 appendFormat:@"%c ", s[--top]];
            }
            --top;
            i++;
        }
        else if(ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '%') {
            while([self cmp: (s[top-1])] >= [self cmp: (ch)]) {
                [s2 appendFormat:@"%c ", s[--top]];
            }
            s[top++] = ch;
            i++;
        }
        else if(ch == '=') {
            i++;
        }else {
            while(('0' <= ch && ch <= '9') || ch == '.') {
                [s2 appendFormat:@"%c", ch];
                i++;
                if (i == [s1 length]) break;
                ch = [s1 characterAtIndex:i];
            }
            [s2 appendFormat:@" "];
        }
    }
    while(s[top-1] != '#') {
        [s2 appendFormat:@"%c ", s[--top]];
    }
}


// 计算后缀表达式，得到其结果
- (double)value: (NSMutableString*)s2 {
    int top = 0;
    double s[9999];
    double x,y;
    int i = 0;
    
    //NSLog(@"%@", s2);
    
    while(i < [s2 length]) {
        char ch = [s2 characterAtIndex:i];
        if(ch == ' ') {
            i++;
            continue;
        }
        switch(ch) {
            case '+': {
                x = s[--top];
                x += s[--top];
                i++;
                break;
            }
            case '-': {
                x = s[--top];
                x = s[--top]-x;
                i++;
                break;
            }
            case '*': {
                x = s[--top];
                x *= s[--top];
                i++;
                break;
            }
            case '/': {
                x = s[--top];
                x = s[--top]/x;
                if (fabs(x) < EPS) {
                    
                }
                i++;
                break;
            }
            case '%': { // 取膜
                x = s[--top];
                x = fmod(s[--top], x);
                i++;
                break;
            }
            default : {
                BOOL neg = NO;
                if (ch == '_') {
                    neg = YES;
                    i++;
                    ch = [s2 characterAtIndex:i];
                }
                x = 0;
                while('0' <= ch && ch <= '9') {
                    x = x * 10 + (ch - '0');
                    i++;
                    ch = [s2 characterAtIndex:i];
                }
                if(ch == '.') {
                    double k = 10.0;
                    y = 0;
                    i++;
                    ch = [s2 characterAtIndex:i];
                    while('0' <= ch && ch <= '9') {
                        y += ((ch-'0')/k);
                        i++;
                        ch = [s2 characterAtIndex:i];
                        k *= 10;
                    }
                    x += y;
                }
                if (neg == YES) x = -x;
            }
        }
        s[top++] = x;
    }
    return s[top-1];
}


// 计算结果
- (double)cal: (NSString*)s1 {
    NSMutableString* s2 = [[NSMutableString alloc] initWithString:@""];
    [self change: s1 : s2];
    return [self value: s2];
}


@end


