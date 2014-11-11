//
//  ViewController.m
//  MyCalculator
//
//  Created by alwaysking on 14/11/3.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize label;
@synthesize lableString;
@synthesize currentOp;
@synthesize opNum1;
@synthesize opNum2;
@synthesize currentSum;
@synthesize pointTag;
@synthesize numArray;
@synthesize opArray;
@synthesize opMemory;

bool num1Tag = false;
bool num2Tag = false;
bool exceptionZero = false;
bool equelPreTag = false;
bool mPlusTag = false;
char preOp,laterOp;
bool equelTag = false;
double num2EquelTemp = 0;


int level = -1;
- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    currentOp = 0;
    opNum1 = 0;
    currentSum = 0;
    lableString = @"0";
    opMemory = 0;
    pointTag = false;
    numArray = [[NSMutableArray alloc] init];
    opArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//数字按钮
- (IBAction) numDigit:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (exceptionZero) {
        exceptionZero = false;
        lableString = @"0";
    }
    if (mPlusTag) {
        lableString = @"0";
        mPlusTag = false;
    }
    if (num1Tag && !num2Tag) {
        lableString = @"0";
        num2Tag = true;
    }
    if ([lableString length] < 10) {
        lableString = [lableString stringByAppendingString:[button currentTitle]];
        lableString = [self deletePreZreo:lableString];
    }
    [self showLable];
}

- (void) showLable{
    if (exceptionZero) {
        lableString = @"不是数字";
        currentOp = 0;
        opNum1 = 0;
        opNum2 = 0;
        currentSum = 0;
        equelPreTag = false;
        opNum1 = 0;
        num1Tag = false;
        num2Tag = false;
        pointTag = false;
        mPlusTag = false;
        equelPreTag = false;
        equelTag = false;
    }
//    if([lableString length] > 8){
//        double temp = [lableString doubleValue];
//         label.text = [NSString stringWithFormat:@"%g",temp];
//    }
//    else
    {
        label.text = lableString;
    }
}

- (NSString *) deletePointZreo:(NSString *) str{
    NSString * strFinal;
    for (int i = [str length] - 1; i>=0; i--) {
        char c = [str characterAtIndex:i];
        if(c == '0'){
            continue;
        }else if(c == '.'){
            strFinal = [str substringToIndex:i ];
            break;
        }else{
            strFinal = [str substringToIndex:i + 1];
            break;
        }
    }
    return strFinal;
}

- (NSString *) deletePreZreo:(NSString *) str{
    NSString *strFinal;
    for (int i = 0; i<[str length]; i++) {
        char c = [str characterAtIndex:i];
        if(c == '0'){
            if (i == [str length] - 1) {
                strFinal = [str substringFromIndex:i];
                break;
            }
            continue;
        }else if(c == '.'){
            strFinal = [str substringFromIndex:i - 1 ];
            break;
        }else{
            strFinal = [str substringFromIndex:i];
            break;
        }
    }
    return strFinal;
}

- (IBAction) clearAll:(id)sender{
    currentOp = 0;
    opNum1 = 0;
    opNum2 = 0;
    currentSum = 0;
    equelPreTag = false;
    lableString = @"0";
    opNum1 = 0;
    num1Tag = false;
    num2Tag = false;
    pointTag = false;
    mPlusTag = false;
    equelPreTag = false;
    equelTag = false;
    exceptionZero = false;
    [self showLable];
}


