//
//  ViewController.m
//  calculaor
//
//  Created by icy on 14-11-9.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import "ViewController.h"
#import "CaculatorBrain.h"
@interface ViewController ()

@property BOOL isUseInEnteringANumber;
@property (nonatomic)CaculatorBrain *brain;
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

- (CaculatorBrain *)brain
{
    if (!_brain) {
        _brain = [CaculatorBrain new];
    }
    return _brain;
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
    [self.brain pushOperation:sender.currentTitle];
    
    [self numberInBrain];
    _isContinue = YES;
}

- (IBAction)zeroPressed {
    self.display.text = @"0";
    [self.brain zero];
    _isContinue = NO;
    _isUseInEnteringANumber = NO;
    
    [self.brain pushNumberInStack:0.0 andBool:NO];
    self.secondEqual = NO;
    self.firstEqual = NO;
    
    
}

- (void)numberInBrain
{
    _isUseInEnteringANumber = NO;
    
    
    [self.brain pushNumberInStack:[self.display.text doubleValue] andBool:self.secondEqual];
}
- (IBAction)equalR {
    if (self.firstEqual) {
        
        
        _isContinue = NO;
        [self numberInBrain];
        double resultNumber = [self.brain result:_secondEqual];
        NSMutableString *resultStr = [NSMutableString stringWithFormat:@"%lg",resultNumber];
        //    NSMutableString *resultStr = [NSMutableString stringWithFormat:@"%lf",resultNumber];
        //
        //    while ([resultStr hasSuffix:@"0"]) {
        //        [resultStr deleteCharactersInRange:NSMakeRange([resultStr length]-1, 1)];
        //    }
        //    while ([resultStr hasSuffix:@"."]) {
        //        [resultStr deleteCharactersInRange:NSMakeRange([resultStr length]-1, 1)];
        //    }
        
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
