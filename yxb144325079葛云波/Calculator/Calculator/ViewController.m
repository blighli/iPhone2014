//
//  ViewController.m
//  Calculator
//
//  Created by 葛 云波 on 14/11/7.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//构造方法
-(id)init{
    self = [super init];
    if(self){
        opc = [[NSString alloc] initWithFormat:@"0"];
        op1 = 0.0;
        op2 = 0.0;
        cache = 0.0;
        result = 0.0;
        hasCache = NO;
        [self resetAll];
    }
    return self;
}

//------------------------------------------------
-(void) reset{
    opc = @"";
    op1 = 0.0;
    op2 = 0.0;
    result = 0.0;
    opi = 0;
    lastInput = 0;
    hasPoint = NO;
    lastOp = -1;
    isError = 0;
    [self.cacheSta setText:@""];
    [self display:@"0"];
}
-(void) resetAll{
    cache = 0.0;
    hasCache = NO;
    [self reset];
}

-(void) display:(NSString *)display{
    
    [_resultLabel setText:display];
}
-(void)displayError:(NSInteger)ErrorID{
    isError = ErrorID;
    NSString* ErrorMsg;
    switch (ErrorID){
            case 1:
                ErrorMsg = [NSString stringWithFormat:@"错误！"];
                break;
            default:
                ErrorMsg = @"";
                break;
    }
    [self display:ErrorMsg];
    [self reset];
}
-(void) displayResult:(NSString *)Result{
    [self display:Result];
}

-(void) setStatusInfo:(id)ctrl title:(NSString *)title{
    [ctrl setText:title];
}

//缓存操作
-(void) saveCache  {
    if(opi==0) {
        cache = op1;
    }
    else{
        cache = [opc doubleValue];
    }
    hasCache = YES;
    [self setStatusInfo:_cacheSta title:@"M"];
}
-(void) saveAntiCache {
    if(opi==0) {
        cache = -op1;
    }
    else{
        cache = -[opc doubleValue];
    }
    hasCache = YES;
    [self setStatusInfo:_cacheSta title:@"M"];
}
-(void) readCache {
    if(hasCache==YES){
        if(opi == 0){
            op1 = cache;
        } else{
            op2 = cache;
        }
        opc = [NSString stringWithFormat:@"%lf",cache];
        [self display:opc];
    }
}
-(void) clearCache{
    cache = 0;
    hasCache = NO;
    [self setStatusInfo:_cacheSta title:@""];
}
-(void) deleteANumber{
    if([self.resultLabel.text isEqualToString:@"0"])
    {
        [self display:@"0"];
    }
    else if ([self.resultLabel.text length]==1)
    {
        [self display:@"0"];
    }
    else
    {
        [self.resultLabel.text substringToIndex:[self.resultLabel.text length]-1];
        [self display:self.resultLabel.text];
    }
}
-(void) antiNumber{
    NSString* tempString;
    NSInteger tempNumber;
    if([self.resultLabel.text isEqualToString:@"0"])
    {
        [self display:@"0"];
    }
    else
    {
        tempString = [self.resultLabel text];
        tempNumber = -[tempString integerValue];
        tempString = [NSString stringWithFormat:@"%d",tempNumber];
        opc = tempString;
        [self display:tempString];
    }
}

//命令操作
-(void)inputACommand:(NSInteger)cmd{
    switch (cmd){
        case 1: //press AC
            [self resetAll];
            break;
        case 2://press MC
            [self clearCache];
            break;
        case 3://press M+
            [self saveCache];
            break;
        case 4://press M-
            [self saveAntiCache];
            break;
        case 5://press MR
            [self readCache];
            break;
        case 6://press delete
            [self deleteANumber];
            break;
        case 7://press +-
            [self antiNumber];
            break;
        default:
            break;
            
    }
}

//处理当前操作数
-(void) inputANumber:(NSInteger)number{
    if([opc length]>=6){
        return;
    }
    if(number==11){
        //输入小数点
        if(hasPoint==NO){
            if([opc intValue]==0){
                opc = @"0";
            }
            opc = [NSString stringWithFormat:@"%@.",opc];
            hasPoint = YES;
        }
    }else {
        //输入数字
        if([opc intValue]==0){
            if(number==0)
                opc = [NSString stringWithFormat:@"0"];
            else
                opc = [NSString stringWithFormat:@"%d",number];
        }
        else{
            opc = [NSString stringWithFormat:@"%@%d",opc,number];
        }
    }
    if(opi == 0){
        op1 = [opc doubleValue];
    }
    else {
        op2 = [opc doubleValue];
    }
    lastInput = 1;
    [self displayResult:opc];
}

//输入操作符
-(void) inputAOperator:(NSInteger)opt{
    double _result = 0;
    if(opt==0){
        //等号
        if(lastOp<0){
            if([opc doubleValue]!=0.0){
                result = [opc doubleValue];
                opc = @"";
            }
            _result = result;
        } else {
            _result = [self getResult:op1 :op2 :lastOp];
            result = _result;
        }
        opi = 0;
        op1 = result;
        op2 = 0;
        opc = @"";
    } else if (opt<5){
        //加减乘除
        if(lastOp==-1){
            _result = [opc doubleValue];
            result = _result;
        } else if (lastOp==0){
            if([opc doubleValue]!=0.0){
                result = [opc doubleValue];
                opc = @"";
            }
            _result = result;
        } else {
            if( lastOp==4 && opt==4 && [opc length]==0){
                op2 = 1;
            }
            _result = [self getResult:op1 :op2 :lastOp];
            result = _result;
        }
        opi = 1;
        op1 = result;
        op2 = 0;
        opc = @"";
    }
    hasPoint = NO;
    lastOp = opt;
    
    if(isError==0){
        [self displayResult:[NSString stringWithFormat:@"%lf",_result]];
    } else {
        [self displayError:isError];
        isError = 0;
    }
}

//获得运算结果
-(double) getResult:(double)number1 :(double)number2 :(NSInteger)operation{
    double _result = 0;
    switch(operation){
        case 0:
            _result = number1;break;
        case 1:
            _result = number1 + number2;break;
        case 2:
            _result = number1 - number2;break;
        case 3:
            _result = number1 * number2;break;
        case 4:
            if( number2 != 0){
                _result = number1 / number2;
            } else {
                isError = 1;
            }
            break;
        default:
            break;
    }
    return _result;
}


//-----------------------------------------------------

//press {AC|MC|M+|M-|MR|DELETE|+-}
- (IBAction)inputCommand:(id)sender {
    [self inputACommand:[sender tag]];
}
//press {0-9|.}
- (IBAction)inputNumberic:(id)sender {
    [self inputANumber:[sender tag]];
}
//press {+|-|*|/|=}
- (IBAction)inputOperator:(id)sender {
    [self inputAOperator:[sender tag]];
}

@end
