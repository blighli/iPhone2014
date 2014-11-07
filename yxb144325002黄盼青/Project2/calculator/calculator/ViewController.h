//
//  ViewController.h
//  calculator
//
//  Created by 黄盼青 on 14/11/4.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *displayScreen;

- (IBAction)btnCal:(UIButton *)sender;

@end

