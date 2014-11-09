//
//  ViewController.m
//  calculator
//
//  Created by Van on 14/11/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "ViewController.h"
#import "InfixToPostfix.h"
#import "PostfixCalculator.h"

@interface ViewController ()
@property int NumNow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.state = NO;
    self.resultLabel.text = @"0";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonTap:(id)sender {
    if (self.expression == nil) {
        self.expression =[[NSMutableString alloc] init];
        self.NumNow = 0;
    }
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
            [self.expression appendString:@"1"];
            self.NumNow = 1;
            break;
        case 2:
            [self.expression appendString:@"2"];
            self.NumNow = 2;
            break;
        case 3:
            [self.expression appendString:@"3"];
            self.NumNow = 3;
            break;
        case 4:
            [self.expression appendString:@"4"];
            self.NumNow = 4;
            break;
        case 5:
            [self.expression appendString:@"5"];
            self.NumNow = 5;
            break;
        case 6:
            [self.expression appendString:@"6"];
            self.NumNow = 6;
            break;
        case 7:
            [self.expression appendString:@"7"];
            self.NumNow = 7;
            break;
        case 8:
            [self.expression appendString:@"8"];
            self.NumNow = 8;
            break;
        case 9:
           [self.expression appendString:@"9"];
            self.NumNow = 9;
            self.resultLabel.text = @"9";
            break;
        case 10:
            [self.expression appendString:@"."];
            break;
        case 11://AC
            NSLog(@"sd %lu",self.expression.length);
            [self.expression setString:@""];
            break;
        case 12:
            [self.expression appendString:@"/"];
            break;
        case 13:
            [self.expression appendString:@"*"];
            break;
        case 14:
            [self.expression appendString:@"-"];
            break;
        case 15:
            [self.expression appendString:@"+"];
            break;
        case 16://<
             [self.expression deleteCharactersInRange:NSMakeRange(self.expression.length-1, 1)];
            break;
        case 17:
            [self.expression appendString:@"("];
            break;
        case 18:
            [self.expression appendString:@")"];
            break;
        case 19://mod
            break;
        case 20:
            if (self.state) {
                
            }else{
                
            }
            break;
        default:
            break;
            
    }
    NSLog(@"expree is %@",self.expression);
}

- (IBAction)mBtnTap:(id)sender {
    UIButton *mbtn = (UIButton *)sender;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    switch (mbtn.tag) {
        case 1:
            [userDefaults removeObjectForKey:@"m"];
            self.resultLabel.text = @"0";
            self.expression = nil;
            break;
        case 2:
            [userDefaults setInteger:([userDefaults integerForKey:@"m"]+self.NumNow) forKey:@"m"];
            self.resultLabel.text =  [NSString stringWithFormat:@"%ld", (self.NumNow+[userDefaults integerForKey:@"m"])];

            [userDefaults synchronize];
            self.expression = [self.resultLabel.text mutableCopy];
            break;
        case 3:
            self.resultLabel.text =  [NSString stringWithFormat:@"%ld", (self.NumNow-[userDefaults integerForKey:@"m"])];
            [userDefaults setInteger:(self.NumNow-[userDefaults integerForKey:@"m"]) forKey:@"m"];
            [userDefaults synchronize];
            self.expression = [self.resultLabel.text mutableCopy];

            break;
        case 4:
            if ([userDefaults objectForKey:@"m"] !=nil ) {
                self.resultLabel.text = [userDefaults objectForKey:@"m"];
                self.expression = [self.resultLabel.text mutableCopy];
            }else{
                self.resultLabel.text = @"0";
                self.expression = nil;
            }

            break;
        default:
            break;
    }

}

- (IBAction)GetResult:(id)sender {
    InfixToPostfix *itp = [[InfixToPostfix alloc] init];
    NSString * result = [itp parseInfix:self.expression];
    NSLog(@"result is %@",result);
    if (result == nil) {
        NSLog(@"表达式有误");
    }else{
        PostfixCalculator *postfix = [[PostfixCalculator  alloc] init];
        NSDecimalNumber * result2 = [postfix compute:result];
        if (result2 == nil) {
            NSLog(@"表达式有误");
        }else{
            self.lastReuslt = [NSString stringWithFormat:@"%@", result2];
            self.expression = [[NSString stringWithFormat:@"%@", result2] mutableCopy];
        }
        NSLog(@"计算结果是 %@",[NSString stringWithFormat:@"%@", result2]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.resultLabel setText:[NSString stringWithFormat:@"%@", result2]];
            [self.resultLabel setNeedsDisplay];
        });
    }

}
@end
