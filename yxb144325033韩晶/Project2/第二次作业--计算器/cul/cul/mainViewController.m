//
//  mainViewController.m
//  cul
//
//  Created by hanxue on 14-11-6.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#import "mainViewController.h"
#import "calulatorfounction.h"

@interface mainViewController ()
- (IBAction)number0;
- (IBAction)number1;
- (IBAction)number2;
- (IBAction)number3;
- (IBAction)buttonadd;
- (IBAction)buttonsub;
- (IBAction)buttonmul;
- (IBAction)buttondiv;
- (IBAction)number4;
- (IBAction)number5;
- (IBAction)number7;
- (IBAction)number8;
- (IBAction)buttonpoint;
- (IBAction)buttonresult;
//- (IBAction)buttonres;
//- (IBAction)buttonbracket;
- (IBAction)buttonbracket1;
- (IBAction)buttondel;
- (IBAction)buttonMsub;
- (IBAction)buttonMc;
- (IBAction)buttonMr;
- (IBAction)buttonAc;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property NSString *result;
//calulator *calu=[[calulator alloc]init];
@property calulator *calu;
//@property NSString *calu;
//calulator *calu=[[calulator alloc]init];
- (IBAction)number6;
- (IBAction)number9;
- (IBAction)buttonres;
- (IBAction)buttonbracket;
- (IBAction)buttonMadd;

@end

@implementation mainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _result=[[NSString alloc] init];
    _result=@"";
    _calu=[[calulator alloc]init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)number0 {
    _result=[_result stringByAppendingString:@"0"];
    [_label setText:_result];
}

- (IBAction)number1 {
    _result=[_result stringByAppendingString:@"1"];
    [_label setText:_result];
}

- (IBAction)number2 {
    _result=[_result stringByAppendingString:@"2"];
    [_label setText:_result];
}

- (IBAction)number3 {
    _result=[_result stringByAppendingString:@"3"];
    [_label setText:_result];
}

- (IBAction)buttonadd {
    _result=[_result stringByAppendingString:@"+"];
    [_label setText:_result];
}

- (IBAction)buttonsub {
    _result=[_result stringByAppendingString:@"-"];
    [_label setText:_result];
}

- (IBAction)buttonmul {
    _result=[_result stringByAppendingString:@"*"];
    [_label setText:_result];
}

- (IBAction)buttondiv {
    _result=[_result stringByAppendingString:@"/"];
    [_label setText:_result];
}

- (IBAction)number4 {
    _result=[_result stringByAppendingString:@"4"];
    [_label setText:_result];
}

- (IBAction)number5 {
    _result=[_result stringByAppendingString:@"5"];
    [_label setText:_result];
}
//- (IBAction)number6 {
//  _result=[_result stringByAppendingString:@"6"];
//  [_label setText:_result];
//}
- (IBAction)number7 {
    _result=[_result stringByAppendingString:@"7"];
    [_label setText:_result];
}

- (IBAction)number8 {
    _result=[_result stringByAppendingString:@"8"];
    [_label setText:_result];
}

//- (IBAction)number9 {
//    _result=[_result stringByAppendingString:@"0"];
//    [_label setText:_result];
//}

- (IBAction)buttonpoint {
    _result=[_result stringByAppendingString:@"."];
    [_label setText:_result];
}

- (IBAction)buttonresult {
    calulator *calu=[[calulator alloc]init];//局部变量
    _result=[calu unperantheses:_result];//calulator这个类的对象calu中的方法unperantheses需要传入参数result
    [_label setText:_result];
    
}


//- (IBAction)buttonres {
  //  _result=[_result stringByAppendingString:@"%"];
   // [_label setText:_result];
//}

//- (IBAction)buttonbracket {
//    _result=[_result stringByAppendingString:@"("];
//    [_label setText:_result];
//}

- (IBAction)buttonbracket1 {
    _result=[_result stringByAppendingString:@")"];
    [_label setText:_result];
}

- (IBAction)buttondel {
    if(_result.length>0){
    _result=[_result substringToIndex:_result.length-1];
    [_label setText:_result];
    }
    else
        _result=@"";
}
- (IBAction)buttonMsub {
    //calulator *calu=[[calulator alloc]init];
    _result=[_calu unperantheses:_result];
    [_calu memorysubtraction:[_result floatValue]];
    //_result=[NSString stringWithFormat:@"%f",[_calu memorysubtraction:[_result floatValue]]];
    [_label setText:_result];
}

- (IBAction)buttonMc {
    //calulator *calu=[[calulator alloc]init];
    [_calu memoryclear];
    
}

- (IBAction)buttonMr {
    //calulator *calu=[[calulator alloc]init];
    [_label setText:[NSString stringWithFormat:@"%f",_calu.memory]];
}

- (IBAction)buttonAc {
    _result=@"";
    [_label setText:_result];
}


- (IBAction)number6 {
    _result=[_result stringByAppendingString:@"6"];
    [_label setText:_result];
}

- (IBAction)number9 {
        _result=[_result stringByAppendingString:@"9"];
        [_label setText:_result];
}

- (IBAction)buttonres {
    _result=[_result stringByAppendingString:@"%"];
    [_label setText:_result];
}

- (IBAction)buttonbracket {
    _result=[_result stringByAppendingString:@"("];
    [_label setText:_result];
}
- (IBAction)buttonMadd {
    _result=[_calu unperantheses:_result];
       [_calu memoryaddition:[_result floatValue]];
        //_result=[NSString stringWithFormat:@"%f",[_calu memoryaddition:[_result floatValue]]];
       [_label setText:_result];
}
@end
