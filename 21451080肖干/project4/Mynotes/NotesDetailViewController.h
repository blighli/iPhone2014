//
//  NotesDetailViewController.h
//  Notes
//
//  Created by xiaoo_gan on 11/25/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.//

#import <UIKit/UIKit.h>

@class NoteData;

@interface NotesDetailViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *noteTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *noteTitle;
@property (weak, nonatomic) IBOutlet UILabel *noteLabelsLabel;
@property (weak, nonatomic) IBOutlet UITextField *noteLabels;
@property (weak, nonatomic) IBOutlet UITextView *noteContent;

@property (weak, nonatomic) IBOutlet UIScrollView *noteScrollView;

@property (strong, nonatomic) NoteData *note;
- (IBAction)onModify:(id)sender;

@end
