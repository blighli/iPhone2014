//
//  CoreDateMethod.m
//  TodoListWithCoreData
//
//  Created by zhou on 14/11/9.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "CoreDataMethod.h"
#import "AppDelegate.h"

@implementation CoreDataMethod

+ (NSNumber *)countItemInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
        [NSEntityDescription entityForName:@"Count"
                    inManagedObjectContext:context];
    [request setEntity:entity];
    [request setFetchLimit:1];

    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if ([results count] >= 1)
    {
        return results[0];
    }
    return [NSNumber numberWithInt:0];
}

+ (NSMutableArray *)fetchAllInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                 entityForName:@"Item"
        inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *array = [fetchedObjects mutableCopy];
    return array;
}

+ (BOOL)addItem:(Item *)todoitem inContext:(NSManagedObjectContext *)context
{
    NSError *error;
    if (![context save:&error])
    {
        return NO;
    }

    return YES;
}

+ (BOOL)updateItem:(Item *)todoitem inContext:(NSManagedObjectContext *)context
{
    NSError *error = nil;
    if (![context save:&error])
    {
        return NO;
    }
    return YES;
}

+ (Item *)getItemWithID:(NSNumber *)itemID inContext:(NSManagedObjectContext *)context
{
    Item *item = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
        [NSEntityDescription entityForName:@"Item"
                    inManagedObjectContext:context];
    [request setEntity:entity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemID==%@", itemID];
    [request setPredicate:predicate];

    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];

    if ([fetchedObjects count] >= 1)
    {
        item = [fetchedObjects objectAtIndex:0];
    }
    return item;
}

+ (BOOL)deleteItem:(Item *)todoitem inContext:(NSManagedObjectContext *)context
{
    NSError *error = nil;
    [context deleteObject:todoitem];
    if (![context save:&error])
    {
        return NO;
    }

    return YES;
}

@end
