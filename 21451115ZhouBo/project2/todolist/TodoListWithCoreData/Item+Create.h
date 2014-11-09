//
//  Item+Add.h
//  TodoListWithCoreData
//
//  Created by zhou on 14/11/9.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface Item (Create)
+ (Item *)CreateItemWithName:(NSString *)itemName inManagedObjectContext:(NSManagedObjectContext *)context;
@end
