//
//  NoteListTableViewController.h
//  homework4
//
//  Created by yingxl1992 on 14/11/15.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "NoteList.h"
#import "NoteDetailViewController.h"
#import "NoteDB.h"

@interface NoteListTableViewController : UITableViewController

{
    sqlite3 *database;
    NSMutableArray *alldata;
    NoteList *currentNotelist;
    NoteDB *noteDB;
}
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end
