//
//  editNoteViewController.m
//  MyNotes
//
//  Created by 杨长湖 on 14/11/28.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import "editNoteViewController.h"

@interface editNoteViewController ()

@end

@implementation editNoteViewController
@synthesize editNoteTextView;
@synthesize editNote;

- (void)viewDidLoad {
    [super viewDidLoad];
    editNoteTextView.text = editNote.note;
    //editNoteTextView.text = editNote.time;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editNotUpdate:(id)sender {
    NoteDAO *dao = [[NoteDAO alloc]init];
    NSString *s = editNoteTextView.text;
    NSLog(@"%d---%@",editNote.ids,s);
    
    [dao updateNoteWithTime:editNote.ids note:s];
}
@end
