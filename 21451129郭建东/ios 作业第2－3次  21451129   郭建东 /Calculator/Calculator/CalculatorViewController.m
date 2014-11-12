//
//  CalculatorViewController.h
//  Calculator
//
//  Created by GUO on 14-11-05.
//  Copyright (c) 2014年 GUO
//

#import "CalculatorViewController.h"
#import "CalculatorDetails.h"

@interface CalculatorViewController (){
    NSString *tmpString;
    CalculatorDetails *calcultorDetail;
    NSString *Ans;
    NSString *passStr;
    int countFlat;
}

- (void)clearAll;
- (void)deleteBack;


@end

@implementation CalculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _resultText.text = @"";
	_totalResultLabel.text = @"";
    Ans = @"";
    calcultorDetail = [[CalculatorDetails alloc]init];
    tmpString = [NSString string];
    passStr = [NSString string];
}

#pragma - mark Button Actions
- (IBAction)tapAction:(UIButton *)sender {
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
        case 12:
        case 13:
        case 14:
        case 15:
        case 17:
        case 18:
        case 19:
        case 20:
        case 21:
        case 22:
        case 24:
        {
            if (countFlat == 0) {
                    _resultText.text = [tmpString stringByAppendingString:sender.titleLabel.text];
            }
            
            else{
                if (tag == 20 || tag == 17 || tag == 18 ||tag == 12 ||tag == 14 ||tag == 15 || tag== 13)
                {
                    if (![_resultText.text isEqualToString:@"error"]) {
                            _resultText.text = [_resultText.text stringByAppendingString:sender.titleLabel.text];
                    }else{
                    _resultText.text = [@"0" stringByAppendingString:sender.titleLabel.text];
                    }
                }
                else{
                    _resultText.text = [tmpString stringByAppendingString:sender.titleLabel.text];
                }
            }
            
            tmpString = _resultText.text;
            
        }
            break;
        case 10:
            [self clearAll];
            break;
        case 11:
            [self deleteBack];
            break;
        case 16:
        {
            if (![tmpString isEqualToString:@""]) {
                passStr = [self replaceInputStrWithPassStr:tmpString];
                _totalResultLabel.text = [tmpString stringByAppendingString:sender.titleLabel.text];
                if ([Ans isEqualToString:@"error"]||countFlat == 0 ||[Ans isEqualToString:@""]) {
                    tmpString = [calcultorDetail calculatingWithString:passStr andAnswerString:@"0"];
                }else{
                    tmpString = [calcultorDetail calculatingWithString:passStr andAnswerString:Ans];
                }
                
                _resultText.text = tmpString;
                Ans = tmpString;
          
                tmpString = [NSString string];
                countFlat = 1;
            }
            
        }
            break;
        default:
            break;
    }
    
}
#pragma - mark Ultity Methods
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
 
    if (!([tempString rangeOfString:@"÷"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"÷" withString:@"d"];
    }
    return tempString;
}

- (void)clearAll
{
	_resultText.text = @"";
	_totalResultLabel.text = @"";
    tmpString = @"";
    passStr = @"";
    countFlat = 0;
    Ans = @"";
}

- (void)deleteBack{
    if (![_resultText.text isEqual:@""]) {
        if (([_resultText.text length] == 1)||[_resultText.text isEqualToString: @"error"]) {
            _resultText.text = @"";
        }else{
            _resultText.text = [_resultText.text substringToIndex:_resultText.text.length -1];
        }
        tmpString = _resultText.text;
    }else{
        return;
    }
}

#pragma - mark Memory Management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _resultText = nil;
    tmpString =nil;
    _totalResultLabel = nil;
    calcultorDetail = nil;
}

@end
