//
//  Calculate.m
//  Calculator
//
//  Created by lqynydyxf on 14/11/7.
//  Copyright (c) 2014年 lqynydyxf. All rights reserved.
//

#import "Calculate.h"

@implementation Calculate

-(NSDecimalNumber *) add :(NSString *) str1 :(NSString *) str2{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:str1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:str2];
    return [num1 decimalNumberByAdding:num2];
}
-(NSDecimalNumber *) minus :(NSString *) str1 :(NSString *) str2{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:str1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:str2];
    return [num1 decimalNumberBySubtracting:num2];
}
-(NSDecimalNumber *) multiply :(NSString *) str1 :(NSString *) str2{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:str1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:str2];
    return [num1 decimalNumberByMultiplyingBy:num2];
}
-(NSDecimalNumber *) devide :(NSString *) str1 :(NSString *) str2{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:str1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:str2];
    return [num1 decimalNumberByDividingBy:num2];
}
-(NSDecimalNumber *) calculate :(NSString *) operator :(NSMutableArray *) num{
    switch ([operator characterAtIndex:0]) {
        case '+':
            return [self add:num[0] :num[1]];
        case '-':
            return [self minus:num[0] :num[1]];
        case 'X':
            return [self multiply:num[0] :num[1]];
        case '/':
            return [self devide:num[0] :num[1]];
    }
    return [NSDecimalNumber decimalNumberWithString:@""];
}
@end