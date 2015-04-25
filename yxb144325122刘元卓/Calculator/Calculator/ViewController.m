//
//  ViewController.m
//  Calculator
//
//  Created by SXD on 14/11/10.
//  Copyright (c) 2014年 SXD. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface UIViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL decimalAlreadyExists;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize work;
@synthesize xNumber;
@synthesize aNumber;
@synthesize bNumber;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize decimalAlreadyExists;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitpressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle;
    NSString *decimal = @".";
    if (self.userIsInTheMiddleOfEnteringANumber) {
        if ([digit isEqualToString:decimal])
        {
            if (self.decimalAlreadyExists == NO) {
                self.display.text = [self.display.text stringByAppendingString:digit];
                self.decimalAlreadyExists = YES;
                self.work.text = [self.work.text stringByAppendingString:digit];
            }
        } else {
            self.display.text = [self.display.text stringByAppendingString:digit];
            self.work.text = [self.work.text stringByAppendingString:digit];
        }
    } else {
        if (self.decimalAlreadyExists == NO && [digit isEqualToString:decimal])
        {
            self.display.text = [self.display.text stringByAppendingString:digit];
            self.decimalAlreadyExists = YES;
            self.userIsInTheMiddleOfEnteringANumber = YES;
            self.work.text = [self.work.text stringByAppendingString:digit];
        } else {
            self.display.text = digit;
            self.userIsInTheMiddleOfEnteringANumber = YES;
            self.work.text = [self.work.text stringByAppendingString:digit];
        }
    }
}

- (IBAction)opperationPressed:(id)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain preformOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.decimalAlreadyExists = NO;
    self.work.text = [self.work.text stringByAppendingString: [NSString stringWithFormat:@"%@ = %g", operation, result]];
    
}

- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.decimalAlreadyExists = NO;
    self.display.text = @"0";
    self.work.text = [self.work.text stringByAppendingString:@" "];
}

- (IBAction)clearPressed:(id)sender {
    self.display.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.decimalAlreadyExists = NO;
    _brain = nil;
    self.work.text = @" ";
}

- (IBAction)variablePressed:(id)sender {
    
    NSString *variable = [sender currentTitle];
    
    if ([variable isEqualToString:@"x"]) {
        xNumber.text = self.display.text;
    } else if ([variable isEqualToString:@"a"]) {
        aNumber.text = self.display.text;
    } else if ([variable isEqualToString:@"b"]) {
        bNumber.text = self.display.text;
    }
}

- (IBAction)undoPressed:(id)sender {
    
    if (self.display.text.length == 1) {
        self.display.text = @"0";
        self.decimalAlreadyExists = NO;
        self.userIsInTheMiddleOfEnteringANumber = NO;
        if (self.work.text.length >= 1) {
            self.work.text = [self.work.text substringToIndex:self.work.text.length - 1];
        }
    } else {
        if ([self.display.text hasSuffix:@"."]) {
            self.decimalAlreadyExists = NO;
            self.display.text = [self.display.text substringToIndex:self.display.text.length - 1];
            self.work.text = [self.work.text substringToIndex:self.work.text.length - 1];
        } else {
            self.display.text = [self.display.text substringToIndex:self.display.text.length - 1];
            self.work.text = [self.work.text substringToIndex:self.work.text.length - 1];
        }
    }
}
- (IBAction)testPressed:(id)sender {
    
    NSString *testType = [sender currentTitle];
    double xVariable = [self.xNumber.text doubleValue];
    double aVariable = [self.aNumber.text doubleValue];
    double bVariable = [self.bNumber.text doubleValue];
    double answer;
    
    if ([testType isEqualToString:@"Test 1"]) {
        answer = (xVariable * aVariable) - xVariable;
        self.display.text = [NSString stringWithFormat:@"%g", answer];
        [self.work setText:[NSString stringWithFormat:@"(%@ * %@) - %@ = %@ ", self.xNumber.text, self.aNumber.text,  self.xNumber.text, self.display.text]];
    } else if ([testType isEqualToString:@"Test 2"]) {
        answer = sqrt(xVariable + aVariable + bVariable);
        self.display.text = [NSString stringWithFormat:@"%g", answer];
        [self.work setText:[NSString stringWithFormat:@"SQRT(%@ + %@ + %@) = %@ ", self.xNumber.text, self.aNumber.text,  self.bNumber.text, self.display.text]];
    } else if ([testType isEqualToString:@"Test 3"]) {
        answer = ((xVariable + xVariable) / (aVariable + aVariable)) * bVariable;
        self.display.text = [NSString stringWithFormat:@"%g", answer];
        [self.work setText:[NSString stringWithFormat:@"((%@ + %@) / (%@ + %@)) * %@ = %@ ", self.xNumber.text, self.xNumber.text, self.aNumber.text, self.aNumber.text, self.bNumber.text, self.display.text]];
    }
}
- (void)viewDidUnload {
    [self setXNumber:nil];
    [self setANumber:nil];
    [self setBNumber:nil];
    [super viewDidUnload];
}
@end
