	//
//  ViewController.m
//  Calculator
//
//  Created by Mz on 14-11-3.
//  Copyright (c) 2014年 mz. All rights reserved.
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
    self.label.text = @"";
    self.showingResult = NO;
}

- (IBAction)buttonInput:(id)sender {
    unichar input = [((UIButton*) sender).titleLabel.text characterAtIndex:0];
    unichar last = [self.label.text characterAtIndex:self.label.text.length-1];
    if (self.showingResult == YES && [Util isNumber:input]) [self buttonClear:sender];
    if (![Util isNumber:last] && ![Util isNumber:input]) return;
    self.label.text = [NSString stringWithFormat:@"%@%c", self.label.text, input];
    self.showingResult = NO;
}

- (IBAction)buttonResult:(id)sender {
    self.label.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:[Util calculate:self.label.text]]];
    self.showingResult = YES;
}
@end
