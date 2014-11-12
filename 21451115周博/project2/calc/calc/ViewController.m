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
    
    self.expText.adjustsFontSizeToFitWidth=YES;
    self.expText.minimumScaleFactor=0.5;
    
    self.consoleText.adjustsFontSizeToFitWidth=YES;
    self.consoleText.minimumScaleFactor=0.5;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//=============NUM PAD==============
- (IBAction)btn0:(id)sender
{
    [stack pushNum:@"0"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn1:(id)sender
{
    [stack pushNum:@"1"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn2:(id)sender
{
    [stack pushNum:@"2"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn3:(id)sender
{
    [stack pushNum:@"3"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn4:(id)sender
{
    [stack pushNum:@"4"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn5:(id)sender
{
    [stack pushNum:@"5"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn6:(id)sender
{
    [stack pushNum:@"6"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn7:(id)sender
{
    [stack pushNum:@"7"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn8:(id)sender
{
    [stack pushNum:@"8"];
    [self.consoleText setText:stack.console];
}
- (IBAction)btn9:(id)sender
{
    [stack pushNum:@"9"];
    [self.consoleText setText:stack.console];
}

- (IBAction)btnDot:(id)sender
{
    [stack pushDot];
    [self.consoleText setText:stack.console];
}


-(IBAction)btnLbrace:(id)sender{
    [stack pushOp:LBRACE];
    [self.expText setText:stack.expersion];
}

-(IBAction)btnRbrace:(id)sender{
    [stack pushOp:RBRACE];
    [self.expText setText:stack.expersion];
}

//==========OPERATOR PAD ==============
- (IBAction)btnEqual:(id)sender
{
    [stack pushOp:EQUAL];
    [self.consoleText setText:stack.console];
    [self.expText setText:stack.expersion];
}
- (IBAction)btnPlus:(id)sender
{
    //[stack pushOperation:PLUS];
    [stack pushOp:PLUS];
    [self.consoleText setText:stack.console];
    [self.expText setText:stack.expersion];
}
- (IBAction)btnMinus:(id)sender
{
    //[stack pushOperation:MINUS];
     [stack pushOp:MINUS];
    [self.consoleText setText:stack.console];
    [self.expText setText:stack.expersion];
}
- (IBAction)btnMultiply:(id)sender
{
    //[stack pushOperation:MULTIPLY];
     [stack pushOp:MULTIPLY];
    [self.consoleText setText:stack.console];
    [self.expText setText:stack.expersion];
}
- (IBAction)btnDivide:(id)sender
{
    //[stack pushOperation:DIVIDE];
     [stack pushOp:DIVIDE];
    [self.consoleText setText:stack.console];
    [self.expText setText:stack.expersion];
}

- (IBAction)btnSgn:(id)sender
{
    [stack pushOp:SGN];
    [self.consoleText setText:stack.console];
}
- (IBAction)btnPercent:(id)sender
{
    [stack pushOp:PERCENT];
}

//=========FUNCTION PAD============
- (IBAction)btnClear:(id)sender
{
    [stack clear];
    [self.consoleText setText:stack.console];
    [self.expText setText:stack.expersion];
}
- (IBAction)btnDelete:(id)sender
{
    [stack popNum];
    [self.consoleText setText:stack.console];
}

- (IBAction)btnMemoryClear:(id)sender
{
    [stack memoryClear];
    [self.mFlag setText:@""];
}

- (IBAction)btnMemoryAdd:(id)sender
{
    [stack memoryAdd];
    [self.mFlag setText:@"M"];
}


- (IBAction)btnMemoryMinus:(id)sender
{
    [stack memoryMinus];
    //[self.mFlag setText:@"M"];

}
- (IBAction)btnMemoryRead:(id)sender
{
    [stack memoryRead];
    [self.consoleText setText:stack.console];
}
@end
