//
//  DrawNoteDetailViewController.h
//  NoteBook
//
//  Created by LFR on 14/11/18.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawBoardView.h"
#import "NoteEntity.h"

@interface DrawNoteDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet DrawBoardView *drawBoardView;
@property (strong, nonatomic) NoteEntity *noteEntity;
- (IBAction)modifyDrawNote:(id)sender;
@end
