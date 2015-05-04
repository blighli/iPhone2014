//
//  SecondViewController.h
//  Note
//
//  Created by Steve on 14-11-23.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AppDelegate.h"
#import "NoteViewController.h"
//#import "DB.h"

@interface SecondViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    NoteViewController *NextView;
    sqlite3 *db;
    IBOutlet UITableView *TableView;
    NSMutableArray *tasks;
    int No[200];
    NSInteger *index;
    UIAlertView *myAlertView;

}

-(IBAction) Create;


@end

