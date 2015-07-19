//
//  ViewController.h
//  Project4
//
//  Created by xvxvxxx on 14/11/20.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FMDB.h>
#import "Note.h"
#import "TableViewCell.h"
#import "AppDelegate.h"
@interface ViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property FMDatabase* db;

@end

