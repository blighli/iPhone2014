//
//  FirstViewController.h
//  translation
//
//  Created by Steve on 14-12-24.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface FirstViewController : UIViewController<UIAlertViewDelegate>
{
    sqlite3 *db;
    IBOutlet UITextView *TextView;
    IBOutlet UITextField *Word;
    NSString *word;
    NSString *translation;
    NSMutableData *receiveData;
    NSString *incoming;
    
    
}
-(IBAction)search;
-(IBAction)insert;




@end

