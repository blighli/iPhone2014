//
//  ViewController.h
//  Calculator
//
//  Created by Chencheng on 14/11/4.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  ViewController : UIViewController
-(IBAction)memoryAccess:(UIButton *)sender;
-(IBAction)Calculator:(UIButton *)sender;
-(IBAction)deleteandClean:(UIButton *)sender;
-(IBAction)numberandPoint:(UIButton *)sender;
-(IBAction)brackets:(UIButton *)sender;
-(int)calculatorPriority:(char)sender;
@property(nonatomic,strong) IBOutlet UITextField *textField;
-(IBAction) backgroundTap:(id)sender;




@end



