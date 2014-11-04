	//
//  ViewController.m
//  Calculator
//
//  Created by Mz on 14-11-3.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "ViewController.h"

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
    self.label.text = @"Clear Pressed";
}

- (IBAction)buttonInput:(id)sender {
    self.label.text = @"Input Pressed";
}

- (IBAction)buttonResult:(id)sender {
    self.label.text = @"Result Pressed";
}
@end
