//
//  editNoteViewController.h
//  MyNotes
//
//  Created by 杨长湖 on 14/11/28.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteDAO.h"

@interface editNoteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *editNoteTextView;
- (IBAction)editNotUpdate:(id)sender;
@property (nonatomic, strong) Note *editNote;

@end
