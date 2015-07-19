//
//  WriteViewController.h
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface WriteViewController : UIViewController<UITextViewDelegate>

{
    sqlite3 *noteDB;
    NSString *databasePath1;
}

- (IBAction)save:(id)sender;

@end
