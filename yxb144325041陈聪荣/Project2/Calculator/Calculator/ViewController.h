//
//  ViewController.h
//  Calculator
//
//  Created by 陈聪荣 on 14/11/4.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textfield;
- (IBAction)mcClick:(id)sender;
- (IBAction)mPlusClick:(id)sender;
- (IBAction)mSubClick:(id)sender;
- (IBAction)mrClick:(id)sender;
- (IBAction)delClick:(id)sender;
- (IBAction)acClick:(id)sender;
- (IBAction)sevenClick:(id)sender;

@end

