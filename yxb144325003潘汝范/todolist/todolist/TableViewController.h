//
//  TableViewController.h
//  todolist
//
//  Created by Van on 14/11/6.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TableViewController : UITableViewController
@property (strong,nonatomic) AppDelegate *myDelegate;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property NSManagedObjectContext *managedObjectContext;
- (IBAction)unwindToList:(UIStoryboardSegue *)segue;
+ (NSMutableArray *) getResult:(NSManagedObjectContext *)managedObjectContext;
+ (void) deleteCell:(TodoItem *)item :(NSManagedObjectContext *)managedObjectContext;
- (void) refrash;
@end
