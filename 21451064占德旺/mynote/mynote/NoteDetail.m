//
//  NoteDetail.m
//  mynote
//
//  Created by Devon on 14/11/21.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteDetail.h"
#import "NewNoteViewController.h"
#import "Note.h"

@interface NoteDetail ()

@property (weak, nonatomic) IBOutlet UITextView *noteContentText;
@property (weak, nonatomic) IBOutlet UIImageView *noteContentImage;

@end

@implementation NoteDetail

- (void)setNoteIndex:(NSString *)noteIndex {
    _noteIndex = noteIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noteContentText.layer.borderColor = UIColor.grayColor.CGColor;
    self.noteContentText.layer.borderWidth =1.0;
    self.noteContentText.layer.cornerRadius =5.0;
    self.noteContentText.delegate = self;
    self.noteContentImage.layer.borderColor = UIColor.grayColor.CGColor;
    self.noteContentImage.layer.borderWidth =1.0;
    self.noteContentImage.layer.cornerRadius =5.0;
    _myAppDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.noteIndex;
    [self loadTaskContent];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([@"\n" isEqualToString:text] == YES) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)selectData:(NSString *)index {
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* note=[NSEntityDescription entityForName:@"Note" inManagedObjectContext:_myAppDelegate.managedObjectContext];
    [request setEntity:note];
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"name==%@",index];
    [request setPredicate:predicate];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[_myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult!=nil) {
        for(Note *note in mutableFetchResult){
            self.noteContentText.text = [note valueForKey:@"c_text"];
            self.noteContentImage.image = [UIImage imageWithData:[note valueForKey:@"c_image"]];
        }
    }
}

- (void)loadTaskContent {
    [self selectData:self.noteIndex];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editNote"]) {
        [segue.destinationViewController setNoteIndex:self.noteIndex];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
