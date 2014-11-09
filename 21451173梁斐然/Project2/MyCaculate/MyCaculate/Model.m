//
//  Model.m
//  MyCaculate
//
//  Created by LFR on 14/11/7.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import "Model.h"

int leftBracketCount = 0;
BOOL edited = false;
BOOL firstNum = false;

@implementation Model

- (NSMutableString *)currentNum {
    if (!_currentNum) {
        _currentNum = [[NSMutableString alloc] initWithString:@"0"];
    }
    return _currentNum;
}

- (NSMutableString *)memoryNum {
    if (!_memoryNum) {
        _memoryNum = [[NSMutableString alloc] initWithString:@"0"];
    }
    return _memoryNum;
}

- (NSMutableArray *)operationArray {
    if (!_operationArray) {
        _operationArray = [[NSMutableArray alloc] init];
    }
    return _operationArray;
}

- (NSMutableArray *)numberArray {
    if (!_numberArray) {
        _numberArray = [[NSMutableArray alloc] init];
    }
    return _numberArray;
}


- (void)updateCurrentNum:(NSString*)newNum {
    if (firstNum) {
        [self.numberArray push:self.currentNum];
        _currentNum = nil;
        firstNum = false;
    }
    edited = true;
    if ([newNum isEqualToString:@"."]) {
        NSRange substr = [self.currentNum rangeOfString:@"."];
        if (substr.location == NSNotFound) {
            [self.currentNum appendString:newNum];
        }
    } else if ([self.currentNum isEqualToString:@"0"]) {
        if (![newNum isEqualToString:@"0"]) {
            [self.currentNum deleteCharactersInRange:NSMakeRange(0, 1)];
            [self.currentNum appendString:newNum];
        }
    } else {
        [self.currentNum appendString:newNum];
    }
}

- (void)clearCurrentNum {
    _currentNum = nil;
    [self.numberArray clear];
    [self.operationArray clear];
}

- (void)changeOperator {
    if (![self.currentNum isEqualToString:@"0"]) {
        if ([self.currentNum hasPrefix:@"-"]) {
            [self.currentNum deleteCharactersInRange:NSMakeRange(0, 1)];
        } else {
            [self.currentNum insertString:@"-" atIndex:0];
        }
    }
}

- (void)deleteNum {
    if ([self.currentNum length] == 1) {
        _currentNum = nil;
    } else {
        [self.currentNum deleteCharactersInRange:NSMakeRange([self.currentNum length] - 1, 1)];
    }
}

- (void)caculateWithOperation:(NSString*)operation {
    if (edited) {
        edited = false;
        if (!self.operationArray.isEmpty) {
            while (([self priorityOfOperation:operation] <= [self priorityOfOperation:self.operationArray.top]) && (![self.operationArray.top isEqualToString:@"(" ])) {
                NSString *num = self.numberArray.pop;
                double result = [self caculate:num and:self.currentNum and:self.operationArray.pop];
                self.currentNum = [NSMutableString stringWithFormat:@"%g",result];
            }
        }
        firstNum = true;
        [self.operationArray push:operation];
    }
}

- (void)leftBracket {
    [self.operationArray push:@"("];
    leftBracketCount++;
}

- (void)rightBracket {
    if (!self.operationArray.isEmpty) {
        if (leftBracketCount) {
            NSString* tempOP = self.operationArray.pop;
            while (![tempOP isEqualToString:@"("]) {
                NSString *num = self.numberArray.pop;
                double result = [self caculate:num and:self.currentNum and:tempOP];
                self.currentNum = [NSMutableString stringWithFormat:@"%g",result];
                tempOP = self.operationArray.pop;
            }
            leftBracketCount--;
        }
    }
}

- (void)equal {
    if (edited) {
        if (!(self.operationArray.isEmpty || self.numberArray.isEmpty)) {
            while (!self.operationArray.isEmpty) {
                NSString* tempOP = self.operationArray.pop;
                NSString *num = self.numberArray.pop;
                double result = [self caculate:num and:self.currentNum and:tempOP];
                self.currentNum = [NSMutableString stringWithFormat:@"%g",result];
            }
        }
    }
}

- (void)percentage {
    if (![self.currentNum isEqualToString:@"0"]) {
        double temp = [self.currentNum doubleValue];
        temp /= 100;
        self.currentNum = [NSMutableString stringWithFormat:@"%g",temp];
    }
}

- (int)priorityOfOperation:(NSString *)operation{
    if (operation == nil) {
        return 0;
    }else if ([operation isEqualToString:@"+"] || [operation isEqualToString:@"-"]) {
        return 1;
    } else if ([operation isEqualToString:@"*"] || [operation isEqualToString:@"/"]) {
        return 2;
    }
    return 3;
}

-(double)caculate:(NSString *)NUM1 and:(NSString *)NUM2 and:(NSString*)operation{
    int operationNum = 0;
    if ([operation isEqualToString:@"+"]) {
        operationNum = 1;
    }
    if ([operation isEqualToString:@"-"]) {
        operationNum = 2;
    }
    if ([operation isEqualToString:@"*"]) {
        operationNum = 3;
    }
    if ([operation isEqualToString:@"/"]) {
        operationNum = 4;
    }
    double num1=[NUM1 doubleValue];
    double num2=[NUM2 doubleValue];
    
    switch (operationNum) {
        case 1:
            return num1+num2;
            break;
        case 2:
            return num1-num2;
            break;
        case 3:
            return num1*num2;
            break;
        case 4:
            return num1/num2;
            break;
        default:
            break;
    }
    return 0;
}

- (void)MClean {
    self.memoryNum = nil;
}
- (void)MAdd {
    double result = [self caculate:self.memoryNum and:self.currentNum and:@"+"];
    self.memoryNum = [NSMutableString stringWithFormat:@"%g",result];
}
- (void)MMinus {
    double result = [self caculate:self.memoryNum and:self.currentNum and:@"-"];
    self.memoryNum = [NSMutableString stringWithFormat:@"%g",result];
}

@end
