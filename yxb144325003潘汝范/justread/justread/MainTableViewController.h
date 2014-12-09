//
//  MainTableViewController.h
//  justread
//
//  Created by Van on 14/12/5.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "Stories.h"
@interface MainTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *mainTableview;


- (void)fetchJson;
- (BOOL) serachWith:(Stories *) stories;
@end
