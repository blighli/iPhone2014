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
    self.calculator=[[Calculator alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//输入数字
- (IBAction)inputNumbers:(UIButton *)sender {
    
    if(self.currentInputNumber==nil)
    {
        if([[sender currentTitle]isEqualToString:@"."])
        {
            self.currentInputNumber=@"0.";
        }else
            self.currentInputNumber=[[NSString alloc]initWithString:[sender currentTitle]];
    }else
    {
        //只允许出现一个小数点
        if([sender.currentTitle isEqualToString:@"."] && [self.currentInputNumber containsString:@"."])
        {
            return;
        }
        self.currentInputNumber=[self.currentInputNumber stringByAppendingString:[sender currentTitle]];
    }
    
    self.displayScreen.text=self.currentInputNumber;
}

//AC清空
- (IBAction)ACClear:(id)sender {
    [self.calculator clearStack];
    self.currentInputNumber=nil;
    [self.displayScreen setText:@"0"];
}

//输入操作符
- (IBAction)inputOperators:(UIButton *)sender {
    if(self.currentInputNumber)
    {
        [self.calculator pushOutputValue:self.currentInputNumber];
    }
    self.currentInputNumber=nil;
    
    
    [self.calculator pushOperatorStack:[sender currentTitle]];
}

//输出结果
- (IBAction)inputResult:(id)sender {
    
    @try {
        if(self.currentInputNumber)
            [self.calculator pushOutputValue:self.currentInputNumber];
        self.currentInputNumber=nil;
        [self.calculator popAllOperatorStack];
        
        self.displayScreen.text=[[self.calculator calculateOutputResult] description];
        
    }
    @catch (NSException *exception) {
        if([exception.name isEqualToString:@"NSInvalidArgumentException"])
        {
            self.displayScreen.text=@"运算错误";
        }
        else
        {
            self.displayScreen.text=@"错误";
        }
    }
    @finally {
        [self.calculator clearStack];
    }
}

//回删
- (IBAction)backDelete:(id)sender {
    if(![self.displayScreen.text isEqualToString:@"0"])
    {
        self.displayScreen.text=[self.displayScreen.text substringToIndex:self.displayScreen.text.length-1];
        self.currentInputNumber=self.displayScreen.text;
    }
}

//清空寄存器
- (IBAction)memoryClear:(id)sender {
    self.memoryValue=nil;
    self.memoryLabel.hidden=YES;
}

//寄存器加运算
- (IBAction)memoryAdding:(id)sender {
    if(self.memoryValue)
    {
        self.memoryValue=[[self.calculator basicCalculate:@"+" withNumber1:self.memoryValue withNumber2:self.displayScreen.text]description];
    }else
    {
        self.memoryValue=self.displayScreen.text;
    }
    
    self.memoryLabel.hidden=NO;
}

//寄存器减运算
- (IBAction)memorySubtraction:(id)sender {
    if(self.memoryValue)
    {
        self.memoryValue=[[self.calculator basicCalculate:@"-" withNumber1:self.displayScreen.text withNumber2:self.memoryValue]description];
    }else
    {
        self.memoryValue=[[self.calculator basicCalculate:@"-" withNumber1:self.displayScreen.text withNumber2:@"0"]description];
    }
    
    self.memoryLabel.hidden=NO;
}

//显示寄存器值
- (IBAction)memoryRead:(id)sender {
    if(self.memoryValue)
    {
        self.displayScreen.text=self.memoryValue;
        self.currentInputNumber=self.displayScreen.text;
    }
}

//计算百分数
- (IBAction)percentOperators:(id)sender {
    if(![self.displayScreen.text isEqualToString:@"0"])
    {
        NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:@"100"];
        NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:self.displayScreen.text];
        NSDecimalNumber *_num=[_num2 decimalNumberByDividingBy:_num1];
        self.displayScreen.text=[_num description];
        self.currentInputNumber=self.displayScreen.text;
    }
}
@end
