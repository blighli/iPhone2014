//
//  TextViewController.h
//  MyNote
//
//  Created by 蔡飞跃 on 14/11/15.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface TextViewController : UIViewController
{
    
    UITextField *text_title;
    UITextView *text_note;
    sqlite3 *textDB;
    //UILabel *status;
    NSString *databasePath;
}
@property (retain, nonatomic) IBOutlet UITextField *text_title;
@property (retain, nonatomic) IBOutlet UITextView *text_note;

- (IBAction)backgroundTap:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)delete:(id)sender;


@end
