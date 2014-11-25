//
//  NoteViewController.h
//  Note
//
//  Created by Steve on 14-11-24.
//  Copyright (c) 2014年 Steve. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface NoteViewController: UIViewController
{
    sqlite3 *db;
    IBOutlet UITextView *TextView;
    IBOutlet UINavigationItem *ItemBar;
    IBOutlet UITextField *TextField;
    NSString *content;
    NSString *title;
    NSString *Sql;
}
-(IBAction)submit;

@end

