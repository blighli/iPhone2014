//
//  ViewController.h
//  Evernote
//
//  Created by JANESTAR on 14-11-15.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property(nonatomic,retain)UITableView* myTableView;


@end

