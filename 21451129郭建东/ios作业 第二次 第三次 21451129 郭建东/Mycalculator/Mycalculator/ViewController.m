//
//  ViewController.m
//  Mycalculator
//
//  Created by cstlab on 14/11/12.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorDetail.h"

@interface ViewController ()
{
    NSString *_tempStr;
    CalculatorDetail *_calcultor;
    
    NSString *_lastAnswer;
    NSString *_passString;
    int countFlat;
    
}

- (void)clearAll;
- (void)deleteBack;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _resultText.text = @"";
    _totalResultLabel.text = @"";
    _lastAnswer = @"";
    _calcultor = [[CalculatorDetail alloc]init];
    _tempStr = [NSString string];
    _passString = [NSString string];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)taoAction:(UIButton *)sender {
    long int tag = sender.tag;
    switch (tag) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case kDot:
        case kRightBracket:
        case kLeftBracket:
        case kDevide:
        case kSub:
        case kPlus:
        case kMultiply:
        case kPower:
        case kSin:
        case kCos:
        case kLog:
        {
            //First Operation
            if (countFlat == 0) {
                _resultText.text = [_tempStr stringByAppendingString:sender.titleLabel.text];
            }
            
            else{
                if (tag == kPower || tag == kRightBracket || tag == kLeftBracket ||tag == kDevide ||tag == kSub ||tag == kPlus || tag== kMultiply)
                {
                    if (![_resultText.text isEqualToString:@"error"]) {
                        _resultText.text = [_resultText.text stringByAppendingString:sender.titleLabel.text];
                    }else{
                        _resultText.text = [@"0" stringByAppendingString:sender.titleLabel.text];
                    }
                }
                else{
                    _resultText.text = [_tempStr stringByAppendingString:sender.titleLabel.text];
                }
            }
            
            _tempStr = _resultText.text;
            
        }
            break;
        case kClear:
            [self clearAll];
            break;
        case kDel:
            [self deleteBack];
            break;
        case kEqual:
        {
            if (![_tempStr isEqualToString:@""]) {
                _passString = [self replaceInputStrWithPassStr:_tempStr];
                _totalResultLabel.text = [_tempStr stringByAppendingString:sender.titleLabel.text];
                if ([_lastAnswer isEqualToString:@"error"]||countFlat == 0 ||[_lastAnswer isEqualToString:@""]) {
                    _tempStr = [_calcultor calculatingWithString:_passString andAnswerString:@"0"];
                }else{
                    _tempStr = [_calcultor calculatingWithString:_passString andAnswerString:_lastAnswer];
                }
                
                _resultText.text = _tempStr;
                _lastAnswer = _tempStr;
                
                _tempStr = [NSString string];
                countFlat = 1;
            }
            
        }
            break;
        default:
            break;
    }
}

- (NSString *)replaceInputStrWithPassStr:(NSString *)inputStr{
    NSString *tempString = inputStr;
    //替换操作符
    if (!([tempString rangeOfString:@"sin"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"sin" withString:@"s"];
    }
    if (!([tempString rangeOfString:@"cos"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"cos" withString:@"c"];
    }
    
    if (!([tempString rangeOfString:@"log"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"log" withString:@"l"];
    }
    
    if (!([tempString rangeOfString:@"/"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"/" withString:@"d"];
    }
    return tempString;
}

- (void)clearAll
{
    _resultText.text = @"";
    _totalResultLabel.text = @"";
    _tempStr = @"";
    _passString = @"";
    countFlat = 0;
    _lastAnswer = @"";
}

- (void)deleteBack{
    if (![_resultText.text isEqual:@""]) {
        if (([_resultText.text length] == 1)||[_resultText.text isEqualToString: @"error"]) {
            _resultText.text = @"";
        }else{
            _resultText.text = [_resultText.text substringToIndex:_resultText.text.length -1];
        }
        _tempStr = _resultText.text;
    }else{
        return;
    }
}





@end
