//
//  FirstViewController.h
//  Note
//
//  Created by Steve on 14-11-23.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    sqlite3 *db;
    IBOutlet UITextField *TextField;
    IBOutlet UITableView *TableView;
    NSMutableArray *tasks;
    NSInteger *index;
    UIAlertView *myAlertView;
}
-(IBAction) insert;

@end

