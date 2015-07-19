//
//  ViewController.h
//  MyNotes
//
//  Created by 杨长湖 on 14/11/23.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteDAO.h"
#import "editNoteViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (nonatomic,strong) NSMutableArray* noteList;

- (IBAction)addNoteButten:(id)sender;

@end

