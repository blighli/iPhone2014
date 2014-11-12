//
//  ViewController.m
//  MyCalculator
//
//  Created by 周翔 on 14/11/10.
//  Copyright (c) 2014年 周翔. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize display;



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ValueMR = 0;
    num1 = 0;
    FlagOp = NO;
    FlagDot = NO;
    JudgeLeft = YES;
    LenthDot = 0;
    is_Operator = 0;
    JudgeBug = NO;
    ori = @"0";
    JudgedotBug = NO;
    bug = YES;
    JudgeOp = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ButtonNumber:(UIButton *)sender
{
    UIButton *btn_Number = (UIButton *)sender;
    if (FlagOp == NO) {
        if ([[self changeFloat:num1]length] >=18) {
            return;
        }
        left = [[btn_Number currentTitle] integerValue];
        if (JudgeOp == YES) {
            num1 = 0;
        }
        if(FlagDot == NO) {
            num1 = num1 * 10 +left;
            Answer = [self changeFloat:num1];
        }
        else {
            LenthDot++;
            num1 = num1 + pow(0.1,LenthDot) * left;
            if (left == 0) {
                Answer = [NSString stringWithFormat:@"%@%@",Answer,ori];
            }
            else {
                Answer = [self changeFloat:num1];
            }
        }
        display.text = Answer;
        JudgeBug = NO;
        if (bug_x == YES) {
            num2 = 0;
        }
        else if (bug_x == NO) {
            num2 = 1;
        }
        JudgeOp = YES;
    }
    else {
        if ([[self changeFloat:num2]length] >=18) {
            return;
        }
        right = [[btn_Number currentTitle] integerValue];
        if(FlagDot == NO) {
            num2 = num2 * 10 +right;
            Answer = [self changeFloat:num2];
        }
        else {
            LenthDot++;
            num2 = num2 + pow(0.1,LenthDot) * right;
            if (right == 0) {
                Answer = [NSString stringWithFormat:@"%@%@",Answer,ori];
            }
            else {
                Answer = [self changeFloat:num2];
            }
        }
        
        display.text = Answer;
        JudgeLeft = YES;
        JudgeOp = NO;
    }
    JudgedotBug = NO;
    //NSLog(@"%i",btn_Number.tag);
}

- (IBAction) ButtonAC:(UIButton *)sender
{
    FlagOp = NO;
    FlagDot = NO;
    LenthDot = 0;
    num1 = 0;
    num2 = 0;
    JudgeLeft = YES;
    is_Operator = 0;
    JudgeBug = NO;
    display.text = @"0";
    JudgedotBug = NO;
    bug = YES;
    JudgeOp = YES;
}

- (IBAction) ButtonOperator:(UIButton *)sender
{
    UIButton *btn_Operator = (UIButton *)sender;
    if (FlagOp == YES && JudgeLeft == YES) {
        [self Processing:is_Operator];
    }
    is_Operator = btn_Operator.tag;
    FlagOp = YES;
    JudgeLeft = NO;
    FlagDot = NO;
    num2 = 0;
    LenthDot = 0;
    JudgedotBug = NO;
    bug = YES;
    JudgeOp = NO;
    //NSLog(@"%i",btn_Operator.tag);
}

- (IBAction)Buttonequal:(UIButton *)sender
{
    [self Processing:is_Operator];
    FlagOp = NO;
    JudgeBug = YES;
    FlagDot = NO;
    LenthDot = 0;
    left = 0;
    JudgedotBug = YES;
    bug = YES;
    JudgeOp = YES;
}

- (IBAction) ButtonMC:(UIButton *)sender {
    ValueMR = 0;
    [self AllClear];
    display.text = @"0";
    //NSLog(@"%f",MR_value);
}

- (IBAction) ButtonMPlus:(UIButton *)sender {
    ValueMR = ValueMR+[display.text doubleValue];
    [self AllClear];
}

- (IBAction) ButtonMMinus:(UIButton *)sender {
    ValueMR = ValueMR-[display.text doubleValue];
    [self AllClear];
    //NSLog(@"%f",MR_value);
}

- (IBAction) ButtonMR:(UIButton *)sender {
    Answer = [self changeFloat:ValueMR];
    display.text = Answer;
    [self AllClear];
}

- (IBAction) ButtonSigntrs:(UIButton *)sender
{
    if (JudgeOp == YES) {
        num1 = 0 - num1;
        display.text = [self changeFloat:num1];
    }
    else {
        num2 = 0 - num2;
        display.text = [self changeFloat:num2];
    }
    
}

- (IBAction) ButtonDot:(UIButton *)sender
{
    FlagDot = YES;
    if (bug == YES) {
        if (FlagOp == NO) {
            Answer = [NSString stringWithFormat:@"%@.",[self changeFloat:num1]];
            display.text = Answer;
        }
        else {
            Answer = [NSString stringWithFormat:@"%@.",[self changeFloat:num2]];
            display.text = Answer;
        }
        bug = NO;
    }
    if (JudgedotBug == YES) {
        num1 = 0;
        Answer = @"0.";
        display.text = Answer;
    }
    JudgedotBug = NO;
}


- (void) AllClear
{
    FlagOp = NO;
    FlagDot = NO;
    LenthDot = 0;
    num1 = 0;
    num1 = 0;
    JudgeLeft = YES;
    is_Operator = 0;
    JudgeBug = NO;
    JudgedotBug = NO;
    bug = YES;
    JudgeOp = YES;
}

- (void) Processing:(int)concequence
{
    switch (concequence) {
        case 1:
            num1 = num1 + num2;
            Answer = [self changeFloat:num1];
            display.text = Answer;
            bug_x = YES;
            break;
        case 2:
            num1 = num1 - num2;
            Answer = [self changeFloat:num1];
            display.text = Answer;
            bug_x = YES;
            break;
        case 3:
            num1 = num1 * num2;
            Answer = [self changeFloat:num1];
            display.text = Answer;
            bug_x = NO;
            break;
        case 4:
            num1 = num1 / num2;
            Answer = [self changeFloat:num1];
            display.text = Answer;
            bug_x = NO;
            break;
        case 5:
            rleft = (int)num1;
            rright = (int)num2;
            num1 = rleft%rright;
            //result_left = result_left / result_right;
            Answer = [self changeFloat:num1];
            display.text = Answer;
            bug_x = NO;
            break;
        default:
            break;
    }
    if ([[self changeFloat:num1] isEqualToString:@"-0"]) {
        display.text = @"0";
    }
}

- (NSString *) changeFloat:(double)Right
{
    NSString *stringFloat;
    stringFloat = [NSString stringWithFormat:@"%.12f",Right];
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

@end
