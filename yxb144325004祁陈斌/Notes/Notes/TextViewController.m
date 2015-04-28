//
//  TextViewController.m
//  Notes
//
//  Created by xsdlr on 14/11/17.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "TextViewController.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "ViewController.h"
#import "Note.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    ViewController *nodesListView = (ViewController *)self.delegate;
    if (self.noteIndex != nil) {
        Note* note = [nodesListView.notes objectAtIndex:[self.noteIndex integerValue]];
        self.textView.text = note.message;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(UIBarButtonItem *)sender {
    Note* note;
    ViewController *notesListView = (ViewController *)self.delegate;
    if (self.noteIndex != nil) {
        note = [notesListView.notes objectAtIndex:[self.noteIndex integerValue]];
    } else {
        note = [Note MR_createEntity];
        [notesListView.notes insertObject:note atIndex:0];
    }
    note.type = Note.TEXT_TYPE;
    note.time = [NSDate new];
    note.message = self.textView.text;
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
