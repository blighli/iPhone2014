//
//  CoreDateMethod.h
//  TodoListWithCoreData
//
//  Created by zhou on 14/11/9.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Item.h"
@interface CoreDataMethod : NSObject

+ (NSMutableArray *)fetchAllInContext:(NSManagedObjectContext *)context;

+ (NSNumber *)countItemInContext:(NSManagedObjectContext *)context;

+ (BOOL)addItem:(Item *)todoitem inContext:(NSManagedObjectContext *)context;

+ (BOOL)updateItem:(Item *)todoitem inContext:(NSManagedObjectContext *)context;
+ (Item *)getItemWithID:(NSNumber *)itemID inContext:(NSManagedObjectContext *)context;

+ (BOOL)deleteItem:(Item *)todoitem inContext:(NSManagedObjectContext *)context;

@end
