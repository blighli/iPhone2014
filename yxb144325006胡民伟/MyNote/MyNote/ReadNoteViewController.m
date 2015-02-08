//
//  MainViewController.m
//  MyNote
//
//  Created by Cocoa on 14/11/20.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "ReadNoteViewController.h"
#import "AppDelegate.h"

@interface ReadNoteViewController ()
@property (weak, nonatomic) IBOutlet UITextView *readNoteTextView;
@property (weak, nonatomic) AppDelegate *appdelegate;
@property (strong, nonatomic) NSMutableArray *allNotes;
@property (strong, nonatomic) Note *note;
@end

@implementation ReadNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.readNoteTextView.text = self.note.content;
}


- (IBAction)ModifyNote:(id)sender {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Note" inManagedObjectContext:self.appdelegate.managedObjectContext]];
    
    //删除谁的条件在这里配置；
    NSString *id = self.note.id;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id==%@", id]];
    NSError* error = nil;
    NSArray* results = [self.appdelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSManagedObject *modifyNote = [results objectAtIndex:0];
    [modifyNote setValue:self.readNoteTextView.text forKey:@"content"];
    BOOL isUpdateSuccess = [self.appdelegate.managedObjectContext save:&error];
    if (!isUpdateSuccess) {
        NSLog(@"error:%@,%@",error,[error userInfo]);
    }
    else{
        NSLog(@"更新成功！");
        [self.allNotes removeObject:self.note];
        [self.allNotes addObject:(Note*) modifyNote];
        [self.navigationController popViewControllerAnimated:true];
    }
}

@end
