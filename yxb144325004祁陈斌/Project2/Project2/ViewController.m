//
//  ViewController.m
//  Project2
//
//  Created by xsdlr on 14/11/3.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//数字数组
NSArray* numberArray;
//操作符数组
NSArray* operationArray;
//记忆体数据
NSNumber* memoryValue;
//显示暂存值
NSNumber* tempValue;
//运算栈
NSMutableArray* stack;
//左括号位置栈
NSMutableArray* leftBracketStack;
//数字能否覆写显示区域
BOOL canOverwriteScreen;
//最近的操作符
NSString* lastOperation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.memoryLabel.hidden = YES;
    memoryValue = [NSNumber numberWithDouble:0];
    tempValue = [NSNumber numberWithDouble:0];
    canOverwriteScreen = NO;
    leftBracketStack = [NSMutableArray new];
    stack = [NSMutableArray new];
    operationArray = @[@"+",@"﹣",@"×",@"÷",@"=",@"%",@"(",@")",@"AC",@"MC",@"M+",@"M-",@"MR",@"←"];
    numberArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"."];
    lastOperation = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction) buttonPress:(UIButton *)sender {
//    NSLog(@"%@",sender.currentTitle);
    
    if (self.outputTextField == nil) {
        return ;
    }
    
    NSString* buttonTitle = sender.currentTitle;
    NSString* displayText = self.outputTextField.text;
    //按钮是数字(包括小数点)
    if ([numberArray containsObject:buttonTitle]) {
        if (canOverwriteScreen) {
            if (stack.count > 0) {
                [stack addObject:[tempValue stringValue]];
            }
            self.outputTextField.text = @"0";
            displayText = @"0";
            canOverwriteScreen = NO;
        }
        if (self.outputTextField.text.length < 10) {
            if ([buttonTitle  isEqualToString: @"0"]){
                if ((![displayText hasPrefix:@"0"]) || ([displayText rangeOfString:@"."].length>0)) {
                    self.outputTextField.text = [displayText stringByAppendingString:buttonTitle];
                    tempValue = [NSNumber numberWithDouble:[self.outputTextField.text doubleValue]];
                } else {
                    tempValue = [NSNumber numberWithDouble:0];
                }
            } else if([buttonTitle  isEqualToString: @"."]) {
                if ([displayText rangeOfString:@"."].length==0) {
                    self.outputTextField.text = [displayText stringByAppendingString:buttonTitle];
                    tempValue = [NSNumber numberWithDouble:[self.outputTextField.text doubleValue]];
                }
            } else {
                if ([displayText isEqualToString:@"0"]) {
                    displayText = @"";
                }
                self.outputTextField.text = [displayText stringByAppendingString:buttonTitle];
                tempValue = [NSNumber numberWithDouble:[self.outputTextField.text doubleValue]];
            }
        }
    } else {
        canOverwriteScreen = YES;
        [self operationCodeCalc:buttonTitle];
    }
}
/**
 * 运算符操作
 */
