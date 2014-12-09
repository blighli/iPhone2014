//
//  ViewController.h
//  Calculator
//
//  Created by SXD on 14/11/10.
//  Copyright (c) 2014年 SXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *work;

@property (weak, nonatomic) IBOutlet UILabel *xNumber;
@property (weak, nonatomic) IBOutlet UILabel *aNumber;
@property (weak, nonatomic) IBOutlet UILabel *bNumber;
@end