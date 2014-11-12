//
//  Cal.m
//  Project2
//
//  Created by Cocoa on 14/11/9.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "Cal.h"
@implementation Cal

NSMutableArray* stack;
NSMutableArray* stackCompute;
NSMutableString* opstring;

-(NSString*)inFix2PostFix:(NSString*) inFixString {
    NSMutableString* postFixString = [[NSMutableString alloc] initWithString:@""];
    stack = [[NSMutableArray alloc]init];
    [stack addObject:[NSMutableString stringWithString:@"@"]];
    NSString* stackTop;
    for (int i=0; i<inFixString.length; i++) {
        char ch = [inFixString characterAtIndex:i];
        if (ch=='(') {
            [stack addObject:[NSMutableString stringWithFormat:@"("]];
        }
        else if (ch==')'){
            stackTop = [stack lastObject];
            while ( ![stackTop isEqualToString:@"("]) {
                [postFixString appendString:stackTop];
                [stack removeLastObject];
                break;
            }
            [stack removeLastObject];//删除栈顶的左括号
        }
        else if (ch=='+' || ch=='-' || ch=='*' || ch=='/' || ch=='%'){
            stackTop = [stack lastObject];
            NSString* str = [NSString stringWithFormat:@"%c",ch];
            while ([self precedence:stackTop] >= [self precedence:str]) {
                [postFixString appendString:stackTop];
                [stack removeLastObject];
                stackTop = [stack lastObject];
            }
            [stack addObject:[NSMutableString stringWithFormat:@"%c",ch]];
        }
        else{
            while((ch>='0' && ch<='9') || (ch=='.')) {
                [postFixString appendFormat:@"%c",ch];
                break;
            }
        }
    }
    stackTop = [stack lastObject];
    while ( ![stackTop isEqualToString:@"@"]) {
        [postFixString appendString:stackTop];
        [stack removeLastObject];
        stackTop = [stack lastObject];
    }
    NSString* returnValue = [NSString stringWithString:postFixString];
    return returnValue;
}

-(int)precedence:(NSString *) op {
    if ([op isEqualToString:@"+"] || [op isEqualToString:@"-"] ) {
        return 1;
    }
    else if ([op isEqualToString:@"*"] || [op isEqualToString:@"/"] || [op isEqualToString:@"%"]){
        return 2;
    }
    else if ([op isEqualToString:@"("]){
        return 0;
    }else{
        return -1;
    }
}

-(NSDecimalNumber*) compute:(NSString*) postFixString{
    stackCompute = [[NSMutableArray alloc]init];
    [stackCompute addObject:[NSMutableString stringWithString:@"@"]];
    NSDecimalNumber* x = [[NSDecimalNumber alloc]init];
    for (int i=0; i<postFixString.length; i++) {
        char ch = [postFixString characterAtIndex:i];
        if (ch=='+') {
            NSString* num1 = [stackCompute lastObject];
            [stackCompute removeLastObject];
            NSString* num2 = [stackCompute lastObject];
            [stackCompute removeLastObject];
            
            NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:num1];
            NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:num2];
            
            x = [_num2 decimalNumberByAdding:_num1];
            [stackCompute addObject:x.stringValue];
        }
        else if (ch=='-'){
            NSString* num1 = [stackCompute lastObject];
            [stackCompute removeLastObject];
            NSString* num2 = [stackCompute lastObject];
            [stackCompute removeLastObject];
            
            NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:num1];
            NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:num2];
            
            x = [_num2 decimalNumberBySubtracting:_num1];
            [stackCompute addObject:x.stringValue];
        }
        else if (ch=='*'){
            NSString* num1 = [stackCompute lastObject];
            [stackCompute removeLastObject];
            NSString* num2 = [stackCompute lastObject];
            [stackCompute removeLastObject];
            
            NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:num1];
            NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:num2];
            
            x = [_num2 decimalNumberByMultiplyingBy:_num1];
            [stackCompute addObject:x.stringValue];
        }
        else if (ch=='/'){
            NSString* num1 = [stackCompute lastObject];
            [stackCompute removeLastObject];
            NSString* num2 = [stackCompute lastObject];
            [stackCompute removeLastObject];
            
            NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:num1];
            NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:num2];
            
            if ([num1 doubleValue] == 0) {
                 //self.resultLabel.text = @"除数不为零";
            }
            x = [_num2 decimalNumberByDividingBy:_num1];
            [stackCompute addObject:x.stringValue];
        }
        else if(ch=='%'){
            NSString* num1 = [stackCompute lastObject];
            [stackCompute removeLastObject];
            NSString* num2 = [stackCompute lastObject];
            [stackCompute removeLastObject];
            
            NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:num1];
            NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:num2];
            
            double result = fmod(_num2.doubleValue, _num1.doubleValue);
            x = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", result]];
            [stackCompute addObject:x.stringValue];
        }
        else{
            [stackCompute addObject:[NSMutableString stringWithFormat:@"%c",ch]];
        }
    }
    if (postFixString.length == 1) {
        return [NSDecimalNumber decimalNumberWithString:postFixString];
    }
    if ([[stackCompute lastObject] isEqualToString:@"@"]) {
        return x;
    }
    return x;
}

@end
