//
//  MainTableViewController.h
//  Project4
//
//  Created by jingcheng407 on 14-11-23.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *MainTableView;
@property (strong,nonatomic) NSMutableArray* TableViewListArray;
@end
