//
//  NoteViewController.h
//  MyNotes
//
//  Created by tanglie on 14/11/22.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *content;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)tabBackground:(id)sender;

- (IBAction)addContent:(id)sender;
@end
