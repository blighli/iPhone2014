//
//  rootViewController.h
//  DataNote
//
//  Created by lh on 14-11-27.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property(nonatomic,retain)UITableView* myTable;
@end