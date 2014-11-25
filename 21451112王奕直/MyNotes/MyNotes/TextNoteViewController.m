//
//  TextNoteViewController.m
//  MyNotes
//
//  Created by alwaysking on 14/11/23.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import "TextNoteViewController.h"
#import "ViewController.h"
#import "TextNote.h"

@interface TextNoteViewController ()

@end

@implementation TextNoteViewController

@synthesize textView;
@synthesize managedObjectContext;
@synthesize textFetchRequest;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    TextNote *note;
    if (tableItemClick) {
        note = [textNoteArray objectAtIndex:[textNoteArray count] - tableDataRow - 1];
        textView.text = [NSString stringWithFormat:@"%@",note.textItem];
    }
}

- (IBAction)cancelBtn:(id)sender{
    tableItemClick = false;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)okBtn:(id)sender{
    if (textView.text != nil) {
        NSError *error;
        if (tableItemClick) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            self.managedObjectContext = [appDelegate managedObjectContext];
            
            textFetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TextNote"
                                                      inManagedObjectContext:self.managedObjectContext];
            [textFetchRequest setEntity:entity];
            NSMutableArray *noteArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:textFetchRequest error:&error]];
            TextNote *note = (TextNote *)[noteArray objectAtIndex:[textNoteArray count] - tableDataRow - 1];
            [note setValue:textView.text forKey:@"textItem"];
            if (![note.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
        }
        else{
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            self.managedObjectContext = [appDelegate managedObjectContext];
            
            TextNote * textNote = [NSEntityDescription insertNewObjectForEntityForName:@"TextNote"
                                                                inManagedObjectContext:self.managedObjectContext];
            textNote.textItem = textView.text;
            
            textFetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TextNote"
                                                      inManagedObjectContext:self.managedObjectContext];
            
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            [textFetchRequest setEntity:entity];
            
            NSMutableArray *noteArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:textFetchRequest error:&error]];
            [textNoteArray addObject:[noteArray objectAtIndex:[noteArray count] - 1]];
        }
    }
    
    tableItemClick = false;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
