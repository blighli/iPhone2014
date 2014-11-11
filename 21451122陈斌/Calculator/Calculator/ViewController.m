//
//  ViewController.m
//  Calculator
//
//  Created by lqynydyxf on 14/11/5.
//  Copyright (c) 2014年 lqynydyxf. All rights reserved.
//

#import "ViewController.h"
#import "Calculate.h"

@interface ViewController ()

@end

NSMutableArray *arrayNum ;
NSMutableArray *arrayOperator;
NSString *str = @"";
NSInteger point_clicked_times = 0;
NSDecimalNumber *result;
Calculate *cal;
NSString *op;
NSString *op_equal;
NSString *op_num;
NSString *m;
BOOL first_cal = FALSE;

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _text.text = @"0";
    arrayNum = [[NSMutableArray alloc] init];
    arrayOperator = [[NSMutableArray alloc] init];
    cal = [[Calculate alloc] init];
    result = [[NSDecimalNumber alloc] init];
    op = [[NSString alloc] init];
    op_equal = [[NSString alloc] init];
    op_num = [[NSString alloc] init];
    m = [[NSString alloc] initWithFormat:@"0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickNum:(UIButton *)sender {
    if ([_text.text  isEqual: @"0"]) {
        _text.text = @"";
    }
    if([[sender currentTitle] isEqual: @"."]){
        point_clicked_times++;
        if (point_clicked_times == 1) {
            str = [str stringByAppendingString:[sender currentTitle]];
        }else{
            str = [str stringByAppendingString:@""];
        }
    }else {
        str = [str stringByAppendingString:[sender currentTitle]];
    }
    _text.text = str;
}

- (IBAction)ClickOperator:(UIButton *)sender {
    NSString *num = _text.text;
    NSString *operator = [sender currentTitle];
    [arrayNum addObject :num];
    [arrayOperator addObject :operator];
    if ([arrayNum count] == 2 && [arrayOperator count] == 2) {
        result = [cal calculate:arrayOperator[0] :arrayNum];
        arrayOperator[0] = operator;
        [arrayOperator removeLastObject];
        arrayNum[0] = [result stringValue];
        [arrayNum removeLastObject];
        _text.text = [result stringValue];
    }
    first_cal = FALSE;
    str = @"";
    point_clicked_times = 0;
    op_equal = [arrayOperator objectAtIndex:0];
}
- (IBAction)ClickEqual {
    if (!first_cal) {
        if ([arrayNum count] == 0) {
            _text.text = str;
            [arrayNum addObject:str];
        }else{
            [arrayNum addObject:str];
            result = [cal calculate:op_equal :arrayNum];
            arrayNum[0] = [result stringValue];
            [arrayNum removeAllObjects];
            [arrayOperator removeAllObjects];
            _text.text = [result stringValue];
        }
    }
    first_cal = TRUE;
}

- (IBAction)Clear {
    _text.text = @"0";
    str = @"";
    [arrayNum removeAllObjects];
    [arrayOperator removeAllObjects];
    m = @"0";
}
- (IBAction)m_clear {
    m = @"0";
}
- (IBAction)m_read {
    _text.text = m;
    str = @"";
}
- (IBAction)m_plus {
    m = [[cal add:m :_text.text] stringValue];
}
- (IBAction)m_minus {
    m = [[cal minus:m :_text.text] stringValue];
}

@end
