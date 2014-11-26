//
//  ViewController.m
//  calulatorios
//
//  Created by C.C.R on 14/11/4.
//  Copyright (c) 2014年 TOM. All rights reserved.
//

#import "ViewController.h"
#import "calulatorfounction.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *Outline;
- (IBAction)numberBtn1;
- (IBAction)numberBtn2;
- (IBAction)numberBtn3;
- (IBAction)numberBtn4;
- (IBAction)numberBtn5;
- (IBAction)numberBtn6;
- (IBAction)numberBtn7;
- (IBAction)numberBtn8;
- (IBAction)numberBtn9;
- (IBAction)numberBtn0;


- (IBAction)mplusBtn;
- (IBAction)mdivBtn;
- (IBAction)mclearBtn;
- (IBAction)mreadBtn;

- (IBAction)leftParentBtn;
- (IBAction)rightParentBtn;


- (IBAction)acBtn;
- (IBAction)delBtn;

- (IBAction)additionBtn;
- (IBAction)subBtn;
- (IBAction)multiBtn;
- (IBAction)divBtn;
- (IBAction)pointBtn;
- (IBAction)remBtn;


- (IBAction)outputBtn;

@property NSString* outlist;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _outlist=[[NSString alloc] init];
    memory=[[calulator alloc] init];
    [_Outline setText:@"0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)numberBtn1 {
    _outlist=[_outlist stringByAppendingString:@"1"];
    [_Outline setText:_outlist];
}

- (IBAction)numberBtn2 {
    _outlist=[_outlist stringByAppendingString:@"2"];
    [_Outline setText:_outlist];
}

- (IBAction)numberBtn3 {
    _outlist=[_outlist stringByAppendingString:@"3"];
    [_Outline setText:_outlist];
}

- (IBAction)numberBtn4 {
    _outlist=[_outlist stringByAppendingString:@"4"];
    [_Outline setText:_outlist];
}

- (IBAction)numberBtn5 {
    _outlist=[_outlist stringByAppendingString:@"5"];
    [_Outline setText:_outlist];
}

- (IBAction)numberBtn6 {
    _outlist=[_outlist stringByAppendingString:@"6"];
    [_Outline setText:_outlist];
}

- (IBAction)numberBtn7 {
    _outlist=[_outlist stringByAppendingString:@"7"];
    [_Outline setText:_outlist];
}

- (IBAction)numberBtn8 {
    _outlist=[_outlist stringByAppendingString:@"8"];
    [_Outline setText:_outlist];
}

- (IBAction)numberBtn9 {
    _outlist=[_outlist stringByAppendingString:@"9"];
    [_Outline setText:_outlist];
}

- (IBAction)numberBtn0 {
    _outlist=[_outlist stringByAppendingString:@"0"];
    [_Outline setText:_outlist];
}

- (IBAction)outputBtn {
    calulator *Cal=[[calulator alloc] init];
    NSString* result=[Cal unperantheses:_outlist];
    [_Outline setText:result];
    _outlist=@"";
}

- (IBAction)additionBtn {
    _outlist=[_outlist stringByAppendingString:@"+"];
    [_Outline setText:_outlist];
}

- (IBAction)subBtn {
    _outlist=[_outlist stringByAppendingString:@"-"];
    [_Outline setText:_outlist];
}

- (IBAction)leftParentBtn {
    _outlist=[_outlist stringByAppendingString:@"("];
    [_Outline setText:_outlist];
}

- (IBAction)rightParentBtn {
    _outlist=[_outlist stringByAppendingString:@")"];
    [_Outline setText:_outlist];
}

- (IBAction)multiBtn {
    _outlist=[_outlist stringByAppendingString:@"*"];
    [_Outline setText:_outlist];
}

- (IBAction)divBtn {
    _outlist=[_outlist stringByAppendingString:@"/"];
    [_Outline setText:_outlist];
}

- (IBAction)pointBtn {
    _outlist=[_outlist stringByAppendingString:@"."];
    [_Outline setText:_outlist];
}

- (IBAction)remBtn {
    _outlist=[_outlist stringByAppendingString:@"%"];
    [_Outline setText:_outlist];
}

- (IBAction)acBtn {
    _outlist=@"";
    [_Outline setText:@"0"];
}

- (IBAction)delBtn {
    if (![_outlist isEqual:@""]) {
        _outlist=[_outlist substringToIndex:[_outlist length]-1];
        [_Outline setText:_outlist];
    }else{
        _outlist=@"";
        [_Outline setText:@"0"];
    }
    
}

- (IBAction)mplusBtn {
    _outlist=[memory unperantheses:_outlist];
    if (![_outlist  isEqual: @"Wrong Enter!"]) {
        
            [memory memoryaddition:[_outlist doubleValue]];
            _outlist=@"";
        
        
    }else{
        [_Outline setText:_outlist];
    }
    
}

- (IBAction)mdivBtn {
    _outlist=[memory unperantheses:_outlist];
    if (![_outlist isEqual: @"Wrong Enter!"]) {

            [memory memorysubtraction:[_outlist doubleValue]];
            _outlist=@"";
    }else{
        [_Outline setText:_outlist];
    }
}

- (IBAction)mclearBtn {
    _outlist=@"";
    [_Outline setText:@"0"];
    [memory memoryclear];
    isfirst=true;
}

- (IBAction)mreadBtn {
    _outlist=[NSString stringWithFormat:@"%.2f",memory.memory];
    [_Outline setText:_outlist];
}


@end
