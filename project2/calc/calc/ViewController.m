//
//  ViewController.m
//  calc
//
//  Created by zhou on 14/11/3.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "ViewController.h"
#import "ResultStack.h"

@interface ViewController ()

@end

@implementation ViewController

ResultStack *stack;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    stack = [[ResultStack alloc] init];
    [self.mFlag setText:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//=============NUM PAD==============
- (IBAction)btn0OnTouch:(id)sender
{
    [stack pushNum:@"0"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn1OnTouch:(id)sender
{
    [stack pushNum:@"1"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn2OnTouch:(id)sender
{
    [stack pushNum:@"2"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn3OnTouch:(id)sender
{
    [stack pushNum:@"3"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn4OnTouch:(id)sender
{
    [stack pushNum:@"4"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn5OnTouch:(id)sender
{
    [stack pushNum:@"5"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn6OnTouch:(id)sender
{
    [stack pushNum:@"6"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn7OnTouch:(id)sender
{
    [stack pushNum:@"7"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn8OnTouch:(id)sender
{
    [stack pushNum:@"8"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn9OnTouch:(id)sender
{
    [stack pushNum:@"9"];
    [self.consoleText setText:stack.console];
}

- (IBAction)btnDotOnTouch:(id)sender
{
    [stack pushDot];
    [self.consoleText setText:stack.console];
}

//==========OPERATOR PAD ==============
- (IBAction)btnEqualOnTouch:(id)sender
{
    [stack pushOperation:EQUAL];
    [self.consoleText setText:stack.lvaueStack];
    [self.expText setText:stack.expersion];
}
- (IBAction)btnPlusOnTouch:(id)sender
{
    [stack pushOperation:PLUS];
    [self.consoleText setText:stack.console];
    [self.expText setText:stack.expersion];
}
- (IBAction)btnMinusOnTouch:(id)sender
{
    [stack pushOperation:MINUS];
    [self.consoleText setText:stack.console];
    [self.expText setText:stack.expersion];
}
- (IBAction)btnMultiplyOnTouch:(id)sender
{
    [stack pushOperation:MULTIPLY];
    [self.consoleText setText:stack.console];
    [self.expText setText:stack.expersion];
}
- (IBAction)btnDivideOnTouch:(id)sender
{
    [stack pushOperation:DIVIDE];
    [self.consoleText setText:stack.console];
    [self.expText setText:stack.expersion];
}

- (IBAction)btnSgnOnTouch:(id)sender
{
    [stack pushOperation:SGN];
    [self.consoleText setText:stack.console];
}
- (IBAction)btnPercentOnTouch:(id)sender
{
    [stack pushOperation:PERCENT];
}

//=========FUNCTION PAD============
- (IBAction)btnClearOnTouch:(id)sender
{
    [stack clear];
    [self.consoleText setText:stack.console];
    [self.expText setText:stack.expersion];
}
- (IBAction)btnDeleteOnTouch:(id)sender
{
    [stack popNum];
    [self.consoleText setText:stack.console];
}

- (IBAction)btnMemoryClearOnTouch:(id)sender
{
    [stack memoryClear];
    [self.mFlag setText:@""];
}

- (IBAction)btnMemoryWriteOnTouch:(id)sender
{
    [stack memoryWrite];
    [self.mFlag setText:@"M"];
}

- (IBAction)btnMemoryReadOnTouch:(id)sender
{
    [stack memoryRead];
    [self.consoleText setText:stack.console];
}
@end
