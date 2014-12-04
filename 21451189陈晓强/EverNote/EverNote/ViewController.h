//
//  ViewController.h
//  EverNote
//
//  Created by 陈晓强 on 14/11/28.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong ,nonatomic) NSString *myTitle;
@property (strong, nonatomic) NSAttributedString *myAttributedString;
- (IBAction)backgroundTap:(id)sender;
@end

