//
//  EditNoteViewController.m
//  AnyNote
//
//  Created by 黄盼青 on 14/11/18.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "EditNoteViewController.h"

@interface EditNoteViewController ()

@end

@implementation EditNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    ViewController *mainView=(ViewController *)_delegate;
    NoteData *note=[mainView.noteData objectAtIndex:_currentNote.row];
    _textView.text=note.contents;
    
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

- (IBAction)saveEditNote:(id)sender {
    ViewController *mainView=(ViewController *)_delegate;
    
    NoteData *note=mainView.noteData[_currentNote.row];
    
    note.contents=_textView.text;
    note.date=[NSDate date];
    
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [mainView.tableView reloadData];
}

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
