//
//  ViewController.h
//  Calculator
//
//  Created by tanglie1993 on 14/11/9.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  ViewController : UIViewController
-(IBAction)adjustRestoredData:(UIButton *)sender;
-(IBAction)Calculator:(UIButton *)sender;
-(IBAction)deleteandClean:(UIButton *)sender;
-(IBAction)inputButtons:(UIButton *)sender;
-(IBAction)brackets:(UIButton *)sender;
-(int)calculatorPriority:(char)sender;
@property(nonatomic,strong) IBOutlet UITextField *textField;
-(IBAction) backgroundTap:(id)sender;




@end



