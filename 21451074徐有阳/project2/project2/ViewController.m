//
//  ViewController.m
//  project2
//
//  Created by xuyouyang on 14/11/8.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *numberStack; // 数字栈
@property (strong, nonatomic) NSMutableArray *operatorStack; // 操作符栈
@property (weak, nonatomic) IBOutlet UILabel *screenLabel; // 屏幕
@property (strong, nonatomic) NSMutableString *inputExpression; // 输入表达式
@property double memory; // 寄存器
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    _numberStack = [[NSMutableArray alloc]init];
    _operatorStack = [[NSMutableArray alloc]init];
    _inputExpression = [[NSMutableString alloc]initWithString:@""];
    _memory = 0.0;
    _screenLabel.text = @"0";
    double r = [self evaluate:[self separateString:@"(1+2*3)+1"]];
    NSLog(@"%lf", r);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// 数字和运算符点击事件
- (IBAction)numberClick:(id)sender {
    [_inputExpression appendString:((UIButton*)sender).titleLabel.text];
    self.screenLabel.text = _inputExpression;
}

// 等号点击事件
- (IBAction)resultClick:(id)sender {
    double result = [self evaluate:[self separateString:_inputExpression]];
    self.screenLabel.text = [NSString stringWithFormat:@"%g", result];
    _inputExpression = [NSMutableString stringWithFormat:@"%g", result];
}

// 内存相关按钮点击事件
- (IBAction)memoryClick:(id)sender {
    NSString *op = ((UIButton *)sender).titleLabel.text;
    if ([op isEqualToString:@"MC"]) {
        self.memory = 0.0;
    }
    if ([op isEqualToString:@"M+"]) {
        double result = [self evaluate:[self separateString:_inputExpression]];
        self.screenLabel.text = [NSString stringWithFormat:@"%g", result];
        _inputExpression = [NSMutableString stringWithFormat:@"%g", result];
        self.memory += result;
    }
    if ([op isEqualToString:@"M-"]) {
        double result = [self evaluate:[self separateString:_inputExpression]];
        self.screenLabel.text = [NSString stringWithFormat:@"%g", result];
        _inputExpression = [NSMutableString stringWithFormat:@"%g", result];
        self.memory -= result;
    }
    if ([op isEqualToString:@"MR"]) {
        self.screenLabel.text = [NSString stringWithFormat:@"%g", self.memory];
        _inputExpression = [NSMutableString stringWithFormat:@"%g", self.memory];
    }
}

// AC按钮点击事件
- (IBAction)clearClick:(id)sender {
    _inputExpression = [NSMutableString stringWithString:@""];
    self.screenLabel.text = @"0";
}

// 数字进栈
-(void)pushNumber:(NSNumber *)number
{
    [_numberStack addObject: number];
}

// 数字出栈
-(double)popNumber
{
    NSNumber *number = [_numberStack lastObject];
    if (_numberStack) {
        [_numberStack removeLastObject];
    }
    return [number doubleValue];
}

// 运算符进栈
-(void)pushOperator:(NSString *)operator
{
    [_operatorStack addObject:operator];
}

// 运算符出栈
-(NSString *)popOperator
{
    NSString *operator = [_operatorStack lastObject];
    if (_operatorStack) {
        [_operatorStack removeLastObject];
    }
    return operator;
}

// 将字符串转为的数字或操作符数组
-(NSMutableArray *)separateString:(NSString *)string
{
    NSMutableArray *expression = [[NSMutableArray alloc]init];
    // 切分条件
    NSCharacterSet *operators = [NSCharacterSet characterSetWithCharactersInString:@"+-*/%()"];
    NSString *number =@"";
    for (int i = 0; i < string.length; ++i) {
        char c = [string characterAtIndex:i];
        if ([operators characterIsMember:c]) {
            if (![number isEqualToString:@""]) {
                [expression addObject:number];
                number = @"";
            }
            [expression addObject:[NSString stringWithFormat:@"%c",c]];
        }
        else
            number = [number stringByAppendingString:[NSString stringWithFormat:@"%c",c]];
        if (i == string.length - 1 && ![number isEqualToString:@""]) {
            [expression addObject:number];
        }
    }
    [expression insertObject:@"(" atIndex:0];
    [expression addObject:@")"];
    return expression;
}

// 利用栈求表达式的值
-(double)evaluate:(NSMutableArray *)expression
{
    while ([expression count] > 0) {
        NSString *s = [expression firstObject];
        if (([s stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@")1234567890."]].length)) {
            NSLog(@"%@", s);
            [self pushOperator:s];
        }
//        if ([s isEqualToString:@"("])
//            [self pushOperator:s];
//        else if ([s isEqualToString:@"+"])
//            [self pushOperator:s];
//        else if ([s isEqualToString:@"-"])
//            [self pushOperator:s];
//        else if ([s isEqualToString:@"*"])
//            [self pushOperator:s];
//        else if ([s isEqualToString:@"/"])
//            [self pushOperator:s];
//        else if ([s isEqualToString:@"%"])
//            [self pushOperator:s];
        else if ([s isEqualToString:@")"])
        {
            while ([_operatorStack count]) {
                NSString *operator = [self popOperator];
                if ([operator isEqualToString:@"("]) break;
                double result = [self popNumber];
                if ([operator isEqualToString:@"+"])
                    result = [self popNumber] + result;
                else if ([operator isEqualToString:@"-"])
                    result = [self popNumber] - result;
                else if ([operator isEqualToString:@"*"])
                    result = [self popNumber] * result;
                else if ([operator isEqualToString:@"/"])
                    result = [self popNumber] / result;
                else if ([operator isEqualToString:@"%"])
                        result = (int)[self popNumber] % (int)result;
                [self pushNumber:[NSNumber numberWithDouble:(double)result]];
            }
        }
        else
            [self pushNumber:[NSNumber numberWithDouble:[s doubleValue]]];
        [expression removeObjectAtIndex:0];
    }
    return [self popNumber];
}
@end
