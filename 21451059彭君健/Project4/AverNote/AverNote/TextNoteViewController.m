//
//  TextNoteViewController.m
//  AverNote
//
//  Created by Mz on 14-11-21.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "TextNoteViewController.h"
#import "ViewController.h"
#import "Note.h"
@interface TextNoteViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) BOOL isEditing;
@end

@implementation TextNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.currentNote != nil) {
        self.textView.text = self.currentNote.content;
        self.isEditing = YES;
    } else {
        self.isEditing = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveTextNote:(id)sender {
    NSLog(@"Saving Text Note...");
    if (self.isEditing) {
        self.currentNote.content = self.textView.text;
    } else {
        Note *note = [Note MR_createEntity];
        note.date = [NSDate date];
        note.content = self.textView.text;
        note.type = [NSNumber numberWithInt:NoteTypeText];
        [self.mainView.notes insertObject:note atIndex:0];
    }
    [self.mainView.noteTable reloadData];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
