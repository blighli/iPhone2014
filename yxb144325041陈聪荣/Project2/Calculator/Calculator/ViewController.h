//
//  ViewController.h
//  Calculator
//
//  Created by 陈聪荣 on 14/11/4.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"

@interface ViewController : UIViewController

@property (nonatomic , strong) Calculator *calculator;
@property (weak, nonatomic) IBOutlet UITextField *resultText;
- (IBAction)singleStepOperation:(id)sender;
- (IBAction)multiStepOperation:(id)sender;
- (IBAction)calculation:(id)sender;

@end

