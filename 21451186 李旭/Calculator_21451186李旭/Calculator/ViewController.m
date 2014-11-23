//
//  ViewController.m
//  Calculator
//
//  Created by lixu on 14/11/3.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import "ViewController.h"
#define AFTER_METHOD 1
#define BEFORE_METHOD 0
#define ADD 1
#define SUB 2
#define MUL 3
#define DIVISION 4
#define MAKEDIV 5
#define LEFTBRAC 6
#define RIGHTBRAC 7


@interface ViewController ()
- (IBAction)set7:(id)sender;
- (IBAction)mul:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property(strong, nonatomic) NSMutableString *resultString;
@property (strong, nonatomic) NSString *MresultString;
- (IBAction)add:(id)sender;
- (IBAction)setSpot:(id)sender;
- (IBAction)set8:(id)sender;
- (IBAction)makeEqual:(id)sender;
@end

@implementation ViewController
@synthesize resultString;
@synthesize MresultString;
float leftNum;
float rightNum;
float tempResult;
float MtempResult=0;
NSInteger method=0;
NSInteger methodCount=0;
NSInteger brac=0;
NSInteger numOrmethod=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    resultString=[[NSMutableString alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)changeFloat:(double)Right
{
    NSString *stringFloat;
    stringFloat = [NSString stringWithFormat:@"%f",Right];
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = (int)length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

- (IBAction)set7:(id)sender {
    numOrmethod=0;
    [resultString appendString:@"7"];
    _resultLabel.text=resultString;
   // NSLog(@"点击7%@",resultString);
}

- (IBAction)mul:(id) sender {
    if (numOrmethod==0) {
        [self methodRegular ];
    }
//    methodCount++;
//    resultString=[NSMutableString stringWithString:@""];
//    if (methodCount==1) {
//        leftNum=[_resultLabel.text floatValue];
//    }
//    else {
//        rightNum=[_resultLabel.text floatValue];
//        [self makeEqual:nil];
//        _resultLabel.text=[self changeFloat:tempResult];
//        leftNum=[_resultLabel.text floatValue];
//        NSLog(@"this is MUL leftNum %f rightNum %f tempResult %f",leftNum, rightNum, tempResult);
//    }
//    NSLog(@"this is MUL %ld",(long)methodCount);
    method=MUL;
    numOrmethod++;

}
-(void) Vmul:(float) rightNum {
    tempResult=leftNum*rightNum;
}
- (IBAction)add:(id)sender {
    if (numOrmethod==0) {
        [self methodRegular ];
    }
//    methodCount++;
//    resultString=[NSMutableString stringWithString:@""];
//    if (methodCount==1) {
//        leftNum=[_resultLabel.text floatValue];
//    }
//    else {
//        rightNum=[_resultLabel.text floatValue];
//        [self makeEqual:nil];
//        _resultLabel.text=[self changeFloat:tempResult];
//        leftNum=[_resultLabel.text floatValue];
//        NSLog(@"this is ADD leftNum %f rightNum %f tempResult %f",leftNum, rightNum, tempResult);
//    }
//    NSLog(@"this is ADD %ld",(long)methodCount);
    method=ADD;
    numOrmethod++;

}
-(void) Vadd:(float) rightNum {
    tempResult=leftNum+rightNum;
}

- (IBAction)setSpot:(id)sender {
    [resultString appendString:@"."];
    _resultLabel.text=resultString;
}

- (IBAction)set8:(id)sender {
    numOrmethod=0;
    [resultString appendString:@"8"];
    _resultLabel.text=resultString;
}

- (IBAction)makeEqual:(id)sender {
    rightNum=[_resultLabel.text floatValue];
    NSLog(@"leftNum%f",leftNum);
    NSLog(@"rightNum%f",rightNum);
    switch (method) {
        case ADD:
            [self Vadd:rightNum];
            NSLog(@"this is add %f",tempResult);
            break;
        case MUL:
            [self Vmul:rightNum];
            NSLog(@"this is mul %f",tempResult);
            break;
        case SUB:
            [self Vsub:rightNum];
            NSLog(@"this is sub %f",tempResult);
            break;
        case DIVISION:
            if (rightNum==0) {
                tempResult=0;
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"被减数出错" message:@"被除数不能为零" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                resultString=[NSMutableString stringWithString:@""];
            }else{
                [self Vdivision:rightNum];
                NSLog(@"equal this is division");
            }
            break;
        case MAKEDIV:
            [self VmakeDiv:rightNum];
            break;
        case RIGHTBRAC:
            
            break;
        default:
            break;
    }
    _resultLabel.text=[self changeFloat:tempResult];
     resultString=[NSMutableString stringWithString:@""];
    numOrmethod++;
    NSLog(@"%@ %f",_resultLabel.text,tempResult);
}
- (IBAction)set0:(id)sender {
    numOrmethod=0;
    [resultString appendString:@"0"];
    _resultLabel.text=resultString;
}

- (IBAction)set1:(id)sender {
    numOrmethod=0;
    [resultString appendString:@"1"];
    _resultLabel.text=resultString;
}

- (IBAction)set2:(id)sender {
    numOrmethod=0;
    [resultString appendString:@"2"];
    _resultLabel.text=resultString;
}

- (IBAction)set3:(id)sender {
    numOrmethod=0;
    [resultString appendString:@"3"];
    _resultLabel.text=resultString;
}

- (IBAction)set4:(id)sender {
    numOrmethod=0;
    [resultString appendString:@"4"];
    _resultLabel.text=resultString;
}

- (IBAction)set5:(id)sender {
    numOrmethod=0;
    [resultString appendString:@"5"];
    _resultLabel.text=resultString;
}

- (IBAction)set6:(id)sender {
    numOrmethod=0;
    [resultString appendString:@"6"];
    _resultLabel.text=resultString;
}

- (IBAction)set9:(id)sender {
    numOrmethod=0;
    [resultString appendString:@"9"];
    _resultLabel.text=resultString;
}

- (IBAction)sub:(id)sender {
    if (numOrmethod==0) {
        [self methodRegular];
    }
    method=SUB;
    numOrmethod++;
}
-(void) Vsub:(float) rightNum{
    tempResult=leftNum - rightNum;
}

- (IBAction)clearAll:(id)sender {
    resultString=[NSMutableString stringWithString:@""];
    _resultLabel.text=@"0";
    leftNum=0;
    rightNum=0;
    methodCount=0;
    method=0;
    tempResult=0;
}

- (IBAction)mPlus:(float)rightNum {
    MresultString=_resultLabel.text;
    MtempResult+=[MresultString floatValue];
}

- (IBAction)mSub:(id)sender {
    MresultString=_resultLabel.text;
    MtempResult-=[MresultString floatValue];
}

- (IBAction)mClear:(id)sender {
    MresultString=@"";
    resultString=[NSMutableString stringWithString:@""];
    MtempResult=0;
    NSLog(@"this is mc %@",resultString);
}

- (IBAction)mReveal:(id)sender {
    _resultLabel.text=[self changeFloat:MtempResult];
    resultString=[NSMutableString stringWithString:@""];
    
}

- (IBAction)makeDiv:(id) sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"取余只能对整数操作，如果您输入的不是整数，将只读取整数部分且不能为‘0’" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    if (numOrmethod==0) {
        [self methodRegular];
    }
    method=MAKEDIV;
    numOrmethod++;

}
-(void) VmakeDiv:(float) rightNum{
    tempResult=(int)leftNum % (int)rightNum;
}

- (IBAction)division:(id)sender {
    if (numOrmethod==0) {
    [self methodRegular];
    }
//    methodCount++;
//    resultString=[NSMutableString stringWithString:@""];
//    if (methodCount==1) {
//        leftNum=[_resultLabel.text floatValue];
//    }
//    else {
//        rightNum=[_resultLabel.text floatValue];
//        [self makeEqual:nil];
//        _resultLabel.text=[self changeFloat:tempResult];
//        leftNum=[_resultLabel.text floatValue];
//        NSLog(@"this is division leftNum %f rightNum %f tempResult %f",leftNum, rightNum, tempResult);
//    }
//    NSLog(@"this is division %ld",(long)methodCount);
    method=DIVISION;
    numOrmethod++;
}
- (void) Vdivision:(float)rightNum{
    tempResult=leftNum/rightNum;
}


- (IBAction)leftBrac:(id)sender {
    [resultString appendString:@"("];
    _resultLabel.text=resultString;
    ++brac;
    
}

- (IBAction)rightBrac:(id)sender {
    [resultString appendString:@")"];
    _resultLabel.text=resultString;
    [self makeEqual:nil];
    leftNum=tempResult;
    --brac;
    if (brac<0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"没有对应的“（”，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    method=RIGHTBRAC;
    NSLog(@"this is rightBrac %f",leftNum);
}

-(void) methodRegular{
    methodCount++;
    resultString=[NSMutableString stringWithString:@""];
    if (methodCount==1) {
        leftNum=[_resultLabel.text floatValue];
    }
    else {
        rightNum=[_resultLabel.text floatValue];
        [self makeEqual:nil];
        _resultLabel.text=[self changeFloat:tempResult];
        leftNum=[_resultLabel.text floatValue];
//        NSLog(@"this is division leftNum %f rightNum %f tempResult %f",leftNum, rightNum, tempResult);
    }
//    NSLog(@"this is division %ld",(long)methodCount);

    
}

@end
