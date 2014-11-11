//
//  ViewController.m
//  calc
//
//  Created by 王威 on 14/11/7.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableString* textToShow;
NSNumber* memoryNumber;
NSMutableArray* postfixExpress;
NSMutableArray* helpStack;
NSMutableDictionary* opVal;
BOOL beforeRightParentheses = NO;

//indicate (, ), %, *, /, +, -
int priority[] = {-1, -1, 2, 2, 2, 1, 1};

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.displayField.text = @"0";
    textToShow = [NSMutableString stringWithCapacity:5];
    postfixExpress = [NSMutableArray arrayWithCapacity:2];
    helpStack = [NSMutableArray arrayWithCapacity:2];
    opVal = [NSMutableDictionary dictionary];
    [opVal setObject:@"(" forKey:@20];
    [opVal setObject:@")" forKey:@21];
    [opVal setObject:@"%" forKey:@22];
    [opVal setObject:@"/" forKey:@23];
    [opVal setObject:@"*" forKey:@24];
    [opVal setObject:@"-" forKey:@25];
    [opVal setObject:@"+" forKey:@26];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)memoryOperation:(UIButton *)sender {
    if (sender.tag == 11) {
        memoryNumber = @0.0;
    }else if (sender.tag == 12){
        double valueInMemory = [memoryNumber doubleValue];
        double valueShow = [textToShow doubleValue];
        memoryNumber = [NSNumber numberWithDouble:valueInMemory + valueShow];
    }else if (13 == sender.tag){
        double valueInMemory = [memoryNumber doubleValue];
        double valueShow = [textToShow doubleValue];
        memoryNumber = [NSNumber numberWithDouble:valueInMemory - valueShow];
        
    }else if (14 == sender.tag)
    {
        [self displayResult:memoryNumber];
    }
    [self resetTextToShow];
}

- (IBAction)backOperation:(UIButton *)sender {
    int len = [textToShow length];
    if (len > 0) {
        [textToShow deleteCharactersInRange:NSMakeRange(len - 1,  1)];
    }
    if ([textToShow length] == 0) {
        textToShow = [NSMutableString  stringWithString:@"0"];
    }
    self.displayField.text = textToShow;
}

- (IBAction)allClearButMemory:(UIButton *)sender {
    [self deallocResource];
    [self resetTextToShow];
    self.displayField.text = @"0";
}

- (IBAction)addOperation:(UIButton *)sender {
    int tag = sender.tag;
    switch (tag) {
        case 20://left parentheses
            [helpStack addObject:@20];
            break;
        case 21://right parentheses
            [postfixExpress addObject:textToShow];
            [self resetTextToShow];
            while (![[helpStack lastObject]  isEqual: @20]) {
                [postfixExpress addObject:opVal[[helpStack lastObject]]];
                [helpStack removeLastObject];
            }
            [helpStack removeLastObject];
            beforeRightParentheses = YES;
            break;
        default:
            if (beforeRightParentheses == NO) {
                [postfixExpress addObject:textToShow];
                [self resetTextToShow];
            }
            beforeRightParentheses = NO;
            while ([helpStack count] > 0 && priority[[[helpStack lastObject] intValue] - 20] >= priority[tag -20]
                    && ![opVal[[helpStack lastObject]] isEqual:@"("]) {
                [postfixExpress addObject:opVal[[helpStack lastObject]]];
                [helpStack removeLastObject];
            }
            [helpStack addObject:[NSNumber numberWithInt:tag]];
            break;
    }
}

- (IBAction)addOperand:(UIButton *)sender {
    if (sender.tag == 10) {
        [textToShow appendString:@"."];
    }
    else
    {
        [textToShow appendFormat:@"%d", sender.tag];
    }
    self.displayField.text = textToShow;
}

- (IBAction)equalOperation:(UIButton *)sender {
    if (beforeRightParentheses == NO) {
        [postfixExpress addObject:textToShow];
    }
    
    while ([helpStack count] > 0) {
        [postfixExpress addObject:opVal[[helpStack lastObject]]];
        [helpStack removeLastObject];
    }
    NSMutableArray* s = [NSMutableArray arrayWithCapacity:2];
    for (NSInteger i = 0; i < [postfixExpress count]; i++) {
        NSString *tmp = [postfixExpress objectAtIndex:i];
        if ([tmp  isEqual: @"%"]) {
            int b = [[s lastObject] intValue];
            [s removeLastObject];
            int a = [[s lastObject] intValue];
            [s removeLastObject];
            [s addObject:[NSString stringWithFormat:@"%d", a % b]];
        } else if([tmp isEqual:@"*"] || [tmp isEqual:@"/"] || [tmp isEqual:@"+"] || [tmp isEqual:@"-"]){
            double b = [[s lastObject] doubleValue];
            [s removeLastObject];
            double a = [[s lastObject] doubleValue];
            [s removeLastObject];
            if ([tmp isEqual:@"*"]) {
                [s addObject:[NSString stringWithFormat:@"%lf", a * b]];
            }else if ([tmp isEqual:@"/"]){
                if (0 == b) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息提示"
                                                                    message:@"除数不能为0" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    [self deallocResource];
                    [self resetTextToShow];
                    self.displayField.text = @"0";
                    return;
                }
                [s addObject:[NSString stringWithFormat:@"%lf", a / b]];
            }else if ([tmp isEqual:@"+"]){
                [s addObject:[NSString stringWithFormat:@"%lf", a + b]];
            }else if([tmp isEqual:@"-"]){
                [s addObject:[NSString stringWithFormat:@"%lf", a - b]];
            }
        }else{
            [s addObject:tmp];
        }
        tmp = nil;
        
    }
    
    [self displayResult:[NSNumber numberWithDouble:[s[0] doubleValue]]];
    [self resetTextToShow];
    s = nil;
    [self deallocResource];
}

- (void)displayResult:(NSNumber *)value
{
    int intValue = [value intValue];
    double doubleValue = [value doubleValue];
    if (intValue == doubleValue) {
        self.displayField.text = [NSString stringWithFormat:@"%d", intValue];
    }
    else{
        self.displayField.text = [NSString stringWithFormat:@"%lf", doubleValue];
    }
}

- (void)resetTextToShow{
    textToShow = [NSMutableString stringWithString:@""];
}

-(void) deallocResource{
    postfixExpress = nil;
    helpStack = nil;
    postfixExpress = [NSMutableArray arrayWithCapacity:2];
    helpStack = [NSMutableArray arrayWithCapacity:2];

}
@end
