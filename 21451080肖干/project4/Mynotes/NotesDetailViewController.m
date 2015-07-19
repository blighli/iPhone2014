//
//  NotesDetailViewController.m
//  Notes
//
//  Created by xiaoo_gan on 11/25/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "NotesDetailViewController.h"
#import "NoteData.h"

@interface NotesDetailViewController ()
@end

@implementation NotesDetailViewController

@synthesize noteTitleLabel = _noteTitleLabel;
@synthesize noteTitle = _noteTitle;
@synthesize noteLabelsLabel = _noteLabelsLabel;
@synthesize noteLabels = _noteLabels;
@synthesize noteContent = _noteContent;
@synthesize noteScrollView = _noteScrollView;
@synthesize note = _note;

#pragma mark - Managing the detail item

- (void)setNote:(NoteData *)note
{
    if (_note != note) {
        _note = note;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置背景色
    self.view.backgroundColor = [UIColor colorWithRed:243.0/255 green:243.0/255 blue:243.0/255 alpha:1];
    
    // 初始化note
    if (self.note) {
        self.navigationItem.title = self.note.title;
        self.noteTitle.text = self.note.title;
        self.noteLabels.text = [self.note labelsString];
        self.noteContent.text = self.note.content;
    } else {
        NSLog(@"NotesDetailViewController::viewDidLoad -- invalid note, nil value");
    }
    self.noteTitle.delegate = self;
    self.noteLabels.delegate = self;
    self.noteContent.delegate = self;
}

- (void)viewDidUnload
{
    [self setNoteTitleLabel:nil];
    [self setNoteTitle:nil];
    [self setNoteLabelsLabel:nil];
    [self setNoteLabels:nil];
    [self setNoteContent:nil];
    [self setNoteScrollView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}

#pragma mark - textfield & textview delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.noteTitle) {
        [self.noteLabels becomeFirstResponder];
    } else if (textField == self.noteLabels) {
        [self.noteContent becomeFirstResponder];
    } else  {
        
    }
    return NO;
}

#pragma mark - actions

- (IBAction)onModify:(id)sender {
    
    //判断title是否为空
    if ([self.noteTitle.text isEqualToString:@""]) {
        UIAlertView *isNoTitle = [[UIAlertView alloc] initWithTitle:@"Title Invalid" message:@"You Should at least offer a title name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [isNoTitle show];
        return;
    }

    // 保存修改
    self.navigationItem.title = self.noteTitle.text;
    self.note.title = self.noteTitle.text;
    self.note.labels = [self.noteLabels.text componentsSeparatedByString:@","];
    self.note.content = self.noteContent.text;
    
    //关掉虚拟键盘
    if ([self.noteTitle isFirstResponder]) {
        [self.noteTitle resignFirstResponder];
    } else if ([self.noteLabels isFirstResponder]) {
        [self.noteLabels resignFirstResponder];
    } else if ([self.noteContent isFirstResponder]) {
        [self.noteContent resignFirstResponder];
    }
    
    //修改完成后，返回
    [self.navigationController popViewControllerAnimated:YES];
}
@end
