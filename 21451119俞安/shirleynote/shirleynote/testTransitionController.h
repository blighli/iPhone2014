//
//  testTransitionController.h
//  evernote
//
//  Created by apple on 14/11/22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "noteViewController.h"

@interface testTransitionController : UIViewController
- (IBAction)savenote:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *head;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
