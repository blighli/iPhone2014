//
//  MyTableViewController.h
//  MyNotes
//
//  Created by 樊博超 on 14-11-21.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
@interface MyTableViewController : UITableViewController  <UIApplicationDelegate,UITableViewDataSource>
{
    Database * db;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath;
@end
