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
//NSArray* operationArray;
//记忆体数据
NSNumber* memoryValue;
//显示暂存值
NSNumber* tempValue;
//运算栈
NSMutableArray* stack;
//左括号数目
NSInteger leftBracketCount;
//数字能否覆写显示区域
BOOL canOverwriteScreen;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.memoryLabel.hidden = YES;
    memoryValue = [NSNumber numberWithDouble:0];
    tempValue = [NSNumber numberWithDouble:0];
    canOverwriteScreen = NO;
    leftBracketCount = 0;
    stack = [NSMutableArray new];
//    operationArray = @[@"+",@"﹣",@"×",@"÷",@"=",@"%",@"(",@")",@"AC",@"MC",@"M+",@"M-",@"MR",@"←"];
    numberArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return NO;
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
            if ([buttonTitle  isEqual: @"0"]){
                if ((![displayText hasPrefix:@"0"]) || ([displayText rangeOfString:@"."].length>0)) {
                    self.outputTextField.text = [displayText stringByAppendingString:buttonTitle];
                    tempValue = [NSNumber numberWithDouble:[self.outputTextField.text doubleValue]];
                } else {
                    tempValue = [NSNumber numberWithDouble:0];
                }
            } else if([buttonTitle  isEqual: @"."]) {
                if ([displayText rangeOfString:@"."].length==0) {
                    self.outputTextField.text = [displayText stringByAppendingString:buttonTitle];
                    tempValue = [NSNumber numberWithDouble:[self.outputTextField.text doubleValue]];
                }
            } else {
                if ([displayText isEqual:@"0"]) {
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
    if ([operationString isEqual:@"AC"]) {
        [stack removeAllObjects];
        tempValue = [NSNumber numberWithDouble:0];
        self.outputTextField.text = @"0";
        leftBracketCount = 0;
        canOverwriteScreen = NO;
    } else if([operationString isEqual:@"MC"]){
        memoryValue = [NSNumber numberWithDouble:0];
        self.memoryLabel.hidden = YES;
    } else if([operationString isEqual:@"MR"]){
        self.outputTextField.text = [memoryValue stringValue];
        tempValue = memoryValue;
    } else if([operationString isEqual:@"M+"]){
        memoryValue = [NSNumber numberWithDouble:[memoryValue doubleValue]+[self.outputTextField.text doubleValue]];
        self.memoryLabel.hidden = NO;
    } else if([operationString isEqual:@"M-"]){
        memoryValue = [NSNumber numberWithDouble:[memoryValue doubleValue]-[self.outputTextField.text doubleValue]];
        self.memoryLabel.hidden = NO;
    } else if([operationString isEqual:@"←"]){
        NSString* displayText = self.outputTextField.text;
        if (displayText.length > 1) {
            self.outputTextField.text = (displayText = [displayText substringToIndex:displayText.length-1]);
        } else {
            self.outputTextField.text = displayText = @"0";
        }
        tempValue = [NSNumber numberWithDouble:[displayText doubleValue]];
    } else if([operationString isEqual:@"%"]){
        tempValue = [NSNumber numberWithDouble:([tempValue doubleValue] /100)];
        self.outputTextField.text = [tempValue stringValue];
    } else if([operationString isEqual:@"+"] || [operationString isEqual:@"﹣"] || [operationString isEqual:@"×"] || [operationString isEqual:@"÷"] || [operationString isEqual:@"%"]) {
        
        if ((stack.count == 0) || (leftBracketCount>0)) {
            [stack addObject:operationString];
        } else {
            NSString* one = [stack lastObject];
            [stack removeLastObject];
            NSString* op = [stack lastObject];
            [stack removeLastObject];
            tempValue  = [self calculate:one numberTwo:[tempValue stringValue] operation:op];
            self.outputTextField.text = [tempValue stringValue];
            [stack addObject:operationString];
        }
    } else if ([operationString isEqual:@"("]){
        leftBracketCount ++;
    } else if ([operationString isEqual:@")"]){
        NSString* one = [stack lastObject];
        [stack removeLastObject];
        NSString* op = [stack lastObject];
        [stack removeLastObject];
        tempValue  = [self calculate:one numberTwo:[tempValue stringValue] operation:op];
        self.outputTextField.text = [tempValue stringValue];
        leftBracketCount --;
    } else if ([operationString isEqual:@"="]){
        while (stack.count > 0) {
            NSString* one = [stack lastObject];
            [stack removeLastObject];
            NSString* op = [stack lastObject];
            [stack removeLastObject];
            tempValue  = [self calculate:one numberTwo:[tempValue stringValue] operation:op];
        }
        self.outputTextField.text = [tempValue stringValue];
    }

}
/**
 * 四则运算
 */
- (NSNumber*) calculate:(NSString*) numberOne numberTwo:(NSString*) numberTwo operation:(NSString*) operation {
    double result = 0;
    NSNumber* _numberOne = [NSNumber numberWithDouble:[numberOne doubleValue]];
    NSNumber* _numberTwo = [NSNumber numberWithDouble:[numberTwo doubleValue]];
    
    if ([operation isEqual:@"+"]) {
        result = [_numberOne doubleValue] + [_numberTwo doubleValue];
    }else if([operation isEqual:@"﹣"]){
        result = [_numberOne doubleValue] - [_numberTwo doubleValue];
    }else if ([operation isEqual:@"×"]){
        result = [_numberOne doubleValue] * [_numberTwo doubleValue];
    } else if ([operation isEqual:@"÷"]){
        result = [_numberOne doubleValue] / [_numberTwo doubleValue];
    }
    return [NSNumber numberWithDouble:result];
}
@end
