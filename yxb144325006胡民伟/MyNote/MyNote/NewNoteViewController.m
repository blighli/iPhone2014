//
//  MainViewController.m
//  MyNote
//
//  Created by Cocoa on 14/11/20.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "NewNoteViewController.h"
#import "AppDelegate.h"

@interface NewNoteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) AppDelegate *appdelegate;
@property (strong, nonatomic) NSMutableArray *allNotes;
@end

@implementation NewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (IBAction)saveNote:(id)sender {
    Note *newNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.appdelegate.managedObjectContext];
    NSManagedObjectID *noteID = [newNote objectID];
    NSString *identifier=[noteID.URIRepresentation absoluteString];
    newNote.id = identifier;
    newNote.date =[NSDate new];
    newNote.type = @"笔记";
    newNote.content = self.noteTextView.text;
    
    NSError *error = nil;
    BOOL isSave =   [self.appdelegate.managedObjectContext save:&error];
    if (!isSave) {
        NSLog(@"error:%@,%@",error,[error userInfo]);
    }
    else{
        NSLog(@"保存成功");
        [self.allNotes addObject:newNote];
        [self.navigationController popViewControllerAnimated:true];
    }
}

@end
