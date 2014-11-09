//
//  ViewController.h
//  Calculator
//
//  Created by xiaoo_gan on 11/5/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorMain.h"
@interface ViewController : UIViewController {
    @private
    BOOL isTypeNumber;        //标记是否正在输入数值,防止连续输入两个操作符
    BOOL isAnswered;          
}

@property (weak, nonatomic) IBOutlet UIButton *backgroudChange;
@property (weak, nonatomic) IBOutlet UILabel *display;          //显示在屏幕上的运算表达式
@property (weak, nonatomic) IBOutlet UILabel *currentNumber;    //纪录当前输入的数值
- (IBAction)digitPressed:(UIButton *)sender;    //0 1 2 3 4 5 6 7 8 9 .
- (IBAction)mPressed:(UIButton *)sender;        //MC M+ M- MR ⌫ AC
- (IBAction)operationPressed:(UIButton *)sender;//( ) % ÷ × - + ±
- (IBAction)enterPressed:(UIButton *)sender;
- (IBAction)percentagePressed:(UIButton *)sender;



@end

