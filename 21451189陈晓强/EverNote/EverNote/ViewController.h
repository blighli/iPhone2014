//
//  ViewController.h
//  EverNote
//
//  Created by 陈晓强 on 14/11/28.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;



- (IBAction)backgroundTap:(id)sender;
@end

