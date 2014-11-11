//
//  Calculate.m
//  Calculate
//
//  Created by Devon on 14/11/6.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculate.h"

@interface Calculate()

@property (nonatomic, strong)NSMutableArray     *dealedArray;
@property (nonatomic, strong)NSDictionary       *opPriority;
@property (nonatomic, strong)NSMutableArray     *brakectHandledArray;
@property BOOL                                  brakectAfterSingle;

@end

@implementation Calculate

- (id)init{
    if(self = [super init]){
        _opPriority = @{@"(":@0, @"%":@1, @"x":@2, @"/":@2, @"+":@3, @"-":@3, @")":@4, @"#":@5};
    }
    _brakectAfterSingle = NO;
    return self;
}

- (NSString *)calculateWithString:(NSString *)str andAnswerString:(NSString *)answerStr{
    [self handlerInputString:str andAnswerString:answerStr];
    [_dealedArray addObject:@"#"];
    [_dealedArray insertObject:@"#" atIndex:0];
    NSInteger count = [_dealedArray count];
    NSString *finalResult = [NSString string];
    for(int i=(int)count-2; i>=0; --i){
        NSString *str1 = [_dealedArray objectAtIndex:i];
        if([str1 isEqualToString:@"#"]){
            finalResult = [_dealedArray objectAtIndex:1];
            if([_dealedArray count] > 3){
                finalResult = @"error";
            }
        }
        if([str1 isEqualToString:@"("]){
            NSString *subResult = [NSString string];
            for(NSInteger j=i+1; j<=count-1; ++j){
                NSString *str2 = [_dealedArray objectAtIndex:j];
                if([str2 isEqualToString:@"#"]){
                    finalResult = @"error";
                    return finalResult;
                }
                if([str2 isEqualToString:@")"]){
                    NSRange range = NSMakeRange(i+1, j-i-1);
                    NSArray *subArray = [_dealedArray subarrayWithRange:range];
                    NSMutableArray *arr = [NSMutableArray arrayWithArray:subArray];
                    subResult = [self calculateNumbers:arr];
                    if([subResult isEqualToString:@"error"]){
                        finalResult = @"error";
                        return finalResult;
                    }
                    range = NSMakeRange(i, j-i+1);
                    [_dealedArray replaceObjectsInRange:range withObjectsFromArray:[NSArray arrayWithObject:subResult]];
                    count = [_dealedArray count];
                    i = (int)count - 1;
                    break;
                }
            }
        }
    }
    return finalResult;
}

- (void)handlerInputString:(NSString *)inputStr andAnswerString:(NSString *)answerString{
    long int length = [inputStr length];
    _dealedArray = [NSMutableArray array];
    int i = 0;
    UniChar c = [inputStr characterAtIndex:0];
    if(c == '-'||c == '+'||c == 'x'||c == '/'){
        if(length > 1){
            UniChar c1 = [inputStr characterAtIndex:1];
            if(c1 >= '0'&&c1 <= '9'){
                [_dealedArray addObject:answerString];
                [_dealedArray addObject:[NSString stringWithCharacters:&c length:1]];
                ++i;
            }
        }
    }
    NSMutableString *mString = [NSMutableString string];
    while(i < length){
        c = [inputStr characterAtIndex:i];
        if((c >= '0'&&c <= '9')||c == '.'){
            [mString appendFormat:@"%c",c];
            if(i == length-1){
                [_dealedArray addObject:mString];
                mString = [NSMutableString string];
            }
        }
        else{
            if(![mString isEqualToString:@""]){
                [_dealedArray addObject:mString];
                mString = [NSMutableString string];
            }
            if(c == '('){
                if(i > 0){
                    UniChar xc = [inputStr characterAtIndex:i-1];
                    if(xc >= '0'&&xc <= '9'){
                        [_dealedArray addObject:@"x"];
                        [_dealedArray addObject:@"("];
                        ++i;
                        continue;
                    }
                }
                if(i < length-1){
                    UniChar c1 = [inputStr characterAtIndex:i+1];
                    if(c1 == '-'||c1 == '+'){
                        [_dealedArray addObject:@"("];
                        [_dealedArray addObject:@"0"];
                        ++i;
                        continue;
                    }
                }
            }
            else if(c == ')'){
                if(i < length-1){
                    UniChar xc = [inputStr characterAtIndex:i+1];
                    if(xc >= '0'&&xc <= '9'){
                        [_dealedArray addObject:@")"];
                        [_dealedArray addObject:@"x"];
                        ++i;
                        continue;
                    }
                }
            }
            [_dealedArray addObject:[NSString stringWithCharacters:&c length:1]];
        }
        ++i;
    }
    [_dealedArray insertObject:@"(" atIndex:0];
    [_dealedArray addObject:@")"];
}

