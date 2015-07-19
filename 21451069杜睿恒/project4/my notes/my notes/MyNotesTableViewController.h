//
//  FirstViewController.h
//  my notes
//
//  Created by shazhouyouren on 14/11/15.
//  Copyright (c) 2014年 shazhouyouren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteDB.h"
@interface MyNotesTableViewController : UITableViewController
@property NSArray* titleAndIdList;
@property NoteDB *noteDB;
@end

