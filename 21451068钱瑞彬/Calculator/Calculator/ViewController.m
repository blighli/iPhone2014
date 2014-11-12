//
//  ViewController.m
//  Calculator
//
//  Created by apple on 14-11-5.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import "ViewController.h"
#import "Calc.h"

@interface ViewController ()

@end


@implementation ViewController


static int MAX_LIMIT = 10;
static double EPS = 1e-10;
static Calc* calc;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.num = [[NSMutableString alloc] initWithString:@""];
    self.pro = [[NSMutableString alloc] initWithString:@""];
    
    self.isMemory = NO;
    self.memoryNum = 0.0;
    self.result = 0;
    self.preOp = '?';
    self.isPoint = NO;
    self.bracketCount = 0;
    
    self.M.alpha = 0;
    self.process.text = @"";
    self.Number.text = @"0";
    
    calc = [[Calc alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// 获取哪个按钮被按下
- (NSString*)showState:(id)sender {
    return [sender titleForState:UIControlStateNormal]; // 获取按钮默认状态下的标题title
}


// 字符串拼接
- (NSString*)contact: (NSString*)s1 : (NSString*)s2 {
    NSMutableString* s = [[NSMutableString alloc] initWithString:s1];
    [s appendString:s2];
    return s;
}


// 是否为负数
- (BOOL)isNegate:(NSString*)s {
    if ([s compare:@""] == NSOrderedSame) return NO;
    if ([s characterAtIndex:0] == '-') return YES;
    return NO;
}


// 数字
- (IBAction)touchNumber:(id)sender {
    int digit = [[self showState:sender] intValue];
    
    if (self.preOp == '=') {
        if (digit != 0) {
            [self.num appendFormat:@"%d", digit];
            self.Number.text = self.num;
        }else {
            self.Number.text = @"0";
        }
    }else {
        if (([self.num length] - self.isPoint) < MAX_LIMIT) {
            
            if (([self.num compare:@""] == NSOrderedSame || fabs([self.num doubleValue]) <= EPS)
                && digit < EPS && self.isPoint == NO) {
                self.Number.text = @"0";
            }else {
                if ([self.num length] > 0 && fabs([self.num doubleValue]) <= EPS && self.isPoint == NO) {
                    if ([self.num characterAtIndex:0] == '-') {
                        [self.num setString:@"-"];
                    }else {
                        [self.num setString:@""];
                    }
                }
                [self.num appendFormat:@"%d", digit];
                self.Number.text = self.num;
            }
        }
    }
    
    self.preOp = '0';
}


// 小数点
- (IBAction)touchPoint:(id)sender {

    if (self.isPoint == NO) {
        self.isPoint = YES;
        if ([self.num compare:@""] == NSOrderedSame) {
            [self.num setString:@"0"];
        }
        [self.num appendString:@"."];
        self.Number.text = self.num;
    }
    
    self.preOp = '.';
}


// 取负
- (IBAction)touchNegate:(id)sender {
    
    if (self.preOp == '=') {
        [self.num setString:@""];
        [self.num appendFormat:@"%f", self.result];
        if ([self isNegate: self.num] == NO) {
            [self.num insertString:@"-" atIndex:0];
        }else {
            NSRange range = {0,1};
            [self.num deleteCharactersInRange:range];
        }
        [self.pro appendFormat:@"("];
        [self.pro appendString:self.num];
        [self.pro appendString:@")"];
        
        [self.num setString:@""];
        self.isPoint = NO;
        self.bracketCount = 0;
        self.preOp = '?';
        
        self.process.text = self.pro;
        self.Number.text = @"0";
        
    }else {
        if ([self.num compare:@""] == NSOrderedSame) {
            [self.num setString:@"-0"];
        }else {
            if ([self isNegate:self.num] == NO) {
                [self.num insertString:@"-" atIndex:0];
            }else {
                NSRange range = {0,1};
                [self.num deleteCharactersInRange:range];
            }
        }
        self.Number.text = self.num;
    }
    self.preOp = '_';
}


// 运算符
- (IBAction)touchOperator:(id)sender {
    NSString* op = [self showState:sender];
    
    if([op compare:@"mod"] == NSOrderedSame) {
        op = @"%";
    }

    if (self.preOp == '=') {
        if ([self isNegate:self.Number.text] == YES) { // 负数
            [self.pro appendString: @"("];
            [self.pro appendFormat: @"%f", self.result];
            [self.pro appendString: @")"];
        }else {
            [self.pro appendFormat: @"%f", self.result];
        }
        [self.pro appendString: op];
        
        [self.num setString:@""];
        self.Number.text = @"0";
    }else {
        if ([self.pro compare:@""] != NSOrderedSame && [self.pro characterAtIndex:[self.pro length]-1] == ')') { // 前一个是否为 ')'
            [self.pro appendString: op];
        }else {
            if ([self.num compare:@""] == NSOrderedSame) {
                [self.num setString:@"0"];
            }
            if ([self.num characterAtIndex:[self.num length]-1] == '.') {
                [self.num appendString:@"0"];
            }
            
            if ([self isNegate:self.num] == YES) {
                [self.pro appendString:@"("];
                [self.pro appendString: self.num];
                [self.pro appendString:@")"];
            }else {
                [self.pro appendString: self.num];
            }
            
            [self.pro appendString: op];
            
            [self.num setString:@""];
            self.isPoint = NO;
        }
    }
    
    self.process.text = self.pro;
    
    self.preOp = 'o';
}


// 括号
- (IBAction)touchBracket:(id)sender {
    NSString* op = [self showState:sender];
    
    if (self.preOp == '=') {
        if ([op compare:@"("] == NSOrderedSame) {
            [self.pro setString:@"("];
            self.process.text = self.pro;
            self.bracketCount = 1;
            self.preOp = '(';
        }else {
            self.preOp = ')';
        }
        
        [self.num setString:@""];
        self.Number.text = @"0";
    }else {
        if([op compare:@"("] == NSOrderedSame) { // '('
            if ([self.pro compare:@""] == NSOrderedSame) {
                [self.pro appendString:op];
                self.process.text = self.pro;
                self.bracketCount++;
                self.preOp = '(';
            }else {
                char ch = [self.pro characterAtIndex:[self.pro length]-1];
                if (ch == '+' || ch == '-' || ch == '*' || ch =='/' || ch == '%'
                    || ch == '(') {
                    [self.pro appendString:op];
                    self.process.text = self.pro;
                    self.bracketCount++;
                    self.preOp = '(';
                }
            }
        }
        else { // ')'
            if (self.bracketCount) {
                if ([self.pro characterAtIndex:[self.pro length]-1] == ')') {
                    [self.pro appendString:@")"];
                    self.process.text = self.pro;
                    self.preOp = ')';
                }else {
                    if ([self.num compare:@""] == NSOrderedSame) {
                        [self.num setString:@"0"];
                    }
                    if ([self.num characterAtIndex:[self.num length]-1] == '.') {
                            [self.num appendString:@"0"];
                    }
                    if ([self isNegate: self.num] == YES) {
                        [self.pro appendString:@"("];
                        [self.pro appendString: self.num];
                        [self.pro appendString:@")"];
                    }else {
                        [self.pro appendString: self.num];
                    }

                    [self.pro appendString:op];
                    self.process.text = self.pro;
                    
                    [self.num setString:@""];
                    self.isPoint = NO;
                    self.preOp = ')';
                }
                
                self.bracketCount--;
            }
        }
    }
}


// X事件
- (IBAction)touchBackSpace:(id)sender {
    
    if (self.preOp == '=') {
        [self.num setString:@""];
        [self.pro setString:@""];
        
        self.result = 0;
        self.isPoint = NO;
        self.bracketCount = 0;
        self.preOp = '?';
        
        self.M.alpha = 0;
        self.process.text = @"";
        self.Number.text = @"0";
    }else {
        if ([self.num compare:@""] == NSOrderedSame) {
            self.Number.text = @"0";
        }else {
            char ch = [self.num characterAtIndex:[self.num length]-1];
            
            if (ch == '.') {
                self.isPoint = NO;
            }
            
            [self.num setString: [self.num substringToIndex:([self.num length]-1)]];
            
            if ([self.num compare:@"-"] == NSOrderedSame) {
                [self.num setString:@""];
            }
            
            if ([self.num compare:@""] == NSOrderedSame) {
                self.Number.text = @"0";
            }else {
                self.Number.text = self.num;
            }
        }
    }
    
    self.preOp = 'X';
}


// AC事件
- (IBAction)touchAC:(id)sender {
    [self.num setString:@""];
    [self.pro setString:@""];
    
    self.result = 0;
    self.isPoint = NO;
    self.bracketCount = 0;
    self.preOp = '?';
    
    self.M.alpha = 0;
    self.process.text = @"";
    self.Number.text = @"0";
}


// M
- (IBAction)touchM:(id)sender {
    NSString* op = [self showState:sender];
    

    if ([op compare:@"MC"] == NSOrderedSame) {
        self.memoryNum = 0.0;
    }else if([op compare:@"M+"] == NSOrderedSame) {
        if(self.preOp == '=') {
            self.memoryNum += self.result;
        }else {
            self.memoryNum += [self.Number.text doubleValue];
        }
    }else if([op compare:@"M-"] == NSOrderedSame) {
        if(self.preOp == '=') {
            self.memoryNum -= self.result;
        }else {
            self.memoryNum -= [self.Number.text doubleValue];
        }
    }else if([op compare:@"MR"] == NSOrderedSame) {
        if (self.preOp == '=') {
            [self.num setString:@""];
            [self.pro setString:@""];
            
            self.result = 0;
            self.isPoint = NO;
            self.bracketCount = 0;
            self.preOp = '?';
            
            self.process.text = @"";
            self.Number.text = @"0";
        }
        
        [self.num setString:@""];
        [self.num appendFormat:@"%.f", self.memoryNum];
        self.Number.text = self.num;
        
        self.preOp = 'M';
    }
    
    if (fabs(self.memoryNum) >= EPS) {
        self.M.alpha = 1;
    }else {
        self.M.alpha = 0;
    }
    
}


// 等号=
- (IBAction)touchCalc:(id)sender {
    if (self.preOp == '=') return;
    
    if ([self.pro compare:@""] == NSOrderedSame) {
        
        if ([self.num compare:@""] == NSOrderedSame) {
            [self.num setString:@"0"];
        }
        if ([self.num characterAtIndex:[self.num length]-1] == '.') {
            [self.num appendString:@"0"];
        }
        if ([self isNegate: self.num] == YES) {
            [self.pro appendString:@"("];
            [self.pro appendString: self.num];
            [self.pro appendString:@")"];
        }else {
            [self.pro appendString: self.num];
        }
        
        [self.pro appendString:@"="];
        self.process.text = self.pro;
        
        self.result = [self.num doubleValue];
        self.Number.text = self.num;
        
        [self.num setString:@""];
        [self.pro setString:@""];
        
        self.isPoint = NO;
        self.bracketCount = 0;
        self.preOp = '=';

    }else {
        char ch = [self.pro characterAtIndex:[self.pro length]-1];
        if (ch != ')') {
            if ([self.num compare:@""] == NSOrderedSame) {
                [self.num setString:@"0"];
            }
            if ([self.num characterAtIndex:[self.num length]-1] == '.') {
                [self.num appendString:@"0"];
            }
            if ([self isNegate: self.num] == YES) {
                [self.pro appendString:@"("];
                [self.pro appendString: self.num];
                [self.pro appendString:@")"];
            }else {
                [self.pro appendString: self.num];
            }
        }
        
        while(self.bracketCount > 0) {
            [self.pro appendString:@")"];
            self.bracketCount--;
        }

        [self.pro appendString:@"="];
        self.process.text = self.pro;
        
        self.result = [calc cal: (self.process.text)];
        self.Number.text = [[NSString alloc] initWithFormat:@"%.10g", self.result];
        
        // 前一个结果是否有异常
        // nan : 对0取膜
        // inf : 除0
        if ([self.Number.text compare:@"nan"] == NSOrderedSame
            || [self.Number.text compare:@"inf"] == NSOrderedSame) {
            self.result = 0.0;
        }
        
        [self.num setString:@""];
        [self.pro setString:@""];
        
        self.isPoint = NO;
        self.bracketCount = 0;
        self.preOp = '=';
    }
}


@end




