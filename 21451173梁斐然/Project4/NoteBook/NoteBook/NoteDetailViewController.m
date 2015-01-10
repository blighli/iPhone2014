//
//  NoteDetailViewController.m
//  NoteBook
//
//  Created by LFR on 14/11/16.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "NoteDAO.h"

@interface NoteDetailViewController ()
{
    NoteDAO *_noteDAO;
}

@end

@implementation NoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _noteDAO = [NoteDAO new];
    self.noteContentTextView.text = self.noteEntity.content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)modifyNote:(id)sender {
    self.noteEntity.content = self.noteContentTextView.text;
    [_noteDAO updateNote:self.noteEntity];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
