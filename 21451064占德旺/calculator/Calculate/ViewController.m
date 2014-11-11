//
//  ViewController.m
//  Calculate
//
//  Created by Devon on 14/11/6.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import "ViewController.h"
#import "Calculate.h"

@interface ViewController (){
    NSString *_memoryStr;
    NSString *_tempStr;
    Calculate *_calculate;
    NSString *_passString;
    NSString *_lastAnswer;
}

- (void)clearAll;
- (void)clearMemory;
- (void)memoryRead;
- (void)deleteBack;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _resultText.text = @"";
    _expressionText.text = @"";
    _memoryStr = @"0";
    _calculate = [[Calculate alloc]init];
    _tempStr = [NSString string];
    _lastAnswer = [NSString string];
    _passString = [NSString string];
}

- (IBAction)tapAction:(UIButton *)sender{
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
        case opPlus:
        case opMinus:
        case opDivide:
        case opMultiply:
        case opRightBracket:
        case opLeftBracket:
        case opDot:
        case opMod:
        case opNegative:
            if([_resultText.text isEqualToString:@"error"]){
                _resultText.text = @"";
                break;
            }
            _resultText.text = [_tempStr stringByAppendingString:sender.titleLabel.text];
            _tempStr = _resultText.text;
            break;
        case opEqual:
            if(![_tempStr isEqualToString:@""]){
                _passString = [self replaceInputStrWithPassStr:_tempStr];
                _expressionText.text = [_tempStr stringByAppendingString:sender.titleLabel.text];
                _tempStr = [_calculate calculateWithString:_passString andAnswerString:_lastAnswer];
                _resultText.text = _tempStr;
                _lastAnswer = _tempStr;
            }
            break;
        case opMemoryMinus:
            if([self memoryShouldPlusOrMinus]){
                _resultText.text = [_tempStr stringByAppendingString:_memoryStr];
                _tempStr = _resultText.text;
                _resultText.text = [_tempStr stringByAppendingString:@"-"];
                _tempStr = _resultText.text;
            }
            break;
        case opMemoryPlus:
            if([self memoryShouldPlusOrMinus]){
                _resultText.text = [_tempStr stringByAppendingString:_memoryStr];
                _tempStr = _resultText.text;
                _resultText.text = [_tempStr stringByAppendingString:@"+"];
                _tempStr = _resultText.text;
            }
            break;
        case opDel:
            [self deleteBack];
            break;
        case opMemoryRead:
            [self memoryRead];
            break;
        case opMemoryClear:
            [self clearMemory];
            break;
        case opCear:
            [self clearAll];
            break;
        default:
            break;
    }
}

- (NSString *)replaceInputStrWithPassStr:(NSString *)inputStr{
    NSString * tempString = inputStr;
    if(!([tempString rangeOfString:@"±"].location == NSNotFound)){
        tempString = [tempString stringByReplacingOccurrencesOfString:@"±" withString:@"-"];
    }
    if(!([tempString rangeOfString:@"÷"].location == NSNotFound)){
        tempString = [tempString stringByReplacingOccurrencesOfString:@"÷" withString:@"/"];
    }
    return tempString;
}

- (BOOL)memoryShouldPlusOrMinus{
    if([_resultText.text isEqualToString:@""]) return YES;
    else if([_resultText.text length] > 0){
        int count = (int)[_resultText.text length];
        UniChar c = [_resultText.text characterAtIndex:count-1];
        if([self isaNumber:c]) return NO;
        else return YES;
    }
    else{
        return NO;
    }
}

- (bool)isaNumber:(UniChar)c{
    if((c >= '0'&&c <= '9')||c == '.') return 1;
    else return 0;
}

- (void)memoryRead{
    NSString *tempString = _resultText.text;
    int i = 0;
    int length = (int)[tempString length];
    while (i < length) {
        UniChar c = [tempString characterAtIndex:i];
        if(![self isaNumber:c]){
            _memoryStr = @"0";
            return;
        }
        ++i;
    }
    _memoryStr = tempString;
}

- (void)clearMemory{
    _memoryStr = @"0";
}

- (void)clearAll{
    _resultText.text = @"";
    _expressionText.text = @"";
    _tempStr = @"";
    _passString = @"";
}

- (void)deleteBack{
    if(![_resultText.text isEqual:@""]){
        if([_resultText.text isEqualToString:@"error"]){
            _resultText.text = @"";
        }
        else{
            _resultText.text = [_resultText.text substringToIndex:_resultText.text.length-1];
        }
        _tempStr = _resultText.text;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
