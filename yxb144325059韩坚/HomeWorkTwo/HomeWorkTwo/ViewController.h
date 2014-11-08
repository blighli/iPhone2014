//
//  ViewController.h
//  HomeWorkTwo
//
//  Created by HJ on 14/11/3.
//  Copyright (c) 2014年 HJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormulaStringCalcUtility.h"
#import "RegexKitLite.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;

- (void) senMclickwithBlock: (void(^)()) myblock and:(UIButton *) sender;
- (void)senbtclickwithBlock: (void(^)()) myblock and:(UIButton *) sender;
- (BOOL)stringToCaculator;

//数字键
- (IBAction)clickDigit:(UIButton *)sender;
//点
- (IBAction)clickPoint:(UIButton *)sender;
//退格
- (IBAction)clickDelete:(UIButton *)sender;
//等于
- (IBAction)clickEqual:(UIButton *)sender;
//加号
- (IBAction)clickAdd:(UIButton *)sender;
//减号
- (IBAction)clickMinus:(UIButton *)sender;
//乘以
- (IBAction)clickMultiply:(UIButton *)sender;
//除以
- (IBAction)clickDivide:(UIButton *)sender;
//AC
- (IBAction)clickAC:(UIButton *)sender;
//'('
- (IBAction)clickLeftParet:(UIButton *)sender;
//')'
- (IBAction)clickRightParet:(UIButton *)sender;
//"%"
- (IBAction)clickRemain:(UIButton *)sender;
//mc
- (IBAction)clickMc:(UIButton *)sender;
//m+
- (IBAction)clickMadd:(UIButton *)sender;
//m-
- (IBAction)clickMminus:(UIButton *)sender;
//mr
- (IBAction)clickMresult:(UIButton *)sender;
@end

