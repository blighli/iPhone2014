//
//  ViewController.h
//  calculator
//
//  Created by Van on 14/11/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property NSMutableString *expression;
@property BOOL state;
@property NSString *lastReuslt;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *clearAllBtn;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;

- (IBAction)GetResult:(id)sender;
- (IBAction)buttonTap:(id)sender;
- (IBAction)mBtnTap:(id)sender;
@end

