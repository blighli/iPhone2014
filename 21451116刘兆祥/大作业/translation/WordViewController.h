//
//  WordViewController.h
//  translation
//
//  Created by Steve on 14-12-27.
//  Copyright (c) 2014年 Steve. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"

@interface WordViewController : UIViewController
{
    sqlite3 *db;
    IBOutlet UITextView *TextView;
    NSString *word;
    NSString *meaning;
}

@end