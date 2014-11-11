//
//  ViewController.m
//  Calculator
//
//  Created by Mac on 14-11-7.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "Express.h"

BOOL empty=YES;
BOOL pressedEqualButton = NO;


@interface ViewController ()

@end

@implementation ViewController

@synthesize resultText;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _memory = @"0";
    errorCode = NOERROR;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)numberButtonPressed:(UIButton *)sender {
    if(errorCode != NOERROR || pressedEqualButton==YES){
        resultText.text=@"0";
        empty = YES;
        errorCode = NOERROR;
        pressedEqualButton=NO;
    }
    NSString *value = [sender titleForState:UIControlStateNormal];
    
    
    NSString *curConten = [resultText text];
    if(empty==YES){
        resultText.text=value;
    }else{
        resultText.text = [[NSString alloc] initWithFormat:@"%@%@",curConten,value ];
        
    }
    empty = NO;
}

- (IBAction)OperatorButtonPressed:(UIButton *)sender {//操作符按钮
    pressedEqualButton=NO;
    if(errorCode != NOERROR ){
        resultText.text=@"0";
        empty = YES;
        errorCode = NOERROR;
        
    }
    NSString *value = [sender titleForState:UIControlStateNormal];
    NSString *curConten = [resultText text];
    if(empty==YES){
        resultText.text=value;
    }else{
        resultText.text = [[NSString alloc] initWithFormat:@"%@%@",curConten,value ];
        
    }
    empty = NO;
    
}
- (IBAction)MRButtonPressed:(UIButton *)sender {
    resultText.text=_memory;
}

- (IBAction)MPlusButtonPressed:(UIButton *)sender {
    Express* exp = [[Express alloc] init:_memory];
    NSString *curContent = [resultText text];
    [exp calExp:curContent operator:'+'];
    resultText.text = [exp getValue];
    _memory = resultText.text;
}

- (IBAction)MSubButtonPressed:(UIButton *)sender {
    Express* exp = [[Express alloc] init:_memory];
    NSString *curContent = [resultText text];
    [exp calExp:curContent operator:'-'];
    resultText.text = [exp getValue];
    _memory = resultText.text;
}

- (IBAction)MemClearButtonPressed:(UIButton *)sender {
    _memory  = @"0" ;
}

- (IBAction)clearButtonPressed:(UIButton *)sender {
    resultText.text = @"0";
    empty = YES;
}

- (IBAction)EqualButtonPressed:(id)sender {
  
    pressedEqualButton= YES;
    
    NSString *curContent=[resultText text];
    NSLog(@"%@",curContent);
    Express* exp = [[Express alloc] init:curContent];
    errorCode =[exp errorCode];
    if(errorCode==NOERROR){
        resultText.text=[exp getValue];
        empty = NO;
    }else{
        if(errorCode==DIVIDEZEROR){
            resultText.text = @"除数为0";
        }else if(errorCode==MISMATCHBRACKET){
            resultText.text = @"括号不匹配";
        }else if(errorCode== OPERATORERROR){
            resultText.text = @"操作符不正确";
        }
    }
}

@end



