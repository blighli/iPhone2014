//
//  MachineViewController.m
//  Machine
//
//  Created by Chen.D.guanhong on 14/11/8.
//  Copyright (c) 2014年 Chen.D.guanhong. All rights reserved.
//

#import "MachineViewController.h"
#import "Calculator.h"

@interface MachineViewController ()
@property (nonatomic) BOOL middleInput;
@property (strong,nonatomic) Calculator *cal;
@property (nonatomic) double memory;
@end

@implementation MachineViewController
@synthesize display = _display;
@synthesize middleInput = _middleInput;
@synthesize memory = _memory;

-(Calculator *)cal
{
    if (!_cal)
        _cal = [[Calculator alloc]init];
    return _cal;
}

- (IBAction)pressInputButton:(UIButton *)sender {
    if (self.middleInput) {
        self.display.text =
        [self.display.text stringByAppendingString:
         sender.currentTitle];
    }else{
        self.display.text = sender.currentTitle;
        self.middleInput = true;
    }
}

- (IBAction)pressEnterButton {
    NSString * str = self.display.text;
    double result = [self.cal evaluate:
                     [self.cal stringParser:str]];
    self.display.text =
    [NSString stringWithFormat:@"%g",result];
}

- (IBAction)pressACBUtton {
    self.display.text = @"0";
    self.middleInput =false;
}

- (IBAction)pressMCButton {
    self.display.text = @"0";
    self.memory = 0;
    self.middleInput =false;
}

- (IBAction)pressMPlus {
    NSString * str = self.display.text;
    double result = [self.cal evaluate:
                     [self.cal stringParser:str]];
    self.memory += result;
    self.display.text =
    [NSString stringWithFormat:@"%g",self.memory];
    
}

- (IBAction)pressMMinus {
    NSString * str = self.display.text;
    double result = [self.cal evaluate:
                     [self.cal stringParser:str]];
    self.memory -= result;
    self.display.text =
    [NSString stringWithFormat:@"%g",self.memory];
}

- (IBAction)pressMRead {
    self.display.text =
    [NSString stringWithFormat:@"%g",self.memory];
}



@end
