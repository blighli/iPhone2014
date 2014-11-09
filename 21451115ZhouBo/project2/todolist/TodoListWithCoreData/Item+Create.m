//
//  Item+Add.m
//  TodoListWithCoreData
//
//  Created by zhou on 14/11/9.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "Item+Create.h"
#import "CoreDataMethod.h"

@implementation Item (Create)
+ (Item *)CreateItemWithName:(NSString *)itemName
      inManagedObjectContext:(NSManagedObjectContext *)context
{
    Item *item;

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:context];

    item = [[Item alloc] initWithEntity:entity insertIntoManagedObjectContext:context];

    item.itemName = itemName;
    item.isCompleted = @NO;
    int cout = [CoreDataMethod countItemInContext:context].intValue +1;
    item.itemID = [NSNumber numberWithInt:cout];

    return item;
}
@end
