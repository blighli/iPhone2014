//
//  NewNoteViewController.m
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import "NewNoteViewController.h"
#import "NoteEntity.h"
#import "NoteDAO.h"

@interface NewNoteViewController ()

@end

@implementation NewNoteViewController
{
    NoteDAO* _noteDAO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _noteDAO = [NoteDAO new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveNote:(id)sender {
    NoteEntity *newNote = [[NoteEntity alloc] initWithType:WordNote andContent:[self.noteContentTextView text]];
    [_noteDAO insertNote:newNote];
    [self.navigationController popViewControllerAnimated:true];
}

@end
