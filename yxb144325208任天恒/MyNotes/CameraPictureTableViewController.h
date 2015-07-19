//
//  CameraPictureTableViewController.h
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "PictureDetailViewController.h"

@interface CameraPictureTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

{
    sqlite3 *cameraDB;
    NSString *databasePath;
}

@property (nonatomic, retain) NSArray *listData;
- (IBAction)back:(id)sender;

@end
