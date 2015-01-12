//
//  NoteDetailViewController.m
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
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
}

- (IBAction)modifyNote:(id)sender {
    self.noteEntity.content = self.noteContentTextView.text;
    [_noteDAO updateNote:self.noteEntity];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
