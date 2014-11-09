//
//  ViewController.m
//  Calculator
//
//  Created by turbobhh on 11/4/14.
//  Copyright (c) 2014 org.bhh.homework. All rights reserved.
//

#import "ViewController.h"
#import "MyStack.h"
#import "Calculator.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *expressionLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong,nonatomic) NSMutableString* exp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.resultLabel.text=nil;
    self.expressionLabel.text=nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(NSMutableString *)exp{
    if (!_exp) {
        _exp=[[NSMutableString alloc] init];
    }
    return _exp;
}

//按下数字或者运算符
- (IBAction)input:(UIButton *)sender {
    [self.exp appendString:sender.titleLabel.text];
    self.expressionLabel.text=self.exp;
    
}

//计算并显示结果
- (IBAction)calculateExp:(UIButton *)sender {
    
    NSString* result= [Calculator calculate:self.exp];
    self.resultLabel.text=result;
   
}

//清空数据
- (IBAction)wipeOut:(UIButton *)sender {
    self.resultLabel.text=nil;
    self.expressionLabel.text=nil;
    self.exp=nil;
}

//删除表达式最后一位
- (IBAction)deleteBack:(UIButton *)sender {
    
    
    NSString* newExp=[self.exp substringToIndex:self.exp.length-1];
    self.exp=[[NSMutableString alloc] initWithString:newExp];
    self.expressionLabel.text=self.exp;
    
}

- (IBAction)mr:(UIButton *)sender {
    
    self.resultLabel.text=[Calculator mr];
    //显示MR的同时，把表达式字符串也改成MR
    self.exp=[[NSMutableString alloc] initWithString:self.resultLabel.text];

}

- (IBAction)mc:(UIButton *)sender {
    [Calculator mc];
}

- (IBAction)mPlus:(UIButton *)sender {
    [Calculator mPlus:self.resultLabel.text];
}

- (IBAction)mSubtract:(UIButton *)sender {
    [Calculator mSubtract:self.resultLabel.text];
}

@end
