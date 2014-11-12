//
//  CalculatorViewController.h
//  Calculator
//
//  Created by JANESTAR on 14-11-5.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *display2;
@property (weak, nonatomic) IBOutlet UILabel *display3;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;

- (IBAction)compute:(UIButton *)sender;

- (IBAction)moper:(UIButton *)sender;

- (IBAction)judge:(UIButton*)sender;

- (IBAction)del;

- (IBAction)clear;

@end
