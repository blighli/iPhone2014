//
//  EditNoteViewController.h
//  AnyNote
//
//  Created by 黄盼青 on 14/11/18.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "NoteData.h"
#import "PaintView.h"
#import "ViewController.h"

@interface EditNoteViewController : UIViewController

@property (strong,nonatomic) NSIndexPath *currentNote;
@property (weak,nonatomic) id delegate;

@property (strong, nonatomic) IBOutlet UITextView *textView;
- (IBAction)saveEditNote:(id)sender;
- (IBAction)closeView:(id)sender;
@end
