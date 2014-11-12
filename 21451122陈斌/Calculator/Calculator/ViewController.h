//
//  ViewController.h
//  Calculator
//
//  Created by lqynydyxf on 14/11/5.
//  Copyright (c) 2014年 lqynydyxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *text;


- (IBAction)ClickNum:(UIButton *)sender;

- (IBAction)ClickOperator:(UIButton *)sender;

- (IBAction)Clear;
@end

