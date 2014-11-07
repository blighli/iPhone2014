//
//  ViewController.m
//  calculator
//
//  Created by 黄盼青 on 14/11/4.
//  Copyright (c) 2014年 docee. All rights reserved.
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

- (IBAction)btnCal:(UIButton *)sender {
    [self.displayScreen setText:[sender currentTitle]];
}
@end
