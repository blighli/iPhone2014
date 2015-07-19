//
//  addNoteViewController.h
//  MyNotes
//
//  Created by 杨长湖 on 14/11/23.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteDAO.h"
#import "sqlite3.h"

@interface addNoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *content;
@property (strong,nonatomic)NoteDAO *dao;

- (IBAction)saveNoteButten:(id)sender;
- (IBAction)creatNote:(id)sender;

@end
