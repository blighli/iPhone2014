//
//  TextViewController.h
//  Project3
//
//  Created by  sephiroth on 14/11/19.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface TextViewController : UIViewController
{
    sqlite3 *database;
}
- (IBAction)textFiledDoneEditing:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *titleName;
@property (weak, nonatomic) IBOutlet UITextView *TextView;
- (IBAction)save:(id)sender;
- (IBAction)load:(id)sender;


@end