- (IBAction) operatorSelect:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (num1Tag) {
        if (num2Tag) {
            opNum2 = [lableString doubleValue];
            if ([[button currentTitle] characterAtIndex:0] == '=') {
                [self Compute:preOp];
                equelTag = true;
                num2EquelTemp = opNum2;
//              ableString = @"0";
            }
            else{
                [self Compute:preOp];
                preOp = [[button currentTitle] characterAtIndex:0];
            }
          
            lableString = [NSString stringWithFormat:@"%f",currentSum];
            lableString = [self deletePointZreo:lableString];
            [self showLable];
            opNum1 = currentSum;
            num2Tag = false;
        }else{
            if([[button currentTitle] characterAtIndex:0] == '='){
                if (equelTag ) {
                    equelPreTag = true;
                    opNum2 = num2EquelTemp;
                }
                else if(!equelPreTag) {
                    equelPreTag = true;
                    opNum2 = [lableString doubleValue];
                }
                [self Compute:preOp];
                lableString =[NSString stringWithFormat:@"%f",currentSum];
                lableString = [self deletePointZreo:lableString];
                [self showLable];
                opNum1 = currentSum;
                lableString = @"0";
            }
            else{
                opNum2 = [lableString doubleValue];
                preOp = [[button currentTitle] characterAtIndex:0];
            }
        }
    }
    else{
        if ([[button currentTitle] characterAtIndex:0] != '=') {
            opNum1 = [lableString doubleValue];
            preOp = [[button currentTitle] characterAtIndex:0];
            num1Tag = true;
        }
        
    }
    
    
}

-(IBAction) equelOp:(id)sender{
    if (num1Tag) {
        [self Compute:preOp];
        lableString =[NSString stringWithFormat:@"%f",currentSum];
        lableString = [self deletePointZreo:lableString];
        [self showLable];
    }
}

- (void) zhengFuOp{
    if(![lableString  isEqual: @"0"]){
        NSMutableString *str;
        str = [lableString mutableCopy];
        if ([lableString rangeOfString:@"-"].location == NSNotFound) {
            [str insertString:@"-" atIndex:0];
            lableString = [NSString stringWithString:str];
            lableString = [self deletePointZreo:lableString];
        }else{
            [str deleteCharactersInRange: NSMakeRange(0, 1)];
            
            lableString = [NSString stringWithString:str];
            lableString = [self deletePointZreo:lableString];
        }
        if (num1Tag) {
            if (equelTag) {
                opNum1 = [lableString doubleValue];
            }else if(!num2Tag){
                opNum2 = [lableString doubleValue];
            }
        }
    }
    [self showLable];
}

- (void) Compute:(char) opt{
    switch (opt) {
        case '+':
            currentSum = opNum1 + opNum2;
            break;
        case '-':
            currentSum = opNum1 - opNum2;
            break;
        case '*':
            currentSum = opNum1 * opNum2;
            break;
        case '/':
            if (opNum2 == 0) {
                exceptionZero =true;
            }
            else{
                currentSum = opNum1 / opNum2;
            }
            break;
        case '%':
            currentSum = fmod (opNum1, opNum2);
            break;
        case '(':
            
            break;
        case ')':
            ;
            break;
        default:
            break;
    }
    
}

- (IBAction) backSpace:(id)sender{
    if ([lableString length] == 1) {
        lableString = @"0";
    }
    else{
        NSMutableString *str = [lableString mutableCopy];
        lableString = [str substringToIndex:[lableString length] - 1];
    }
    [self showLable];
}

- (IBAction) mOperator:(id)sender{
    UIButton *button = (UIButton *)sender;
    switch ([[button currentTitle] characterAtIndex:1]) {
        case '-':
            opMemory = opMemory - [lableString doubleValue];
            break;
        case 'C':
            opMemory = 0;
            break;
        case 'R':
            lableString = [NSString stringWithFormat:@"%f",opMemory];
            lableString = [self deletePointZreo:lableString];
            if (num1Tag == true) {
                opNum2 = opMemory;
            }
            [self showLable];
            break;
        case '+':
            opMemory = [lableString doubleValue];
            mPlusTag = true;
            break;
        default:
            break;
    }
}

//小数点
- (IBAction) exPoint:(id)sender{
    
    if([lableString rangeOfString:@"."].location == NSNotFound) {
        pointTag = true;
        lableString = [lableString stringByAppendingString:@"."];
    }
    [self showLable];
}



@end
