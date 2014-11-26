//
//  NoteListTableViewController.h
//  Note
//
//  Created by jiaoshoujie on 14-11-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteListTableViewController : UITableViewController{
    NSMutableArray *notes;
}

@property (nonatomic,strong) NSString *databaseFilePath;
@property (strong, nonatomic) IBOutlet UITableView *notesTableView;

@end
