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



- (IBAction)btn0:(id)sender;
- (IBAction)btn1:(id)sender;
- (IBAction)btn2:(id)sender;
- (IBAction)btn3:(id)sender;
- (IBAction)btn4:(id)sender;
- (IBAction)btn5:(id)sender;
- (IBAction)btn6:(id)sender;
- (IBAction)btn7:(id)sender;
- (IBAction)btn8:(id)sender;
- (IBAction)btn9:(id)sender;

- (IBAction)btnDot:(id)sender;

-(IBAction)btnLbrace:(id)sender;
-(IBAction)btnRbrace:(id)sender;

- (IBAction)btnEqual:(id)sender;
- (IBAction)btnPlus:(id)sender;
- (IBAction)btnMinus:(id)sender;
- (IBAction)btnMultiply:(id)sender;
- (IBAction)btnDivide:(id)sender;

- (IBAction)btnSgn:(id)sender;
- (IBAction)btnPercent:(id)sender;


- (IBAction)btnClear:(id)sender;
- (IBAction)btnDelete:(id)sender;

- (IBAction)btnMemoryClear:(id)sender;
- (IBAction)btnMemoryAdd:(id)sender;
- (IBAction)btnMemoryMinus:(id)sender;
- (IBAction)btnMemoryRead:(id)sender;



@end

