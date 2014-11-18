//
//  NewNoteViewController.h
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

@interface NewNoteViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak,nonatomic) id delegate;

- (IBAction)closeView:(id)sender;
- (IBAction)saveNote:(id)sender;
@end
