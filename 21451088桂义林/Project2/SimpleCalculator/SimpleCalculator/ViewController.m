//
//  ViewController.m
//  SimpleCalculator
//
//  Created by YilinGui on 14-11-3.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import "ViewController.h"
#import "ExprSolver.h"

@interface ViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL currentNumIsDecimal;
@property (nonatomic) double memoryValue;
@property (nonatomic) BOOL hasMemorayValue;
@property (nonatomic, strong) ExprSolver *exprSolver;

@end

@implementation ViewController

@synthesize display = _display;
@synthesize resultLabel = _resultLabel;
@synthesize memoryLabel = _memoryLabel;

@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize currentNumIsDecimal = _currentNumIsDecimal;
@synthesize memoryValue = _memoryValue;
@synthesize hasMemorayValue = _hasMemorayValue;
@synthesize exprSolver = _exprSolver;

// 重写getter
- (ExprSolver *)exprSolver {
    if (!_exprSolver) _exprSolver = [[ExprSolver alloc] init];
    return _exprSolver;
}

// 内存操作按钮响应函数
// MC: 清空内存
// M+: 将显示值与内存值相加
// M-: 将内存值减去显示值
// MR: 重新调用存储再内存中的值
- (IBAction)memoryOperation:(UIButton *)sender {
    NSString *operation = [sender currentTitle];
    if ([operation isEqualToString:@"MC"]) {
        self.memoryLabel.text = @"";
        self.memoryValue = 0;
        self.hasMemorayValue = NO;
        
    } else if ([operation isEqualToString:@"M+"]) {
        self.memoryLabel.text = @"M";
        [self solveExpr];
        double resultVal = [self.resultLabel.text doubleValue];
        self.memoryValue += resultVal;
        self.hasMemorayValue = YES;
        
    } else if ([operation isEqualToString:@"M-"]) {
        self.memoryLabel.text = @"M";
        [self solveExpr];
        double resultVal = [self.resultLabel.text doubleValue];
        self.memoryValue -= resultVal;
        self.hasMemorayValue = YES;
        
    } else if ([operation isEqualToString:@"MR"]) {
        if (self.hasMemorayValue) {
            NSString *memoryValueStr = [NSString stringWithFormat:@"%g", self.memoryValue];
            self.display.text = memoryValueStr;
            self.resultLabel.text = memoryValueStr;
            self.userIsInTheMiddleOfEnteringANumber = NO;
        }
    }
}

// 按下数字键
- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if ([self userIsInTheMiddleOfEnteringANumber]) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

// 清除按钮
- (IBAction)cleanPressed {
    self.display.text = @"0";
    self.resultLabel.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.currentNumIsDecimal = NO;
}

// 运算符按钮
- (IBAction)operationPressed:(UIButton *)sender {
    NSString *operation = [sender currentTitle];
    self.userIsInTheMiddleOfEnteringANumber = YES;
    NSString *lastChar = [self.display.text substringFromIndex:[self.display.text length] - 1];
    //NSLog(@"last char is %@", lastChar);
    if ([lastChar isEqualToString:@"+"] ||
        [lastChar isEqualToString:@"-"] ||
        [lastChar isEqualToString:@"x"] ||
        [lastChar isEqualToString:@"/"] ||
        [lastChar isEqualToString:@"("] ||
        [lastChar isEqualToString:@"%"]) {
        return;
    }
    self.display.text = [self.display.text stringByAppendingString:operation];
    _currentNumIsDecimal = NO;
}

// 删除表达式最后一个字符
- (IBAction)deletePressed {
    if ([self.display.text length] >= 2) {
        self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
    } else {
        [self cleanPressed];
    }
}

// 添加小数点
- (IBAction)decimalPoint {
    self.userIsInTheMiddleOfEnteringANumber = YES;
    NSString *lastChar = [self.display.text substringFromIndex:[self.display.text length] - 1];
    
    if ([lastChar isEqualToString:@"+"] ||
        [lastChar isEqualToString:@"-"] ||
        [lastChar isEqualToString:@"x"] ||
        [lastChar isEqualToString:@"/"] ||
        [lastChar isEqualToString:@"("] ||
        [lastChar isEqualToString:@"%"] ||
        [lastChar isEqualToString:@")"] ||
        [lastChar isEqualToString:@"."]) {
        return;
    }
    if (!_currentNumIsDecimal) {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        _currentNumIsDecimal = YES;
    }
}

// 添加括号
- (IBAction)addParenthesis:(UIButton *)sender {
    NSString *parenthesis = [sender currentTitle];
    NSString *lastChar = [self.display.text substringFromIndex:[self.display.text length] - 1];
    if ([parenthesis isEqualToString:@"("]) {
        
        if (!self.userIsInTheMiddleOfEnteringANumber) {
            self.userIsInTheMiddleOfEnteringANumber = YES;
            self.display.text = parenthesis;
            return;
        }
        if ([lastChar isEqualToString:@"+"] ||
            [lastChar isEqualToString:@"-"] ||
            [lastChar isEqualToString:@"x"] ||
            [lastChar isEqualToString:@"("] ||
            [lastChar isEqualToString:@"/"] ||
            [lastChar isEqualToString:@"%"]) {
            self.display.text = [self.display.text stringByAppendingString:parenthesis];
        }
        
    } else {
        
        if (!self.userIsInTheMiddleOfEnteringANumber) {
            return;
        }
        
        if ([lastChar isEqualToString:@"+"] ||
            [lastChar isEqualToString:@"-"] ||
            [lastChar isEqualToString:@"x"] ||
            [lastChar isEqualToString:@"/"] ||
            [lastChar isEqualToString:@"("] ||
            [lastChar isEqualToString:@"%"] ||
            [lastChar isEqualToString:@"."]) {
            return;
        }
        
        self.display.text = [self.display.text stringByAppendingString:parenthesis];
    }
}

// 改变符号
- (IBAction)minusSign {
    [self solveExpr];
    if (![self.display.text isEqualToString:@"Invalid Expression!"] &&
        ![self.display.text isEqualToString:@"Cannot divide 0!"] &&
        ![self.display.text isEqualToString:@"Only intergers have % operation!"] &&
        [self.display.text doubleValue] != 0) {
        double dval = [self.exprSolver getValueOfExpr:self.resultLabel.text];
        dval = -1 * dval;
        self.display.text = [NSString stringWithFormat:@"%g", dval];
        self.resultLabel.text = [NSString stringWithFormat:@"%g", dval];
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }
}

// 表达式求值，结果显示在display标签上
- (IBAction)solveExpr {
    NSString *resultStr = [[self exprSolver] getValueOfExprInStringFormat:self.display.text];
    self.display.text = resultStr;
    self.resultLabel.text = resultStr;
    self.userIsInTheMiddleOfEnteringANumber = NO;
    //[[self exprSolver] getValueOfExpr:self.display.text];
}

//---------------------------------------------//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _userIsInTheMiddleOfEnteringANumber = NO;
    _currentNumIsDecimal = NO;
    _memoryValue = 0;
    _hasMemorayValue = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
