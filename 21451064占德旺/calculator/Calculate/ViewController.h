//
//  ViewController.h
//  Calculate
//
//  Created by Devon on 14/11/6.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>

#define opCear          10
#define opDel           11
#define opDivide        12
#define opMultiply      13
#define opPlus          14
#define opMinus         15
#define opEqual         16
#define opLeftBracket   17
#define opRightBracket  18
#define opDot           19
#define opMemoryPlus    20
#define opMemoryMinus   21
#define opMemoryRead    22
#define opMemoryClear   23
#define opMod           24
#define opNegative      25

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *expressionText;
@property (weak, nonatomic) IBOutlet UITextField *resultText;

- (IBAction)tapAction:(UIButton *)sender;

@end

