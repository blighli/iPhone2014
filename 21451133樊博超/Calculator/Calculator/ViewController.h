//
//  ViewController.h
//  Calculator
//
//  Created by 樊博超 on 14-11-7.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (void)setnum:(NSString *)num;

@property (weak, nonatomic) IBOutlet UILabel *Printer;
- (IBAction)MCButton:(UIButton *)sender;
- (IBAction)MPlusButton:(UIButton *)sender;
- (IBAction)MMinusButton:(UIButton *)sender;
- (IBAction)MRButton:(UIButton *)sender;
- (IBAction)deleteButton:(UIButton *)sender;
- (IBAction)leftBrackets:(UIButton *)sender;
- (IBAction)rightBrackets:(UIButton *)sender;
- (IBAction)modButton:(UIButton *)sender;
- (IBAction)ACButton:(UIButton *)sender;
- (IBAction)divide:(UIButton *)sender;
- (IBAction)multi:(UIButton *)sender;
- (IBAction)plus:(UIButton *)sender;
- (IBAction)sevenButton:(UIButton *)sender;
- (IBAction)eightButton:(UIButton *)sender;
- (IBAction)nineButton:(UIButton *)sender;
- (IBAction)minus:(UIButton *)sender;
- (IBAction)fourButton:(UIButton *)sender;
- (IBAction)fiveButton:(UIButton *)sender;
- (IBAction)sixButton:(UIButton *)sender;
- (IBAction)posOrNeg:(UIButton *)sender;
- (IBAction)oneButton:(UIButton *)sender;
- (IBAction)twoButton:(UIButton *)sender;
- (IBAction)threeButton:(UIButton *)sender;
- (IBAction)zeroButton:(UIButton *)sender;
- (IBAction)pointButton:(UIButton *)sender;
- (IBAction)equalButton:(UIButton *)sender;

-(void)pushStack:(NSString*)opstr;
-(double)calc:(double)num1 :(double)num2 :(NSString *)oper;

@end

