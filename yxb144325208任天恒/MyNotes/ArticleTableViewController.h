//
//  ArticleTableViewController.h
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ArticleTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>

{
    sqlite3 *noteDB;
    NSString *databasePath;
}
- (IBAction)back:(id)sender;


@property (nonatomic, retain) NSArray *listData;


@end
