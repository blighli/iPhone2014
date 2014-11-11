//
//  ViewController.m
//  Calculator
//
//  Created by 樊博超 on 14-11-7.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "ViewController.h"
#import "Stack.h"
@interface ViewController ()

@end

@implementation ViewController

{
    NSMutableString *outputValue;
    BOOL point;
    enum operator{plus,minus,multi,divide,blank};
    enum operator op;
    Stack *number, *ops;
    double mem;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    outputValue = [[NSMutableString alloc] init];
    [outputValue setString:@"0"];
    point = false;
    op = blank;
    number = [[Stack alloc] init];
    ops = [[Stack alloc] init];
    mem = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setnum:(NSString *)num{
    if ([outputValue isEqualToString: @"0"]) {
        [outputValue setString:num];
    }else{
        [outputValue appendString:num];
    }
    _Printer.text = outputValue;
}

- (IBAction)MCButton:(UIButton *)sender {
    mem = 0;
}

- (IBAction)MPlusButton:(UIButton *)sender {
    mem += [outputValue doubleValue];
}

- (IBAction)MMinusButton:(UIButton *)sender {
    mem -= [outputValue doubleValue];
}

- (IBAction)MRButton:(UIButton *)sender {
    _Printer.text = [NSString stringWithFormat:@"%g",mem];
    outputValue = [NSMutableString stringWithFormat:@"%g", mem];
}

- (IBAction)deleteButton:(UIButton *)sender {
    if ([outputValue length] == 1) {
        [outputValue setString:@"0"];
    }else{
        if ([outputValue characterAtIndex:[outputValue length] - 1] == '.') {
            point = false;
        }
        [outputValue setString:[outputValue substringToIndex:([outputValue length] - 1)]];
    }
    

    _Printer.text = outputValue;
}

- (IBAction)leftBrackets:(UIButton *)sender {
    [self pushStack:@"("];
}

- (IBAction)rightBrackets:(UIButton *)sender {
    [number push:outputValue];
    [self pushStack:@")"];
}

- (IBAction)modButton:(UIButton *)sender {
    double num =[outputValue doubleValue];
    num /= 100;
    outputValue = [NSMutableString stringWithFormat:@"%g", num];
    _Printer.text = outputValue;
}

- (IBAction)ACButton:(UIButton *)sender {
    [outputValue setString:@"0"];
    point = false;
    _Printer.text = outputValue;
    [number clear];
    [ops clear];
}

- (IBAction)divide:(UIButton *)sender {
    op = divide;
    [number push:outputValue];
    [self pushStack:@"/"];
    [outputValue setString:@"0"];
    _Printer.text = outputValue;
    point = false;
    
}

- (IBAction)multi:(UIButton *)sender {
    op = multi;
    [number push:outputValue];
    [self pushStack:@"*"];
    [outputValue setString:@"0"];
    _Printer.text = outputValue;
    point = false;
    
}

- (IBAction)plus:(UIButton *)sender {
    [number push:outputValue];
    op = plus;
     [self pushStack:@"+"];
    [outputValue setString:@"0"];
    _Printer.text = outputValue;
    point = false;
   
}

- (IBAction)sevenButton:(UIButton *)sender {
    [self setnum:(@"7") ];
}

- (IBAction)eightButton:(UIButton *)sender {
    [self setnum:(@"8") ];
}

- (IBAction)nineButton:(UIButton *)sender {
    [self setnum:(@"9") ];
}

- (IBAction)minus:(UIButton *)sender {
    op = minus;
    [number push:outputValue];
    [self pushStack:@"-"];
    [outputValue setString:@"0"];
    _Printer.text = outputValue;
    point = false;
    
}

- (IBAction)fourButton:(UIButton *)sender {
    [self setnum:(@"4") ];
}

- (IBAction)fiveButton:(UIButton *)sender {
    [self setnum:(@"5") ];
}

- (IBAction)sixButton:(UIButton *)sender {
    [self setnum:(@"6") ];
}

- (IBAction)posOrNeg:(UIButton *)sender {

        double  temp = [outputValue doubleValue];
        temp = -temp;
        outputValue = [NSMutableString stringWithFormat:@"%g", temp];

    _Printer.text = outputValue;
}

- (IBAction)oneButton:(UIButton *)sender {
    [self setnum:(@"1") ];
}

- (IBAction)twoButton:(UIButton *)sender {
    [self setnum:(@"2") ];
}

- (IBAction)threeButton:(UIButton *)sender {
    [self setnum:(@"3") ];
}

- (IBAction)zeroButton:(UIButton *)sender {
    [self setnum:(@"0") ];
}

- (IBAction)pointButton:(UIButton *)sender {
    if (!point) {
        [outputValue appendString:@"."];
        point = true;
        _Printer.text = outputValue;
    }
    
}

- (IBAction)equalButton:(UIButton *)sender {
    [number push:outputValue];


    NSString* opstr;
    double num1;
    double num2;
    double result;
    while (![ops isEmpty]) {
         opstr = [ops pop];
        if([opstr isEqualToString:@"("]) continue;
        num2 = [[number pop] doubleValue];
        num1 = [[number pop] doubleValue];
        result = [self calc:num1 :num2 :opstr];
        [number push:[NSString stringWithFormat:@"%g",result]];
    }
    
    outputValue = [NSMutableString stringWithString:[number pop]];
    _Printer.text = outputValue;
    
}

-(int)valueOfSign:(NSString*)k{
    int returnValue = 0;
    if ([k isEqualToString:@"("]) {
        returnValue = 1;
    }else if ([k isEqualToString:@"+"] || [k isEqualToString:@"+"]){
        returnValue = 2;
    }else if ([k isEqualToString:@"*"] || [k isEqualToString:@"/"]){
        returnValue = 3;
    }
    return returnValue;
}


-(void)pushStack:(NSString *)opstr{
    if ([opstr isEqualToString:@"("]) {
        [ops push:opstr];
    }else if ([opstr isEqualToString:@")"]){
        NSString * temp;
        while (!([(temp = [ops pop]) isEqualToString:@"("] || [ops isEmpty])) {
            double num2 =[[number pop] doubleValue];
            double num1 =[[number pop] doubleValue];
            double result = [self calc:num1 :num2 :temp];
            //[number push:[NSString stringWithFormat:@"%g",result]];
            outputValue = [NSMutableString stringWithFormat:@"%g",result];
            _Printer.text = outputValue;
        }
    }else if ([self valueOfSign:opstr] > [self valueOfSign:[ops gettop]] || [ops isEmpty]){
        [ops push:opstr];
    }else{
        NSString * temp;
        temp = [ops pop];
        double num2 =[[number pop] doubleValue];
        double num1 =[[number pop] doubleValue];
        double result = [self calc:num1 :num2 :temp];
        [number push:[NSString stringWithFormat:@"%g",result]];
        outputValue = [NSMutableString stringWithFormat:@"%g",result];
        _Printer.text = outputValue;
        [ops push:opstr];
    }
}

-(double)calc:(double)num1 :(double)num2 :(NSString *)oper{
    double result;
    char k = [oper characterAtIndex:0];
    NSLog(@"oper = %@\n", oper);
    printf("k = %c\n", k);
    switch (k) {
        case '+':
            result = num1 + num2;
            break;
        case '-':
            result = num1 - num2;
            break;
        case '*':
            result = num1 * num2;
            break;
        case '/':
            if (num2 == 0) {
                _Printer.text = @"not a number!";
                result = 0;
            }else{
                result = num1 / num2;
            }
            break;
        default:
            result = 0;
            break;
    }
    return result;
 }





@end