- (void) operationCodeCalc:(NSString*) operationString{
    if ([operationString isEqualToString:@"AC"]) {
        [stack removeAllObjects];
        tempValue = [NSNumber numberWithDouble:0];
        self.outputTextField.text = @"0";
        [leftBracketStack removeAllObjects];
        canOverwriteScreen = NO;
        lastOperation = @"";
    } else if([operationString isEqualToString:@"MC"]){
        memoryValue = [NSNumber numberWithDouble:0];
        self.memoryLabel.hidden = YES;
    } else if([operationString isEqualToString:@"MR"]){
        self.outputTextField.text = [self fixDisplayTextLength:[memoryValue stringValue] maxLength:18];
        tempValue = memoryValue;
    } else if([operationString isEqualToString:@"M+"]){
        memoryValue = [NSNumber numberWithDouble:[memoryValue doubleValue]+[self.outputTextField.text doubleValue]];
        self.memoryLabel.hidden = NO;
    } else if([operationString isEqualToString:@"M-"]){
        memoryValue = [NSNumber numberWithDouble:[memoryValue doubleValue]-[self.outputTextField.text doubleValue]];
        self.memoryLabel.hidden = NO;
    } else if([operationString isEqualToString:@"←"]){
        NSString* displayText = self.outputTextField.text;
        NSRange range = [displayText rangeOfString:@"e"];
        if (displayText.length > 1 && range.location == NSNotFound) {
            self.outputTextField.text = (displayText = [displayText substringToIndex:displayText.length-1]);
        } else if(range.location != NSNotFound){
//            NSString* prefix = [displayText substringToIndex:range.location];
//            NSString* suffix = [displayText substringFromIndex:range.location];
//            if (prefix.length > 1) {
//                prefix = [prefix substringToIndex:prefix.length-1];
//                if ([prefix hasSuffix:@"."]) {
//                    prefix = [prefix substringToIndex:prefix.length-1];
//                }
//                self.outputTextField.text = displayText = [prefix stringByAppendingString:suffix];
//            } else {
//                self.outputTextField.text = displayText = @"0";
//            }
        } else {
            self.outputTextField.text = displayText = @"0";
        }
        tempValue = [NSNumber numberWithDouble:[displayText doubleValue]];
    } else if([operationString isEqualToString:@"%"]){
        tempValue = [NSNumber numberWithDouble:([tempValue doubleValue] /100)];
        self.outputTextField.text = [self fixDisplayTextLength:[tempValue stringValue] maxLength:18];
    } else if([operationString isEqualToString:@"+"] || [operationString isEqualToString:@"﹣"] || [operationString isEqualToString:@"×"] || [operationString isEqualToString:@"÷"]) {
        
        if (([self priority:operationString]-[self priority:lastOperation]>0 )) {
            if ([operationArray containsObject:[stack lastObject]]) {
                [stack removeLastObject];
            }
            [stack addObject:operationString];
        } else {
            NSString* one = [stack lastObject];
            [stack removeLastObject];
            if ([operationArray containsObject:one]) {
                [stack addObject:operationString];
            } else {
                NSString* op = [stack lastObject];
                [stack removeLastObject];
                tempValue  = [self calculate:one numberTwo:[tempValue stringValue] operation:op];
                self.outputTextField.text = [self fixDisplayTextLength:[tempValue stringValue] maxLength:18];
                [stack addObject:operationString];
            }
            
        }
        lastOperation = operationString;
    } else if ([operationString isEqualToString:@"("]){
        [leftBracketStack addObject:[NSNumber numberWithInteger:(stack.count+1)]];
        lastOperation = operationString;
    } else if ([operationString isEqualToString:@")"]){
        NSNumber* leftBracketIndex = [leftBracketStack lastObject];
        [leftBracketStack removeLastObject];
        if (stack.count > 0) {
            NSInteger count = (stack.count-[leftBracketIndex integerValue])/2;
            for (NSInteger i=0;i<count; i++) {
                NSString* one = [stack lastObject];
                if ([operationArray containsObject:one]) {
                    break;
                }
                [stack removeLastObject];
                NSString* op = [stack lastObject];
                [stack removeLastObject];
                tempValue  = [self calculate:one numberTwo:[tempValue stringValue] operation:op];
            }

        }
        self.outputTextField.text = [self fixDisplayTextLength:[tempValue stringValue] maxLength:18];
        lastOperation = operationString;
    } else if ([operationString isEqualToString:@"="]){
        while (stack.count > 0) {
            NSString* one = [stack lastObject];
            if ([operationArray containsObject:one]) {
                break;
            }
            [stack removeLastObject];
            NSString* op = [stack lastObject];
            [stack removeLastObject];
            tempValue  = [self calculate:one numberTwo:[tempValue stringValue] operation:op];
        }
        
        self.outputTextField.text = [self fixDisplayTextLength:[tempValue stringValue] maxLength:18];
        lastOperation = @"";
    }

}
/**
 * 四则运算
 */
- (NSNumber*) calculate:(NSString*) numberOne numberTwo:(NSString*) numberTwo operation:(NSString*) operation {
    double result = 0;
    NSNumber* _numberOne = [NSNumber numberWithDouble:[numberOne doubleValue]];
    NSNumber* _numberTwo = [NSNumber numberWithDouble:[numberTwo doubleValue]];
    if ([_numberOne doubleValue] == INFINITY || [_numberTwo doubleValue] == INFINITY) {
        return [NSNumber numberWithDouble:0];
    }
    if ([operation isEqualToString:@"+"]) {
        result = [_numberOne doubleValue] + [_numberTwo doubleValue];
    }else if([operation isEqualToString:@"﹣"]){
        result = [_numberOne doubleValue] - [_numberTwo doubleValue];
    }else if ([operation isEqualToString:@"×"]){
        result = [_numberOne doubleValue] * [_numberTwo doubleValue];
    } else if ([operation isEqualToString:@"÷"]){
        result = [_numberOne doubleValue] / [_numberTwo doubleValue];
    }
    return [NSNumber numberWithDouble:result];
}
/**
 * 优先级计算
 */
- (NSInteger) priority:(NSString*) operation {
    if ([operation isEqualToString:@"+"] || [operation isEqualToString:@"﹣"]) {
        return 1;
    } else if ([operation isEqualToString:@"×"] || [operation isEqualToString:@"÷"]){
        return 2;
    } else if ([operation isEqualToString:@")"] || [operation isEqualToString:@"("]){
        return 0;
    } else {
        return -1;
    }
}

- (NSString*) fixDisplayTextLength: (NSString*) string maxLength:(NSInteger) maxLength {
    NSString* result = string;
    if (string.length > maxLength) {
        NSRange range = [string rangeOfString:@"e"];
        //使用科学计数法
        if (range.location != NSNotFound) {
            NSString* suffix = [string substringFromIndex:range.location];
            NSString* prefix = [string substringToIndex:(maxLength-suffix.length)];
            result = [prefix stringByAppendingString:suffix];
        } else {
            result = [string substringToIndex:maxLength];
        }
    }
    return result;
}
@end
