//
//  AddNoteViewController.m
//  Mynotes
//
//  Created by xiaoo_gan on 11/29/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "AddNoteViewController.h"
#import "NoteDataSource.h"
#import "NoteData.h"

@interface AddNoteViewController ()

@end

@implementation AddNoteViewController
@synthesize titleLabel = _titleLabel;
@synthesize noteTitle = _noteTitle;
@synthesize noteLabelsLabel = _noteLabelsLabel;
@synthesize noteLabels = _noteLabels;
@synthesize noteContent = _noteContent;
@synthesize noteScrollView = _noteScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:243.0/255 green:243.0/255 blue:243.0/255 alpha:1]; // light light gray
    
    self.noteTitle.delegate = self;
    self.noteLabels.delegate = self;
    self.noteContent.delegate = self;
    
    [self.noteTitle becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidUnload
{
    [self setNoteScrollView:nil];
    [self setTitleLabel:nil];
    [self setNoteTitle:nil];
    [self setNoteLabelsLabel:nil];
    [self setNoteLabels:nil];
    [self setNoteContent:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^(void) {}];
}

- (IBAction)onDone:(id)sender {
    if ([self.noteTitle.text isEqualToString:@""]) {
        UIAlertView *no_title = [[UIAlertView alloc] initWithTitle:@"Title Invalid" message:@"You Should at least offer a title name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [no_title show];
        return;
    }
    
    // save
    NoteData *new_note = [[NoteData alloc] init];
    new_note.title = self.noteTitle.text;
    new_note.labels = [self.noteLabels.text componentsSeparatedByString:@","];
    new_note.date = [NSDate date];
    new_note.content = self.noteContent.text;
    [[NoteDataSource sharedInstance] addNote:new_note];
    
    
    // dismiss
    [self dismissViewControllerAnimated:YES completion:^(void) {}];
}

#pragma mark - textfield & textview delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.noteTitle) {
        [self.noteLabels becomeFirstResponder];
    } else if (textField == self.noteLabels) {
        [self.noteContent becomeFirstResponder];
    } else {
        
    }
    return NO;
}

#pragma mark - autoresize with keyboard

- (void)keyboardWasShown:(NSNotification*)noti
{
    NSDictionary* info = [noti userInfo];
    CGSize keyboard_size = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGRect new_frame = self.noteScrollView.frame;
    new_frame.origin.y = 44; // navigationbar.height
    new_frame.size.height = 460 - keyboard_size.height; // 480 - 20 (statusbar.height) = 460
    self.noteScrollView.frame = new_frame;
}

- (void)keyboardWillBeHidden:(NSNotification*)noti
{
    self.noteScrollView.frame = self.view.frame;
}

@end
