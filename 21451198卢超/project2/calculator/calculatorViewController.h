//
//  calculatorViewController.h
//  calculator
//
//  Created by ___FULLUSERNAME___ on 14-11-4.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calculatorViewController : UIViewController
@property(weak,nonatomic) IBOutlet UILabel *showExpression;
@property(weak,nonatomic) IBOutlet UILabel *showResult;

- (IBAction)MClear:(UIButton *)sender;
- (IBAction)MPlus:(UIButton *)sender;
- (IBAction)MMinus:(UIButton *)sender;
- (IBAction)MRead:(UIButton *)sender;
- (IBAction)Delete:(UIButton *)sender;
- (IBAction)operate:(UIButton *)sender;
- (IBAction)negtive:(UIButton *)sender;
- (IBAction)percent:(UIButton *)sender;
- (IBAction)equal:(UIButton *)sender;
- (IBAction)digit:(UIButton *)sender;

@end
