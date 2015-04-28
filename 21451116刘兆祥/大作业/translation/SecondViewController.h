//
//  SecondViewController.h
//  translation
//
//  Created by Steve on 14-12-24.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"
#import "WordViewController.h"

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    sqlite3 *db;
    IBOutlet UITableView *tableview;
    NSMutableArray *tasks;
    int index;
    UIAlertView *myAlertView;
    int No[1000];
    WordViewController *NextView;
}

@end

