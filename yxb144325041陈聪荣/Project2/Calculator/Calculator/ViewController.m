//
//  ViewController.m
//  Calculator
//
//  Created by 陈聪荣 on 14/11/4.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//清空显示标示
BOOL cleanScreenflag = YES;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calculator = [[Calculator alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)singleStepOperation:(id)sender {
    //MC M+ M- MR 取反操作 取百分比操作
    NSMutableString *oldResult = [NSMutableString stringWithString:[self.resultText text]];
    NSString *oper = [sender currentTitle];
    double resultDouble = [self.calculator singleStepOperation:oldResult withOper:oper];
    [self.resultText setText:[NSString stringWithFormat:@"%.2lf",resultDouble]];
    cleanScreenflag = YES;
}

- (IBAction)multiStepOperation:(id)sender {
    //带括号的浮点型四则混合运算 , 按“=”得到结果
    NSString *lable = [sender currentTitle];
    NSMutableString *buffer = [NSMutableString stringWithString:[self.resultText text]];
    if([lable isEqualToString:@"AC"]){
        [buffer setString:@""];
    }else if([lable isEqualToString:@"DEL"]){
        [buffer setString:[buffer substringToIndex:[buffer length]-1]];
    }else{
        if (cleanScreenflag) {
            [buffer setString:lable];
        }else{
            [buffer appendString:lable];
        }
    }
    [self.resultText setText:buffer];
    cleanScreenflag = NO;
}

- (IBAction)calculation:(id)sender {
    NSMutableString *oldResult = [NSMutableString stringWithString:[self.resultText text]];
    double resultDouble = [self.calculator multiStepOperation:oldResult];
    [self.resultText setText:[NSString stringWithFormat:@"%.2lf",resultDouble]];
    cleanScreenflag = YES;
}
@end
