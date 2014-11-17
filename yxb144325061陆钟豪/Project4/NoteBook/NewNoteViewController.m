//
//  NewNoteViewController.m
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/15.
//  Copyright (c) 2014年 lzh. All rights reserved.
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
    // Do any additional setup after loading the view.
    _noteDAO = [NoteDAO new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveNote:(id)sender {
    NoteEntity *newNote = [[NoteEntity alloc] initWithType:WordNote andContent:[self.noteContentTextView text]];
    [_noteDAO insertNote:newNote];
    [self.navigationController popViewControllerAnimated:true];
}

@end
