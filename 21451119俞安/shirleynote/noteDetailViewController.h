//
//  noteDetailViewController.h
//  evernote
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "noteViewController.h"



@interface noteDetailViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *head;

//@property(nonatomic,assign) NSObject<PassValueDelegate> *delegate;

- (IBAction)save:(id)sender;

@end
