//
//  ViewController.m
//  counter
//
//  Created by CST on 14/11/6.
//  Copyright (c) 2014年 CST. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statelabel;
@property BOOL isShowingResult;
@property double memory;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _statelabel.text = @"";
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button:(id)sender {
    NSString *title = [sender titleForState:UIControlStateNormal];
    if([title isEqualToString: @"MC"])
    {
        self.memory = 0.0;
    }
    else if ([title isEqualToString:@"M+"])
    {
        self.memory += [self calculator:_statelabel.text];
    }
    else if ([title isEqualToString:@"M-"])
    {
        self.memory -= [self calculator:_statelabel.text];
    }
    else if ([title isEqualToString:@"<--"])
    {
        _statelabel.text = [_statelabel.text substringToIndex:_statelabel.text.length-1];
    }
    else if ([title isEqualToString:@"MR"])
    {
        _statelabel.text = [[NSNumber numberWithDouble:self.memory] stringValue];
    }
    else if ([title isEqualToString:@"="])
    {
        _statelabel.text = [[NSNumber numberWithDouble:[self calculator:_statelabel.text]] stringValue];;
        self.isShowingResult = YES;
    }
    else if ([title isEqualToString:@"c"] || [title isEqualToString:@"AC"])
    {
        _statelabel.text = @"";
    }
    else
    {
        if (self.isShowingResult) {
            self.isShowingResult = NO;
            _statelabel.text = @"";
        }
        NSMutableString * input=[NSMutableString stringWithString:_statelabel.text];
        [input appendString:title];
        _statelabel.text=input;
    }
    

    
    
}


- (BOOL)isOperator : (unichar)ch
{
    return ch == '+' || ch == '-' || ch == '*' || ch == '/';
}

- (BOOL)isNumber : (unichar)ch
{
    return ((ch >= '0' && ch <= '9') || ch == '.');
}

- (double)readNumber:(NSString *)s atIndex:(int*)index {
    int i = *index;
    while (i < s.length && [self isNumber:[s characterAtIndex:i]]) i++;
    NSRange range = {*index, i - *index};
    *index = i;
    return [[s substringWithRange:range] doubleValue];
}

- (double)readCAL:(NSString *)s atIndex:(int *)index {
    double res = [self readNumber:s atIndex:index];
    while (*index < s.length) {
        switch ([s characterAtIndex:*index]) {
            case '*':
                *index += 1;
                if (*index >= s.length) return res;
                res *= [self readNumber:s atIndex:index];
                break;
            case '%':
                *index += 1;
                if (*index >= s.length) return res;
                res = (int)res % (int)[self readNumber:s atIndex:index];
                break;
            case '/':
                *index += 1;
                if (*index >= s.length) return res;
                res /= [self readNumber:s atIndex:index];
                break;
            default:
                return res;
        }
    }
    return res;
}

- (double)calculate:(NSString *)s {
    int index = 0;
    double res = [self readCAL:s atIndex:&index];
    while (index < s.length) {
        switch ([s characterAtIndex:index]) {
            case '+':
                index += 1;
                if (index >= s.length) return res;
                res += [self readCAL:s atIndex:&index];
                break;
            case '-':
                index += 1;
                if (index >= s.length) return res;
                res -= [self readCAL:s atIndex:&index];
                break;
            default:
                return res;
        }
    }
    return res;
}

- (double)calculator : (NSString *)str
{
    NSMutableArray *st = [NSMutableArray arrayWithCapacity:10];
    [st addObject:[NSMutableString stringWithString:@""]];
    NSString *tmp;
    for (int i = 0; i < str.length; i++) {
        unichar c = [str characterAtIndex:i];
        switch (c) {
            case '(':
                [st addObject:[NSMutableString stringWithFormat:@""]];
                break;
            case ')':
                tmp = [[NSNumber numberWithDouble:[self calculate:[st lastObject]]] stringValue];
                [st removeLastObject];
                [(NSMutableString*)[st lastObject] appendString:tmp];
                break;
            default:
                [((NSMutableString*)[st lastObject]) appendFormat:@"%c", c];
                break;
        }
    }
    return [self calculate:[st lastObject]];
}


@end
