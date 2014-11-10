//
//  ViewController.m
//  calculatorTest
//
//  Created by 杨长湖 on 14/11/7.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize calOutlet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    showNumber = @"";
    inputNumber = 0;
    resultNumber = 0;
    number = 0;
    dot_Sign = NO;
    dot_length = 0;
    operators = -1;
    operator_Sign = 0;
    resultOutPut_Sign = NO;
    M=0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//数字
- (IBAction)numberButtenTouch:(UIButton *)sender {
    UIButton *numberButten = (UIButton *)sender;
    int num =[[numberButten currentTitle]integerValue];
    NSString *num_S = [NSString stringWithFormat:@"%d",num];
    
    if (resultOutPut_Sign == YES) {
        resultOutPut_Sign =NO;
        resultNumber = 0;
        inputNumber = 0;
        showNumber = @"";
        //operators = -1;
        //operator_Sign = 0;
    }
    
    if ([showNumber length]>=16) {
        return;
    }
    else{
        if (dot_Sign == NO) {
            if (inputNumber == 0 && num ==0){
                //[calOutlet setText:@"0"];
                return;
            }else{
                inputNumber = inputNumber*10 + num;
                showNumber = [showNumber stringByAppendingString:num_S];
            }
        }
        else{
            dot_length++;
            inputNumber = inputNumber + pow(0.1, dot_length)*num;
            if (num == 0) {
                showNumber = [showNumber stringByAppendingString:@"0"];
            }
            else{
                showNumber = [showNumber stringByAppendingString:num_S];
                //showNumber = [self floatToString:inputNumber];
            }
        }
        //resultNumber = inputNumber;
        //printf("%.17f\n",inputNumber);
        [calOutlet setText:showNumber];
    }
    number = inputNumber;
}
//点
- (IBAction)dotButtenTouch:(UIButton *)sender {
    if (dot_Sign == NO) {
        dot_Sign = YES;
        if (inputNumber == 0) {
            showNumber = [showNumber stringByAppendingString:@"0."];
        }
        else{
            showNumber = [showNumber stringByAppendingString:@"."];
        }
        calOutlet.text = showNumber;
    }
}
//AC
- (IBAction)ACButtenTouch:(UIButton *)sender {
    inputNumber = 0;
    resultNumber = 0;
    dot_length = 0;
    dot_Sign = NO;
    showNumber = @"";
    operators = -1;
    operator_Sign = 0;
    calOutlet.text = @"0";
    resultOutPut_Sign = NO;
}

//运算符
- (IBAction)operatorButtenTouch:(UIButton *)sender {
    UIButton *operatorButten = (UIButton *)sender;
    NSString *operator = [[operatorButten titleLabel]text];
    
    NSArray *array=[NSArray arrayWithObjects: @"+",@"-",@"*",@"/",@"%",nil];
    int index=[array indexOfObject: operator];
    
    switch (index) {
        case 0:
            operators = 0;
            break;
        case 1:
            operators = 1;
            break;
        case 2:
            operators = 2;
            break;
        case 3:
            operators = 3;
            break;
        case 4:
            operators = 4;
            break;
    }
    if (operator_Sign == 0) {
        operator_Sign = 1;
        resultNumber = number;
    }
    else{
        [self calculate:operators];
    }
    inputNumber = 0;
    showNumber = @"";
}

//等于
- (IBAction)resultOutPut:(UIButton *)sender {
    if (operator_Sign != 0) {
        resultOutPut_Sign = YES;
        [self calculate:operators];
    }
}

- (IBAction)Madd:(UIButton *)sender {
    M += [showNumber doubleValue];
    [self M];
}

- (IBAction)Mmin:(UIButton *)sender {
    M -= [showNumber doubleValue];
    [self M];
}

- (IBAction)MC:(UIButton *)sender {
    M = 0;
    [self M];
}

- (IBAction)MR:(UIButton *)sender {
    [self M];
}
-(void) M{
    resultOutPut_Sign = YES;
    number = M;
    showNumber =[self floatToString:M];
    [calOutlet setText:showNumber];
}

//计算
- (void) calculate:(int)operators {
    switch (operators) {
        case 0:
            resultNumber +=number;
            break;
        case 1:
            resultNumber -=number;
            break;
        case 2:
            resultNumber *=number;
            break;
        case 3:
            if (number != 0) {
                resultNumber /=number;
            }
            break;
        case 4:
            resultNumber /=100;
            break;
    }
    showNumber = [self floatToString:resultNumber];
    [calOutlet setText:showNumber];
}

- (NSString *)floatToString:(double)number{
    //NSString *returnString = [NSString stringWithFormat:@"%.16f",number];
    NSString *returnString = [[NSNumber numberWithDouble:number]stringValue];
    return returnString;
}

@end
