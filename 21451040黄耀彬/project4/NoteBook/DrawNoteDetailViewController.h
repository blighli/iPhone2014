//
//  DrawNoteDetailViewController.h
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawBoardView.h"
#import "NoteEntity.h"

@interface DrawNoteDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet DrawBoardView *drawBoardView;
@property (strong, nonatomic) NoteEntity *noteEntity;
- (IBAction)modifyDrawNote:(id)sender;
@end
