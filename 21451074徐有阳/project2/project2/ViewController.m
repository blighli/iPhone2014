//
//  ViewController.m
//  project2
//
//  Created by xuyouyang on 14/11/8.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *numberStack; // 求值时需要用到的数字栈
@property (strong, nonatomic) NSMutableArray *stack; // 中转后时需要用到的栈
@property (strong, nonatomic) NSDictionary *levelDictionary; // 优先级字典
@property (weak, nonatomic) IBOutlet UILabel *screenLabel; // 屏幕
@property (strong, nonatomic) NSMutableString *inputExpression; // 输入表达式

@property double memory; // 寄存器
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    _stack = [[NSMutableArray alloc]init];
    _numberStack = [[NSMutableArray alloc]init];
    _inputExpression = [[NSMutableString alloc]initWithString:@""];
    _memory = 0.0;
    _screenLabel.text = @"0";
    _levelDictionary = @{
                         @"(" : @"0",
                         @"+" : @"1",
                         @"-" : @"1",
                         @"*" : @"2",
                         @"/" : @"2",
                         @"%" : @"2"
                         };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 数字和运算符点击事件
- (IBAction)numberClick:(id)sender {
    NSString *op = ((UIButton*)sender).titleLabel.text;
    if ([op isEqualToString:@"."] && [_inputExpression isEqualToString:@""]){
        // 第一个输入如果是小数点，自动再最前面加0
        _inputExpression = [NSMutableString stringWithString:@"0."];
    }
    else if ([op isEqualToString:@"."] && [[_inputExpression substringWithRange:NSMakeRange(_inputExpression.length - 1, 1)] isEqualToString:@"."]){
        // 小数点后不能加小数点
    }
    else if ([op isEqualToString:@"0"] && _inputExpression.length==1 && [[_inputExpression substringWithRange:NSMakeRange(_inputExpression.length - 1, 1)] isEqualToString:@"0"]) {
        // 第一个0的后面不能跟0
    }
    else {
        [_inputExpression appendString:op];
    }
    self.screenLabel.text = _inputExpression;
}

// 等号点击事件
- (IBAction)resultClick:(id)sender {
    double result = [self evaluate:[self inToPost:[self separateString:_inputExpression]]];
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
        double result = [self evaluate:[self inToPost:[self separateString:_inputExpression]]];
        self.screenLabel.text = [NSString stringWithFormat:@"%g", result];
        _inputExpression = [NSMutableString stringWithFormat:@"%g", result];
        self.memory += result;
    }
    if ([op isEqualToString:@"M-"]) {
        double result = [self evaluate:[self inToPost:[self separateString:_inputExpression]]];
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
- (void)pushNumber:(NSNumber *)number
{
    [_numberStack addObject: number];
}

// 数字出栈
- (double)popNumber
{
    NSNumber *number = [_numberStack lastObject];
    if (_numberStack) {
        [_numberStack removeLastObject];
    }
    return [number doubleValue];
}

// 进栈
- (void)push:(NSString *)obj
{
    [_stack addObject:obj];
}

// 出栈
- (void)pop
{
    if (_stack) {
        [_stack removeLastObject];
    }
}

// 栈顶元素
- (NSString *)top
{
    return [_stack lastObject];
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

// 利用后缀表达式求值
-(double)evaluate:(NSMutableArray *)postString
{
    for (int i = 0; i < [postString count]; ++i) {
        if ([postString[i] isEqualToString:@"+"])
        {
            double b = [self popNumber];
            double a = [self popNumber];
            [self pushNumber: [NSNumber numberWithDouble:(a + b)]];
        }
        else if ([postString[i] isEqualToString:@"-"])
        {
            double b = [self popNumber];
            double a = [self popNumber];
            [self pushNumber:[NSNumber numberWithDouble:(a - b)]];
        }
        else if ([postString[i] isEqualToString:@"*"])
        {
            double b = [self popNumber];
            double a = [self popNumber];
            [self pushNumber:[NSNumber numberWithDouble:(a * b)]];
        }
        else if ([postString[i] isEqualToString:@"/"])
        {
            double b = [self popNumber];
            double a = [self popNumber];
            [self pushNumber:[NSNumber numberWithDouble:(a / b)]];
        }
        else if ([postString[i] isEqualToString:@"%"])
        {
            double b = [self popNumber];
            double a = [self popNumber];
            [self pushNumber:[NSNumber numberWithDouble:(double)((int)a%(int)b)]];
        }
        else
            [self pushNumber:[NSNumber numberWithDouble:[postString[i] doubleValue]]];
    }
    return [self popNumber];
}

// 中缀表达式转后缀表达式
- (NSMutableArray *)inToPost: (NSMutableArray *)inString {
    NSMutableArray *postString = [[NSMutableArray alloc]init];
    for (int i = 0; i < [inString count]; ++i) {
        NSString *s = inString[i];
        if ([s isEqualToString:@"("]) [self push:s];
        else if ([_levelDictionary[s] isEqualToString:@"1"]){
            while ([self.stack count] && _levelDictionary[s] <= _levelDictionary[[self top]]) {
                [postString addObject:[self top]];
                [self pop];
            }
            [self push:s];
        }
        else if ([_levelDictionary[s] isEqualToString:@"2"])  [self push:s];
        else if ([s isEqualToString:@")"]) {
            while ([self.stack count]) {
                if ([[self top] isEqualToString:@"("]) {
                    [self pop];
                    break;
                }
                [postString addObject:[self top]];
                [self pop];
            }
        }
        else
            [postString addObject:s];
    }
    while ([self.stack count]) {
        [postString addObject:[self top]];
        [self pop];
    }
    return postString;
}
@end
