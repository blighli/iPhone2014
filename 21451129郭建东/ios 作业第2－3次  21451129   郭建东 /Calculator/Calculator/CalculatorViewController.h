//
//  CalculatorViewController.h
//  Calculator
//
//  Created by GUO on 14-11-05.
//  Copyright (c) 2014年 GUO
//

#import <UIKit/UIKit.h>


@interface CalculatorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *totalResultLabel;
@property (weak, nonatomic) IBOutlet UITextField *resultText;


- (IBAction)tapAction:(UIButton *)sender;

@end
