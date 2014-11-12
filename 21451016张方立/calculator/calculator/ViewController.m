//
//  ViewController.m
//  calculator
//
//  Created by icy on 14-11-12.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"
@interface ViewController ()

@property BOOL isUseInEnteringANumber;
@property (nonatomic) Calculator *caculator;
@property BOOL isContinue;
@property BOOL secondEqual;
@property BOOL firstEqual;

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

- (Calculator *)caculator
{
    if (!_caculator) {
        _caculator = [Calculator new];
    }
    return _caculator;
}
- (IBAction)digitPressed:(UIButton *)sender
{
    
    _secondEqual = NO;
    NSString *digit = sender.currentTitle;
    if (_isUseInEnteringANumber) self.display.text = [self.display.text stringByAppendingString:digit];
    else {
        self.display.text = digit;
        _isUseInEnteringANumber = YES;
    }
}
- (IBAction)operationPressed:(UIButton *)sender {
    
    self.firstEqual = YES;
    _secondEqual = NO;
    if(_isContinue) [self equalR];
    [self.caculator pushOperation:sender.currentTitle];
    
    [self numberInMemory];
    _isContinue = YES;
}

- (IBAction)zeroPressed {
    self.display.text = @"0";
    [self.caculator zero];
    _isContinue = NO;
    _isUseInEnteringANumber = NO;
    
    [self.caculator pushNumberInStack:0.0 andBool:NO];
    self.secondEqual = NO;
    self.firstEqual = NO;
    
    
}

- (void)numberInMemory
{
    _isUseInEnteringANumber = NO;
    
    
    [self.caculator pushNumberInStack:[self.display.text doubleValue] andBool:self.secondEqual];
}
- (IBAction)equalR {
    if (self.firstEqual) {
        
        
        _isContinue = NO;
        [self numberInMemory];
        double resultNumber = [self.caculator result:_secondEqual];
        NSMutableString *resultStr = [NSMutableString stringWithFormat:@"%lg",resultNumber];
        
        if(resultNumber>1000000000){
            
            int count = 0;
            while (resultNumber >=10) {
                resultNumber/= 10;
                count++;
            }
            [resultStr deleteCharactersInRange:NSMakeRange(0, [resultStr length])];
            [resultStr appendFormat:@"%lg",resultNumber];
            [resultStr appendFormat:@" E%d",count];
            
        }
        self.display.text = resultStr;
        [resultStr deleteCharactersInRange:NSMakeRange(0, [resultStr length])];
        _secondEqual = YES;
    }else {
        NSLog(@"right!");
        double resultNumber = [self.display.text doubleValue];
        NSMutableString *resultStr = [NSMutableString stringWithFormat:@"%lg",resultNumber];
        if(resultNumber>1000000000){
            
            double count = 0.0;
            while (resultNumber >=10) {
                resultNumber /= 10.0;
                count += 1.0;
            }
            [resultStr deleteCharactersInRange:NSMakeRange(0, [resultStr length])];
            [resultStr appendFormat:@"%lg",resultNumber];
            [resultStr appendFormat:@"e%g",count];
            
        }
        self.display.text = resultStr;
        [resultStr deleteCharactersInRange:NSMakeRange(0, [resultStr length])];
        
        
    }
    self.firstEqual = YES;
    
    
}



@end
