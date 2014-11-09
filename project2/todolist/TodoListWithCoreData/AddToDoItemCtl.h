//
//  AddToDoItemCtl.h
//  todolist
//
//  Created by zhou on 14/11/6.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface AddToDoItemCtl : UIViewController
@property  Item *todoItem;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@end
