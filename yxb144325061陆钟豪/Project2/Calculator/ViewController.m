//
//  ViewController.m
//  Project2
//
//  Created by 陆钟豪 on 14/11/4.
//  Copyright (c) 2014年 陆钟豪. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()
@end

@implementation ViewController
{
    Calculator* _calculator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _calculator = [Calculator new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonClick:(id)sender {
    // before
    if([_calculator isError]) {
        [_calculator reset];
    }
    for(UIButton *btn in _operators) {
        [[btn layer] setBorderWidth:0.0f];
    }
    
    // execute
    NSString* buttonTitle = [sender currentTitle];
    if([@"0123456789" containsString:buttonTitle]) {
        NSInteger num = [[sender currentTitle] integerValue];
        [_display setText:[_calculator pressNum:num]];
    }
    else if([buttonTitle isEqualToString:@"."]) {
        [_display setText:[_calculator pressPoint]];
    }
    else if([@"+-×÷" containsString:buttonTitle]) {
        NSString* op = [sender currentTitle];
        [_display setText:[_calculator pressOperator:op]];
        [[sender layer] setBorderWidth:1.0f];
    }
    else if([buttonTitle isEqualToString:@"="]) {
        [_display setText:[_calculator pressEqual]];
    }
    else if([buttonTitle isEqualToString:@"C"]) {
        [_display setText:[_calculator reset]];
    }
    else if([buttonTitle isEqualToString:@"("]) {
        [_display setText:[_calculator pressLeftBracket]];
    }
    else if([buttonTitle isEqualToString:@")"]) {
        [_display setText:[_calculator pressRightBracket]];
    }
    else if([buttonTitle isEqualToString:@"%"]) {
        [_display setText:[_calculator pressPercent]];
    }
    else if([buttonTitle isEqualToString:@"±"]) {
        [_display setText:[_calculator pressSign]];
    }
    else if([buttonTitle isEqualToString:@"←"]) {
        [_display setText:[_calculator pressBackspace]];
    }
    else if([buttonTitle isEqualToString:@"MC"]) {
        [_calculator pressMClear];
        [[_mr layer] setBorderWidth:0.0f];
    }
    else if([buttonTitle isEqualToString:@"MR"]) {
        [_display setText:[_calculator pressMRead]];
    }
    else if([buttonTitle isEqualToString:@"M+"]) {
        [_calculator pressMPlus];
        [[_mr layer] setBorderWidth:1.0f];
    }
    else if([buttonTitle isEqualToString:@"M-"]) {
        [_calculator pressMSub];
        [[_mr layer] setBorderWidth:1.0f];
    }
    
    // after
    if([_calculator isError]) {
        [_display setText:@"错误"];
    }
}

- (BOOL) shouldAutorotate {
    return NO;
}

@end
