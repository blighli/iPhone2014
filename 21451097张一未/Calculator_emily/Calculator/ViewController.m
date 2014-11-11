	//
//  ViewController.m
//  Calculator
//
//  Created by Emily on 14-11-3.
//  Copyright (c) 2014年 emily. All rights reserved.
//

#import "ViewController.h"
#import "Util.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClear:(id)sender {
    self.screen.text = @"";
    self.showingResult = NO;
}

- (IBAction)buttonInput:(id)sender {
    unichar input = [((UIButton*) sender).titleLabel.text characterAtIndex:0];
    unichar last = [self.screen.text characterAtIndex:self.screen.text.length-1];
    if (self.showingResult == YES && ![Util isOperator:input]) [self buttonClear:sender];
    if ([Util isOperator:last] && [Util isOperator:input]) return;
    self.screen.text = [NSString stringWithFormat:@"%@%c", self.screen.text, input];
    self.showingResult = NO;
}

- (IBAction)buttonResult:(id)sender {
    self.screen.text = [[NSNumber numberWithDouble:[Util expr:self.screen.text]] stringValue];
    self.showingResult = YES;
}

- (IBAction)buttonMemory:(id)sender {
    unichar op = [((UIButton*) sender).titleLabel.text characterAtIndex:1];
    switch (op) {
        case 'C':
            self.memoryValue = 0;
            self.mLabel.text = @"";
            break;
        case '+':
            self.memoryValue += [Util expr:self.screen.text];
            self.mLabel.text = @"M";
            [self buttonResult:sender];
            break;
        case '-':
            self.memoryValue -= [Util expr:self.screen.text];
            self.mLabel.text = @"M";
            [self buttonResult:sender];
            break;
        case 'R':
            self.screen.text = [[NSNumber numberWithDouble:self.memoryValue] stringValue];
            self.showingResult = YES;
            break;
        default:
            break;
    }
}
@end
