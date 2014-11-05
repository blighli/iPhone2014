//
//  ViewController.h
//  calc
//
//  Created by zhou on 14/11/3.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *consoleText;      // 显示实时输入屏幕
@property (weak, nonatomic) IBOutlet UILabel *expText;          // 显示历史输入算式
@property (weak, nonatomic) IBOutlet UILabel *mFlag;            // 寄存器标志



- (IBAction)btn0OnTouch:(id)sender;
- (IBAction)btn1OnTouch:(id)sender;
- (IBAction)btn2OnTouch:(id)sender;
- (IBAction)btn3OnTouch:(id)sender;
- (IBAction)btn4OnTouch:(id)sender;
- (IBAction)btn5OnTouch:(id)sender;
- (IBAction)btn6OnTouch:(id)sender;
- (IBAction)btn7OnTouch:(id)sender;
- (IBAction)btn8OnTouch:(id)sender;
- (IBAction)btn9OnTouch:(id)sender;

- (IBAction)btnDotOnTouch:(id)sender;

- (IBAction)btnEqualOnTouch:(id)sender;
- (IBAction)btnPlusOnTouch:(id)sender;
- (IBAction)btnMinusOnTouch:(id)sender;
- (IBAction)btnMultiplyOnTouch:(id)sender;
- (IBAction)btnDivideOnTouch:(id)sender;

- (IBAction)btnSgnOnTouch:(id)sender;
- (IBAction)btnPercentOnTouch:(id)sender;


- (IBAction)btnClearOnTouch:(id)sender;
- (IBAction)btnDeleteOnTouch:(id)sender;

- (IBAction)btnMemoryClearOnTouch:(id)sender;
- (IBAction)btnMemoryWriteOnTouch:(id)sender;
- (IBAction)btnMemoryReadOnTouch:(id)sender;



@end

