//
//  TextEditViewController.h
//  MyNotes
//
//  Created by 焦守杰 on 14/11/14.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "DatabaseUtil.h"
@interface TextEditViewController : UIViewController
- (IBAction)clickSaveButton:(id)sender;
- (IBAction)clickCancelButton:(id)sender;
@property (strong,nonatomic)DatabaseUtil *dbu;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
