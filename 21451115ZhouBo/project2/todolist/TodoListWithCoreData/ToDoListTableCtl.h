//
//  ToDoListTableCtl.h
//  todolist
//
//  Created by zhou on 14/11/6.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoListTableCtl : UITableViewController

@property NSMutableArray *toDoItems;

@property NSMutableArray *Items;

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
- (IBAction)clearItemDone:(id)sender;

-(IBAction)unWindToList:(UIStoryboardSegue*)segue;
@end
