//
//  ViewController.m
//  Project2
//
//  Created by Cocoa on 14/11/4.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.cal = [[Cal alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//输入表达式
- (IBAction)inputExpr:(UIButton *)sender{
    if (self.currentExpr==nil) {
        self.currentExpr=[[NSString alloc]initWithString:sender.currentTitle];
    }
    else{
    
        self.currentExpr=[self.currentExpr stringByAppendingString:sender.currentTitle];
    }
    self.resultLabel.text = self.currentExpr;
}

//AC清空
- (IBAction)ALLClear:(UIButton *)sender{
    self.currentExpr=nil;
    self.resultLabel.text =@"0";
}

//计算结果
- (IBAction)calResult:(UIButton *)sender{
    @try {
        if(self.currentExpr){
           self.resultLabel.text = [self.cal compute:[self.cal inFix2PostFix:self.currentExpr]].stringValue;
        }
    }
    @catch (NSException *exception) {
        if([exception.name isEqualToString:@"NSInvalidArgumentException"])
        {
            self.resultLabel.text=@"运算错误";
        }
        else
        {
            self.resultLabel.text=@"错误";
        }
    }
    @finally {
    
    }
}

//回删
- (IBAction)backDelete:(UIButton *)sender{
    if(![self.resultLabel.text isEqualToString:@"0"])
    {
        self.resultLabel.text=[self.resultLabel.text substringToIndex:self.resultLabel.text.length-1];
        self.currentExpr=self.resultLabel.text;
    }
}

//清空寄存器
- (IBAction)memoryClear:(UIButton *)sender{
    self.memoryValue=nil;
}

//寄存器加运算
- (IBAction)memoryAdding:(UIButton *)sender{
    if(self.memoryValue)
    {
        NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:self.memoryValue];
        NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:self.resultLabel.text];
        self.memoryValue= [_num2 decimalNumberByMultiplyingBy:_num1].stringValue;
    }else
    {
        self.memoryValue=self.resultLabel.text;
    }
}

//寄存器减运算
- (IBAction)memorySubtraction:(UIButton *)sender{
    if(self.memoryValue)
    {
        NSDecimalNumber *_num1=[NSDecimalNumber decimalNumberWithString:self.memoryValue];
        NSDecimalNumber *_num2=[NSDecimalNumber decimalNumberWithString:self.resultLabel.text];
        self.memoryValue= [_num2 decimalNumberByDividingBy:_num1].stringValue;
    }else
    {
        self.memoryValue=self.resultLabel.text;
    }
}

//显示寄存器值
- (IBAction)memoryShow:(UIButton *)sender{
    self.resultLabel.text=self.memoryValue;
    self.currentExpr=self.resultLabel.text;
}

@end
