//
//  ViewController.m
//  project2
//
//  Created by zack on 14-11-9.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize M;

- (NSString*)formatNumStr:(NSString*)str {
    double result = [str doubleValue];
    NSString *resultStr;
    if (fmodf(result, 1)==0) {
        resultStr = [NSString stringWithFormat:@"%.0f",result];
    } else if (fmodf(result*10, 1)==0) {
        resultStr = [NSString stringWithFormat:@"%.1f",result];
    } else {
        resultStr = [NSString stringWithFormat:@"%.2f",result];
    }
    return resultStr;
}

- (BOOL)compare:(NSString*)str :(NSMutableArray*)priStack {
    if ([priStack count] == 0) {
        return true;
    }
    NSString *last = [priStack lastObject];
    if ([last isEqualToString:@"("]) {
        return true;
    }
    if([str isEqualToString:@"#"])
        return false;
    if([str isEqualToString:@"("])
        return true;
    if([str isEqualToString:@")"])
        return false;
    if([str isEqualToString:@"×"] || [str isEqualToString:@"÷"] || [str isEqualToString:@"%"]){
        if ([last isEqualToString:@"+"] || [last isEqualToString:@"−"]) {
            return true;
        } else {
            return false;
        }
    }
    if([str isEqualToString:@"+"])
        return false;
    if([str isEqualToString:@"−"])
        return false;
    return true;
}

- (NSString*)cal {
    @try{
        NSString *string = [_formula.text stringByAppendingString:@"#"];
        NSString *temp;
        NSString *tempNum = @"";
        NSMutableArray *numStack = [[NSMutableArray alloc]init];
        NSMutableArray *priStack = [[NSMutableArray alloc]init];
        while ([string length] != 0) {
            temp = [string substringWithRange:NSMakeRange(0, 1)];
            string = [string substringFromIndex:1];
            
            if ([temp isEqualToString:@"+"] || [temp isEqualToString:@"−"] || [temp isEqualToString:@"×"] || [temp isEqualToString:@"÷"] || [temp isEqualToString:@"%"] || [temp isEqualToString:@"("] || [temp isEqualToString:@")"] || [temp isEqualToString:@"#"]) {
                if (![tempNum isEqualToString:@""]) {
                    NSNumber *num = [NSNumber numberWithDouble:[tempNum doubleValue]];
                    [numStack addObject:num];
                    tempNum = @"";
                }
                while (![self compare:temp :priStack]) {
                    if([numStack count] == 0)   @throw [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
                    double a = [[numStack lastObject] doubleValue];
                    [numStack removeLastObject];
                    if([numStack count] == 0)   @throw [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
                    double b = [[numStack lastObject] doubleValue];
                    [numStack removeLastObject];
                    if([priStack count] == 0)   @throw [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
                    NSString *ope = [priStack lastObject];
                    [priStack removeLastObject];
                    double result;
                    if([ope isEqualToString:@"+"]){
                        result = b + a;
                        [numStack addObject:[NSNumber numberWithDouble:result]];
                    }
                    if([ope isEqualToString:@"−"]){
                        result = b - a;
                        [numStack addObject:[NSNumber numberWithDouble:result]];
                    }
                    if([ope isEqualToString:@"×"]){
                        result = b * a;
                        [numStack addObject:[NSNumber numberWithDouble:result]];
                    }
                    if([ope isEqualToString:@"÷"]){
                        result = b / a;
                        [numStack addObject:[NSNumber numberWithDouble:result]];
                    }
                    if([ope isEqualToString:@"%"]){
                        result = fmod(b, a);
                        [numStack addObject:[NSNumber numberWithDouble:result]];
                    }
                }
                if (![temp isEqualToString:@"#"]) {
                    [priStack addObject:temp];
                    if ([temp isEqualToString:@")"]) {
                        [priStack removeLastObject];
                        [priStack removeLastObject];
                    }
                }
            } else {
                tempNum = [tempNum stringByAppendingString:temp];
            }
        }
        if([priStack count] > 0) @throw [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
        if([numStack count] > 1) @throw [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
        return [self formatNumStr:[numStack lastObject]];
    }@catch(NSException* e){
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"输入格式错误！" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil] show];
        return @"";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action_mc:(id)sender {
    M = 0;
}

- (IBAction)action_mPlus:(id)sender {
    NSString *resultStr = [self cal];
    if (![resultStr isEqualToString:@""]) {
        M += [resultStr doubleValue];
        _formula.text = [self formatNumStr:[NSString stringWithFormat:@"%f",M]];
    }
}

- (IBAction)action_mMinus:(id)sender {
    NSString *resultStr = [self cal];
    if (![resultStr isEqualToString:@""]) {
        M -= [resultStr doubleValue];
        _formula.text = [self formatNumStr:[NSString stringWithFormat:@"%f",M]];
    }
}

- (IBAction)action_mr:(id)sender {
    _formula.text = [self formatNumStr:[NSString stringWithFormat:@"%f",M]];
}

- (IBAction)action_del:(id)sender {
    if([_formula.text length]>=1)
        _formula.text = [_formula.text substringToIndex:[_formula.text length]-1];
}

- (IBAction)action_leftB:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"("];
}

- (IBAction)action_rightB:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@")"];
}

- (IBAction)action_complementation:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"%"];
}

- (IBAction)action_ac:(id)sender {
    _formula.text = @"";
}

- (IBAction)action_division:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"÷"];
}

- (IBAction)action_multiplication:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"×"];
}

- (IBAction)action_minus:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"−"];
}

- (IBAction)action_7:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"7"];
}

- (IBAction)action_8:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"8"];
}

- (IBAction)action_9:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"9"];
}

- (IBAction)action_plus:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"+"];
}

- (IBAction)action_4:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"4"];
}

- (IBAction)action_5:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"5"];
}

- (IBAction)action_6:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"6"];
}

- (IBAction)action_plusminus:(id)sender {
    NSUInteger length = [_formula.text length];
    if(length >= 1 && [[_formula.text substringFromIndex:length-1] isEqualToString:@"+"]){
        _formula.text = [[_formula.text substringToIndex:length-1] stringByAppendingString:@"−"];
    }else if(length >= 1 && [[_formula.text substringFromIndex:length-1] isEqualToString:@"−"]){
        _formula.text = [[_formula.text substringToIndex:length-1] stringByAppendingString:@"+"];
    }
    else{
        _formula.text = [_formula.text stringByAppendingString:@"+"];
    }
}

- (IBAction)action_1:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"1"];
}

- (IBAction)action_2:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"2"];
}

- (IBAction)action_3:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"3"];
}

- (IBAction)action_cal:(id)sender {
    NSString *resultStr = [self cal];
    if (![resultStr isEqualToString:@""]) {
        _formula.text = [self cal];
    }
}

- (IBAction)action_0:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"0"];
}

- (IBAction)action_point:(id)sender {
    _formula.text = [_formula.text stringByAppendingString:@"."];
}
@end
