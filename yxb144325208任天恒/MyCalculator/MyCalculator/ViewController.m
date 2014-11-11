//
//  ViewController.m
//  MyCalculator
//
//  Created by rth on 14/11/4.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize label;
@synthesize lableString;
@synthesize currentOp;
@synthesize Number1;
@synthesize Number2;
@synthesize Sum;
@synthesize pointTag;
@synthesize numArray;
@synthesize opArray;
@synthesize Memory;

bool num1Tag = false;
bool num2Tag = false;
bool exceptionZero = false;
bool equelPreTag = false;
bool mAddTag = false;
bool equelTag = false;
double num2EquelTemp = 0;
char preOp,laterOp;



- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    currentOp = 0;
    Number1 = 0;
    Sum = 0;
    lableString = @"0";
    Memory = 0;
    pointTag = false;
    numArray = [[NSMutableArray alloc] init];
    opArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)MRButton:(id)sender {
    lableString = [NSString stringWithFormat:@"%f",Memory];
    lableString = [self deletePointZreo:lableString];
    if (num1Tag == true) {
        Number2 = Memory;
    }
    [self display];
}

- (IBAction)MminusButton:(id)sender {
    Memory = Memory - [lableString doubleValue];
}

- (IBAction)MAddButton:(id)sender {
    Memory = Memory+[lableString doubleValue];
    mAddTag = true;
}



- (IBAction)MCAction:(id)sender {
    Memory = 0;
}

- (IBAction) numDigit:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (exceptionZero) {
        exceptionZero = false;
        lableString = @"0";
    }
    if (mAddTag) {
        lableString = @"0";
        mAddTag = false;
    }
    if (num1Tag && !num2Tag) {
        lableString = @"0";
        num2Tag = true;
    }
    if ([lableString length] < 10) {
        lableString = [lableString stringByAppendingString:[button currentTitle]];
        lableString = [self deletePreZreo:lableString];
    }
    [self display];
}


- (void) display{
    if (exceptionZero) {
        currentOp = 0;
        Number1 = 0;
        Number2= 0;
        Sum = 0;
        equelPreTag = false;
        num1Tag = false;
        num2Tag = false;
        pointTag = false;
        mAddTag = false;
        equelPreTag = false;
        equelTag = false;
        lableString = @"错误";
    }

        label.text = lableString;
    
}


- (IBAction)dotOp:(id)sender {
    if([lableString rangeOfString:@"."].location == NSNotFound) {
        pointTag = true;
        lableString = [lableString stringByAppendingString:@"."];
    }
    [self display];
}

- (IBAction) clearAll:(id)sender{
    currentOp = 0;
    Number1 = 0;
    Number2 = 0;
    Sum = 0;
    equelPreTag = false;
    lableString = @"0";
    num1Tag = false;
    num2Tag = false;
    pointTag = false;
    mAddTag = false;
    equelPreTag = false;
    equelTag = false;
    exceptionZero = false;
    [self display];
}


- (IBAction) operatorSelect:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (num1Tag) {
        if (num2Tag) {
            Number2 = [lableString doubleValue];
            if ([[button currentTitle] characterAtIndex:0] == '=') {
                [self switchOP:preOp];
                equelTag = true;
                num2EquelTemp = Number2;
            }
            else{
                [self switchOP:preOp];
                preOp = [[button currentTitle] characterAtIndex:0];
            }
          
            lableString = [NSString stringWithFormat:@"%f",Sum];
            lableString = [self deletePointZreo:lableString];
            [self display];
            Number1 = Sum;
            num2Tag = false;
        }else{
            if([[button currentTitle] characterAtIndex:0] == '='){
                if (equelTag ) {
                    equelPreTag = true;
                    Number2 = num2EquelTemp;
                }
                else if(!equelPreTag) {
                    equelPreTag = true;
                    Number2 = [lableString doubleValue];
                }
                [self switchOP:preOp];
                lableString =[NSString stringWithFormat:@"%f",Sum];
                lableString = [self deletePointZreo:lableString];
                [self display];
                Number1 = Sum;
                lableString = @"0";
            }
            else{
                Number2 = [lableString doubleValue];
                preOp = [[button currentTitle] characterAtIndex:0];
            }
        }
    }
    else{
        if ([[button currentTitle] characterAtIndex:0] != '=') {
            Number1 = [lableString doubleValue];
            preOp = [[button currentTitle] characterAtIndex:0];
            num1Tag = true;
        }
        
    }
    
    
}




- (IBAction)ZFchange:(id)sender {
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
                Number1 = [lableString doubleValue];
                NSLog(@"第一个数字是%f",Number1);
            }else if(!num2Tag){
                Number2 = [lableString doubleValue];
            }
        }
    }
    [self display];

}


- (void) switchOP:(char) opt{

    switch (opt) {
        case '+':
            Sum = Number1 + Number2;
            break;
        case '-':
            Sum = Number1 - Number2;
            break;
        case '*':
            Sum = Number1 * Number2;
            break;
        case '/':
            if (Number2 == 0) {
                exceptionZero =true;
            }
            else{
                Sum = Number1 / Number2;
            }
            break;
        case '%':
            Sum = fmod (Number1, Number2);
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


- (IBAction)Del:(id)sender {
    if ([lableString length] == 1) {
        lableString = @"0";
    }
    else{
        NSMutableString *str = [lableString mutableCopy];
        lableString = [str substringToIndex:[lableString length] - 1];
    }
    [self display];
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






@end
