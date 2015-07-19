//
//  AddNoteViewController.h
//  Mynotes
//
//  Created by xiaoo_gan on 11/29/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNoteViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *noteTitle;
@property (weak, nonatomic) IBOutlet UILabel *noteLabelsLabel;
@property (weak, nonatomic) IBOutlet UITextField *noteLabels;
@property (weak, nonatomic) IBOutlet UITextView *noteContent;
@property (weak, nonatomic) IBOutlet UIScrollView *noteScrollView;

- (IBAction)onCancel:(id)sender;
- (IBAction)onDone:(id)sender;
@end