- (NSString *)calculateNumbers:(NSMutableArray *)numberArray{
    NSMutableArray *operandStackArray = [NSMutableArray arrayWithObject:@"error"];
    NSMutableArray *stack2 = [NSMutableArray arrayWithObject:@"#"];
    NSString *result = [NSString string];
    [numberArray addObject:@"#"];
    while(1){
        NSString *subStr1 = [numberArray objectAtIndex:0];
        UniChar c = [subStr1 characterAtIndex:0];
        if((subStr1.length > 1&&[subStr1 hasPrefix:@"-"])||(c >= '0'&&c <= '9')){
            [operandStackArray insertObject:subStr1 atIndex:0];
            [numberArray removeObjectAtIndex:0];
        }
        else{
            NSString *topStack2 = [stack2 objectAtIndex:0];
            if([subStr1 isEqualToString:@"#"]&&[topStack2 isEqualToString:@"#"]){
                result = [operandStackArray objectAtIndex:0];
                break;
            }
            NSInteger one = [[_opPriority objectForKey:subStr1]integerValue];
            NSInteger two = [[_opPriority objectForKey:topStack2]integerValue];
            if(one < two){
                [stack2 insertObject:subStr1 atIndex:0];
                [numberArray removeObjectAtIndex:0];
            }
            else{
                NSString *strX = [operandStackArray objectAtIndex:0];
                if([strX isEqualToString:@"error"]){
                    result = @"error";
                    break;
                }
                double x1 = [strX doubleValue];
                [operandStackArray removeObjectAtIndex:0];
                strX = [operandStackArray objectAtIndex:0];
                if([strX isEqualToString:@"error"]){
                    result = @"error";
                    break;
                }
                double x2 = [strX doubleValue];
                [operandStackArray removeObjectAtIndex:0];
                [stack2 removeObjectAtIndex:0];
                result = [self calculateNumbersWithOperator:topStack2 betweenDouble:x2 andDouble:x1];
                if([result isEqualToString:@"error"]){
                    break;
                }
                [operandStackArray insertObject:result atIndex:0];
            }
        }
    }
    return result;
}

- (NSString *)calculateNumbersWithOperator:(NSString *)operator betweenDouble:(double)x1 andDouble:(double)x2{
    double aresult = 0;
    unichar ch = [operator characterAtIndex:0];
    NSString *string = [NSString string];
    BOOL isOK = YES;
    switch (ch) {
        case '+':
            aresult = x1+x2;
            break;
        case '-':
            aresult = x1-x2;
            break;
        case 'x':
            aresult = x1*x2;
            break;
        case '/':
            if(x2 == 0){
                string = @"error";
                isOK = NO;
            }
            aresult = x1/x2;
            break;
        case '%':
            if(x2 == 0){
                string = @"error";
                isOK = NO;
            }
            aresult = fmod(x1, x2);
            break;
        default:
            break;
    }
    if(isOK == YES){
        string = [NSString stringWithFormat:@"%g",aresult];
    }
    return string;
}

@end