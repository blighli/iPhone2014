//
//  ViewController.m
//  Calculator
//
//  Created by yjq on 14/11/3.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


bool isNum=YES;//左边的数是否为数字
bool left=NO;//运算符号所在位置是否在左边
bool isOperator=NO;//当前位置是否为运算符
bool is_result=NO;//运算符是否已经运算完
bool nozero_before_spot=YES;//在点击.时是否点击过0
bool isspot=NO;//判断是否点击过.
double leftresult=0;
double rightresult=0;
double y=0;
int numCount=0;//数字按钮的点击次数
int operatorCount=0;//运算符号的点击次数
double Memory=0;
NSString *collect=@"";
- (void)viewDidLoad {
    [super viewDidLoad];
    //Label的初始化设置
    _num2=_textLabel.text=@"0";
    _textLabel.adjustsFontSizeToFitWidth=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)number:(id)sender
{
    if (!isOperator) {
        numCount++;
        self.title=[sender titleForState:UIControlStateNormal];
        [self CinNum:self.title];
        leftresult=[_num2 doubleValue];
        _textLabel.text=_num2;
        isNum=YES;
        left=NO;
        isspot=YES;
        nozero_before_spot=NO;
        //is_result=YES;
    }
    else{
        numCount++;
        self.title=[sender titleForState:UIControlStateNormal];
        [self CinNum:self.title];
        rightresult=[_num2 doubleValue];
        _textLabel.text=_num2;
        isNum=YES;
        isspot=YES;
        left=YES;
        //is_result
    }
    
}
-(void)Operators:(id)sender
{
    if (isNum==YES&&left==YES) {
        [self calculate:collect];
    }
    collect=[sender currentTitle];
    isOperator=YES;
    isNum=NO;
    is_result=NO;
    numCount=0;
    nozero_before_spot=YES;
    isspot=NO;
    
}

-(void)Result:(id)sender
{
    [self calculate:collect];
    numCount=0;
    operatorCount=0;
    isOperator=NO;
    isNum=NO;
    is_result=YES;
    nozero_before_spot=YES;
    isspot=NO;
}
    
-(void)allClear:(id)sender
{
    _textLabel.text=@"0";
    _num1=_num2=[[NSMutableString alloc]initWithString:@""];
    collect=@"";
    operatorCount=0;
    numCount=0;
    isNum=YES;
    left=NO;
    isOperator=NO;
    is_result=NO;
    rightresult=0;
    leftresult=0;
    isspot=NO;
    nozero_before_spot=YES;
}

-(void)ChangeSign:(id)sender
{
    if (is_result==YES) {
        leftresult=0-leftresult;
        _textLabel.text=[NSString stringWithFormat:@"%g",leftresult];
    }
    else{
        leftresult=0-leftresult;
        _textLabel.text=[NSString stringWithFormat:@"%g",leftresult];
    }
}

-(void)Back:(id)sender
{
    NSMutableString *tempString;
    tempString=_textLabel.text;
    if (![_textLabel.text isEqualToString:@"0"]) {
        if ([tempString length]==1) {//回到最初状态，即还没点击按钮的状态
            _textLabel.text=@"0";
            numCount=0;
        }
        else{
            [tempString deleteCharactersInRange:NSMakeRange([tempString length]-1, 1)];//删除最后一个字符
            _textLabel.text=[NSMutableString stringWithFormat:tempString];
        }
        _num2=_textLabel.text;
    }
}

-(void)MemoryButton:(id)sender
{
    double temp=0;
    self.title=[sender titleForState:UIControlStateNormal];
    collect=self.title;
    if ([collect isEqualToString:@"MC"]) {
        Memory=0;
        _textLabel.text=@"0";
        [_MemoryRead setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self AllClear];
        
    }
    else if ([collect isEqualToString:@"M+"]) {
        Memory=Memory+[_textLabel.text doubleValue];
        [_MemoryRead setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self AllClear];
        
    }
    else if ([collect isEqualToString:@"M-"]) {
        Memory=Memory-[_textLabel.text doubleValue];
        [self AllClear];
    }
    else if ([collect isEqualToString:@"MR"]) {
        _textLabel.text=[NSString stringWithFormat:@"%g",Memory];
        [self AllClear];
    }
}

-(void)calculate:(NSString*) operator
{
    if ([operator isEqualToString:@"+"]==1) {
        leftresult=leftresult+rightresult;
        _textLabel.text=[NSString stringWithFormat:@"%g",leftresult];
    }
    if ([operator isEqualToString:@"-"]==1) {
        leftresult=leftresult-rightresult;
        _textLabel.text=[NSString stringWithFormat:@"%g",leftresult];
    }
    if ([operator isEqualToString:@"*"]==1) {
        leftresult=leftresult*rightresult;
        _textLabel.text=[NSString stringWithFormat:@"%g",leftresult];
    }
    if ([operator isEqualToString:@"/"]==1) {
        leftresult=leftresult/rightresult;
        _textLabel.text=[NSString stringWithFormat:@"%g",leftresult];
    }
    
}

-(void)CinNum:(NSString *) title
{
    _num1=[[NSMutableString alloc]initWithString:title];
    if (numCount==1) {
        _num2=_num1;
    }
    else{
        _num2=[[NSMutableString alloc]initWithString:[_num2 stringByAppendingString:_num1]];
    }
}

-(void)spotButton:(id)sender
{
    if (isspot) {
        if (isOperator==NO) {
            numCount++;
            self.title=[sender titleForState:UIControlStateNormal];
            [self CinNum:self.title];
            leftresult=[_num2 doubleValue];
        }
        else{
            numCount++;
            self.title=[sender titleForState:UIControlStateNormal];
            [self CinNum:self.title];
            rightresult=[_num2 doubleValue];
        }
        _textLabel.text=_num2;
        left=YES;
    }
    if (nozero_before_spot==YES) {
        numCount++;
        leftresult=0;
        self.title=@"0.";
        [self CinNum:self.title];
        if (isOperator==NO) {
            leftresult=[_num2 doubleValue];
        }
        else{
            rightresult=[_num2 doubleValue];
        }
        _textLabel.text=_num2;
    }
    isspot=NO;
    nozero_before_spot=NO;

}

-(void)Persentage:(id)sender
{
    leftresult=leftresult/100;
    _textLabel.text=[NSString stringWithFormat:@"%g",leftresult];
}

-(void) AllClear
{
    //_textLabel.text=@"0";
    _num1=_num2=[[NSMutableString alloc]initWithString:@""];
    collect=@"";
    leftresult=0;
    operatorCount=0;
    numCount=0;
    isNum=NO;
    isOperator=NO;

}
@end
