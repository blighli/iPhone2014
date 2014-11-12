//
//  ViewController.m
//  Calculator
//
//  Created by 黄耀彬 on 14-11-7.
//  Copyright (c) 2014年 黄耀彬. All rights reserved.
//

#import "ViewController.h"
#import "MyStack.h"

typedef enum {InputNum,InputExp,InputErr,InputReNum,UnInputNum,UnInputExp} InputMode;
InputMode inputMode;
MyStack *numStack;
MyStack *expStack;
NSString *memoryRegister;


@interface ViewController ()
@property (weak,nonatomic) IBOutlet UILabel *numLab;
@property (weak,nonatomic) IBOutlet UILabel *expLab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    numStack=[[MyStack alloc] init];
    expStack=[[MyStack alloc] init];
    memoryRegister=@"0";
    inputMode=InputNum;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)number:(id)sender
{
    UIButton *num = (UIButton *)sender;
    if(inputMode==InputErr||inputMode==UnInputNum)
        return;
    else if(inputMode==InputExp||inputMode==InputReNum)
        _numLab.text=@"0";
    _numLab.text=[_numLab.text stringByAppendingString:num.titleLabel.text];
    if([_numLab.text hasPrefix:@"0"])
        if(_numLab.text.length>1&&[_numLab.text hasPrefix:@"0."]!=1)
            _numLab.text=[_numLab.text substringFromIndex:1];
    inputMode=InputNum;
}

- (IBAction)operator:(id)sender
{
    UIButton *operator = (UIButton *)sender;
    if(inputMode==InputErr||inputMode==UnInputExp)
        return;
    else if(inputMode==InputNum||inputMode==InputReNum)
    {
        _expLab.text=[_expLab.text stringByAppendingString:_numLab.text];
        [self calculate:InputNum withInput:_numLab.text];
        [self calculate:InputExp withInput:operator.titleLabel.text];
        _expLab.text=[_expLab.text stringByAppendingString:operator.titleLabel.text];
    }
    else if(inputMode==UnInputNum)
    {
        [self calculate:InputExp withInput:operator.titleLabel.text];
        _expLab.text=[_expLab.text stringByAppendingString:operator.titleLabel.text];
    }
    inputMode=InputExp;
}

- (IBAction)bracket:(id)sender
{
    UIButton *bracket = (UIButton *)sender;
    if([bracket.titleLabel.text isEqualToString:@"("] && (inputMode==InputExp||inputMode==UnInputExp||[_expLab.text length]==0))
    {
        _expLab.text=[_expLab.text stringByAppendingString:@"("];
        [self calculate:InputExp withInput:bracket.titleLabel.text];
        inputMode=UnInputExp;
        _numLab.text=@"0";
    }
    if([bracket.titleLabel.text isEqualToString:@")"] && (inputMode==InputNum||inputMode==UnInputNum))
    {
        if(inputMode==InputNum)
        {
            _expLab.text=[_expLab.text stringByAppendingString:_numLab.text];
            [self calculate:InputNum withInput:_numLab.text];
        }
        _expLab.text=[_expLab.text stringByAppendingString:@")"];
        [self calculate:InputExp withInput:bracket.titleLabel.text];
        inputMode=UnInputNum;
    }
}

- (IBAction)clear:(id)sender
{
    [expStack clear];
    [numStack clear];
    inputMode=InputNum;
    _expLab.text=@"";
    _numLab.text=@"0";
}

- (IBAction)equal:(id)sender
{
    UIButton *equal = (UIButton *)sender;
    if(inputMode==InputErr)
        return;
    
    
    if(inputMode==InputExp||inputMode==InputNum||inputMode==InputReNum)
    {
        if(inputMode==InputExp)
        {
            NSString *stmp = [_expLab.text substringFromIndex:_expLab.text.length-1];
            NSInteger itmp = [self priority:stmp];
            if(itmp==11)
                _numLab.text=@"0";
            else if(itmp==12&&[stmp isEqualToString:@"%"])
                _numLab.text=[NSString stringWithFormat:@"%ld",NSIntegerMax];
            else if(itmp==12)
                _numLab.text=@"1";
        }
        [self calculate:InputNum withInput:_numLab.text];
    }
    [self matchBracket];
    [self calculate:InputExp withInput:equal.titleLabel.text];
    
    if(inputMode==InputErr)
        return;
    [expStack clear];
    [numStack clear];
    _expLab.text=@"";
    inputMode=InputReNum;
}

