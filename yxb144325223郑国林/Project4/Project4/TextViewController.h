//
//  TextViewController.h
//  Project4
//
//  Created by CST-112 on 14-11-19.
//  Copyright (c) 2014年 CST-112. All rights reserved.

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface TextViewController : UIViewController
{
    sqlite3 *database;
}
- (IBAction)textFiledDoneEditing:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *titleName;
@property (strong, nonatomic) UITextView *TextView;
- (IBAction)save:(id)sender;
- (IBAction)load:(id)sender;
- (void)timerFireMethod:(NSTimer*)theTimer;
- (void)showAlert:(NSString *) _message;


@end
