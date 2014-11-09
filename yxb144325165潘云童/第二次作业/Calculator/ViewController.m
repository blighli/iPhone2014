//
//  ViewController.m
//  Calculator
//
//  Created by Joker on 14/11/4.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *formula;
@property (weak, nonatomic) IBOutlet UILabel *result;
- (IBAction)btnInput:(id)sender;
- (IBAction)delete:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)memoryClear:(id)sender;
- (IBAction)memoryRead:(id)sender;
- (IBAction)memoryPlus:(id)sender;
- (IBAction)memorySubtract:(id)sender;
- (IBAction)calculate:(id)sender;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _formulaString = [[NSMutableString alloc] init];
    _memory = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加减乘除计算
- (double)a:(NSString*)one calculate:(NSString*)oprate b:(NSString*)two {
    double a = [one doubleValue];
    double b = [two doubleValue];
    
    if ([@"+" isEqualToString:oprate]) {
        return a + b;
    }
    
    if ([@"-" isEqualToString:oprate]) {
        return a - b;
    }
    
    if ([@"×" isEqualToString:oprate]) {
        return a * b;
    }
    
    if ([@"÷" isEqualToString:oprate]) {
        return a / b;
    }
    
    return 0;
}

//取余计算
- (int)a:(NSString*)one quyub:(NSString*)two {
    int a = [one intValue];
    int b = [two intValue];
    
    return a % b;
}

- (NSString*)removeZero:(NSString*)result {
    for (int i = (int)[result length]-1; i > 0; i--) {
        NSString* curChar = [NSString stringWithFormat:@"%c", [result characterAtIndex:i]];
        
        if ([@"." isEqualToString:curChar]) {
            result = [result substringToIndex:i];
            break;
        }
        
        if (![@"0" isEqualToString:curChar]) {
            break;
        }
        
        result = [result substringToIndex:i];
    }
    return result;
}

- (IBAction)btnInput:(id)sender {
    [_formulaString appendString:[sender currentTitle]];
    _formula.text = [NSString stringWithString:_formulaString];
}

- (IBAction)delete:(id)sender {
    if ([_formulaString length] != 0) {
        
        [_formulaString deleteCharactersInRange:NSMakeRange([_formulaString length]-1, 1)];
        _formula.text = [NSString stringWithString:_formulaString];
    }
}

- (IBAction)clear:(id)sender {
    [_formulaString deleteCharactersInRange:NSMakeRange(0, [_formulaString length])];
    _formula.text = [NSString stringWithString:_formulaString];
    _result.text = @"0";
}

- (IBAction)memoryClear:(id)sender {
    _memory = 0;
}

- (IBAction)memoryRead:(id)sender {
    _formula.text = [NSString stringWithFormat:@"%d", _memory];
}

- (IBAction)memoryPlus:(id)sender {
    _memory = _memory + [_result.text intValue];
}

- (IBAction)memorySubtract:(id)sender {
    _memory = _memory - [_result.text intValue];
}

- (IBAction)calculate:(id)sender {
    NSMutableArray* simpleArray = [[NSMutableArray alloc] init];
    NSMutableArray* completeArray = [[NSMutableArray alloc] init];
    Stack* opr_stack = [[Stack alloc] init];
    Stack* num_stack = [[Stack alloc] init];
    
    NSString* exp = [NSString stringWithString:_formulaString];
    int begin = 0;
    int length = (int)[exp length];
    for(int i = 0; i < length; i++) {
        NSString* curElement = [NSString stringWithFormat:@"%c", [exp characterAtIndex:i]];
        
        if ([@"+" isEqualToString:curElement]
           || [@"-" isEqualToString:curElement]
           || [@"×" isEqualToString:curElement]
           || [@"÷" isEqualToString:curElement]
           || [@"(" isEqualToString:curElement]
           || [@")" isEqualToString:curElement]
           || [@"%" isEqualToString:curElement]) {
            
            if (i != begin) {
                NSString* num = [exp substringWithRange:NSMakeRange(begin, i-begin)];
                [simpleArray addObject:num];
            }
            
            NSString* opr = [exp substringWithRange:NSMakeRange(i, 1)];
            [simpleArray addObject:opr];
            
            begin = i + 1;
        }
    }
    
    if (begin == 0) {
        NSLog(@"%@",exp);
        _result.text = exp;
        return;
    } else if (begin < [exp length]) {
        NSString* num = [exp substringWithRange:NSMakeRange(begin, [exp length]-begin)];
        [simpleArray addObject:num];
    }
    
    NSLog(@"%@",simpleArray);

    int count = (int)[simpleArray count];
    
    if (count == 3 && [@"%" isEqualToString:[simpleArray objectAtIndex:1]]) {
        int result = [self a:[simpleArray objectAtIndex:0]
                       quyub:[simpleArray objectAtIndex:2]];
        NSString* stringResult = [NSString stringWithFormat:@"%d", result];
        _result.text = stringResult;
        return;
    }
    
    for (int i = 0; i < count; i++) {
        NSString* curElement = [simpleArray objectAtIndex:i];
        if(![@"+" isEqualToString:curElement]
           && ![@"-" isEqualToString:curElement]
           && ![@"×" isEqualToString:curElement]
           && ![@"÷" isEqualToString:curElement]
           && ![@"(" isEqualToString:curElement]
           && ![@")" isEqualToString:curElement]) {
            
            [completeArray addObject:curElement];
        }
        else if([@"+" isEqualToString:curElement]
             || [@"-" isEqualToString:curElement]) {
            while (!opr_stack.isEmpty && ![@"(" isEqualToString:[opr_stack getStackTop]]) {
                
                [completeArray addObject:opr_stack.pop];
            }
            [opr_stack push:curElement];
        }
        else if([@"×" isEqualToString:curElement]
             || [@"÷" isEqualToString:curElement]) {
            while (!opr_stack.isEmpty
                &&  ![@"(" isEqualToString:opr_stack.getStackTop]
                &&  ![@"+" isEqualToString:opr_stack.getStackTop]
                &&  ![@"-" isEqualToString:opr_stack.getStackTop]) {
                
                [completeArray addObject:opr_stack.pop];
            }
            [opr_stack push:curElement];
        }
        else if([@"(" isEqualToString:curElement]) {
            
            [opr_stack push:curElement];
        }
        else if([@")" isEqualToString:curElement]) {
            while (![@"(" isEqualToString:opr_stack.getStackTop]) {
                
                [completeArray addObject:opr_stack.pop];
            }
            [opr_stack pop];
        }
    }
    
    while (!opr_stack.isEmpty) {
        
        [completeArray addObject:opr_stack.pop];
    }
    
    NSLog(@"%@",completeArray);
    
    for (int i = 0; i < count; i++) {
        NSString* curElement = [completeArray objectAtIndex:i];
        if(![@"+" isEqualToString:curElement]
        && ![@"-" isEqualToString:curElement]
        && ![@"×" isEqualToString:curElement]
        && ![@"÷" isEqualToString:curElement]) {
            
            [num_stack push:curElement];
        }
        else {
            NSString* b = [num_stack pop];
            NSString* a = [num_stack pop];
            if (a == nil || b == nil) {
                _result.text = @"表达式错误.";
                return;
            }
            double result = [self a:a calculate:curElement b:b];
            NSString* newNum = [NSString stringWithFormat:@"%f", result];
            [num_stack push:newNum];
        }
    }
    
    if ([num_stack getStackCount] != 1) {
        _result.text = @"表达式错误.";
        return;
    }
    
    NSString* result = [num_stack pop];
    result = [self removeZero:result];
    
    _result.text = result;
}


@end