- (IBAction)memory:(id)sender
{
    UIButton *memory = (UIButton *)sender;
    NSString *title = memory.titleLabel.text;
    NSDecimalNumber *numMemory;
    NSDecimalNumber *numLab;
    
    if(inputMode==InputErr)
        return;
    if([title isEqualToString:@"MC"])
        memoryRegister=@"0";
    else if([title isEqualToString:@"MR"])
    {
        _numLab.text=memoryRegister;
        inputMode=InputReNum;
    }
    else
    {
        numMemory=(NSDecimalNumber*)[NSDecimalNumber numberWithDouble:[memoryRegister doubleValue]];
        numLab=(NSDecimalNumber*)[NSDecimalNumber numberWithDouble:[_numLab.text doubleValue]];
        if([title isEqualToString:@"M+"])
            numMemory=[numMemory decimalNumberByAdding:numLab];
        else if([title isEqualToString:@"M-"])
            numMemory=[numMemory decimalNumberBySubtracting:numLab];
        memoryRegister=[numMemory stringValue];
    }
}

- (void)calculate:(InputMode) inputCurMode withInput:(id) input
{
    if(inputCurMode==InputExp)
    {
        NSString* top = [expStack top];
        if(top==nil||[input isEqualToString:@"("]||[self priority:top]<[self priority:input])
        {
            if(![input isEqualToString:@")"])
                [expStack push:input];
        }
        else
        {
            NSDecimalNumber *num1;
            NSDecimalNumber *num2;
            while(![expStack isEmpty]&&[self priority:top]>=[self priority:input])
            {
                if([input isEqualToString:@")"]&&[top isEqualToString:@"("])
                {
                    [expStack pop];
                    break;
                }
                num1=(NSDecimalNumber*)[numStack topAndPop];
                num2=(NSDecimalNumber*)[numStack topAndPop];
                if([top isEqualToString:@"+"])
                    num2=[num2 decimalNumberByAdding:num1];
                else if([top isEqualToString:@"-"])
                    num2=[num2 decimalNumberBySubtracting:num1];
                else if([top isEqualToString:@"*"])
                    num2=[num2 decimalNumberByMultiplyingBy:num1];
                else if([top isEqualToString:@"/"])
                {
                    if([num1 doubleValue]!=0)
                        num2=[num2 decimalNumberByDividingBy:num1];
                    else
                    {
                        inputMode=InputErr;
                        _numLab.text=@"除数不能为零";
                        return;
                    }
                }
                else if([top isEqualToString:@"%"])
                {
                    if([num1 doubleValue]!=0)
                        num2=[num2 decimalNumberBySubtracting:[num1 decimalNumberByMultiplyingBy:(NSDecimalNumber *)[NSDecimalNumber numberWithInteger:[[num2 decimalNumberByDividingBy:num1] intValue]]]];
                    else
                    {
                        inputMode=InputErr;
                        _numLab.text=@"除数不能为零";
                        return;
                    }
                }
                [numStack push:num2];
                [expStack pop];
                _numLab.text=[num2 description];
                top=[expStack top];
            }
            if(![input isEqualToString:@")"])
                [expStack push:input];
        }
    }
    else if(inputCurMode==InputNum)
    {
        [numStack push:[NSDecimalNumber numberWithDouble:[_numLab.text doubleValue]]];
    }
}

- (NSInteger) priority:(NSString *) operator
{
    if([operator isEqualToString:@"+"]||[operator isEqualToString:@"-"])
        return 11;
    else if([operator isEqualToString:@"*"]||[operator isEqualToString:@"/"]||[operator isEqualToString:@"%"])
        return 12;
    else if([operator isEqualToString:@"("])
        return 9;
    else if([operator isEqualToString:@")"])
        return 8;
    else if([operator isEqualToString:@"="])
        return 0;
    return -1;
}

- (void) matchBracket
{
    NSString * expLab=_expLab.text;
    int leftCount=0;
    int rightCount=0;
    
    for(int i=0;i<[expLab length];++i)
    {
        NSString *each=[expLab substringWithRange:NSMakeRange(i,1)];
        if([each isEqualToString:@"("])
            ++leftCount;
        else if([each isEqualToString:@")"])
            ++rightCount;
    }
    
    for(int i=MIN(leftCount, rightCount);i!=MAX(leftCount, rightCount);++i)
    {
        if(leftCount>rightCount)
        {
            _expLab.text=[_expLab.text stringByAppendingString:@")"];
            [self calculate:InputExp withInput:@")"];
        }
        else
            _expLab.text=[@"(" stringByAppendingString:_expLab.text];
    }
}

@end
