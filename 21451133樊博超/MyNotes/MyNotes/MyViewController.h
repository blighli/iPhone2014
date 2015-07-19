//
//  MyViewController.h
//  MyNotes
//
//  Created by 樊博超 on 14-11-21.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
@class NoteData;
@interface MyViewController : UIViewController <UIApplicationDelegate>
{
    UIButton *clear;
    UIButton *save;
    UITextField *textNameView;
    UITextView *contentView;
    Database *db;
}
@property(nonatomic, strong) NoteData *item;
-(IBAction)clearText:(id)sender;
-(IBAction)saveText:(id)sender;
@end
