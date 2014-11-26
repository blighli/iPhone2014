//
//  CoreDataHelper.m
//  noteprotype
//
//  Created by zhou on 14/11/23.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "CoreDataHelper.h"
#import "ApplicationConstants.h"

@implementation CoreDataHelper

#pragma mark - method for note entity

/**
 *  get all the Note stored in the core data
 *
 *  @param context context
 *
 *  @return return is a mutable array copied with Note entity array;
 */
+ (NSMutableArray *)getAllNote:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                 entityForName:kNote
        inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *array = [fetchedObjects mutableCopy];
    return array;
}

+ (Note *)getNoteWithID:(NSNumber *)noteID inContext:(NSManagedObjectContext *)context
{
    Note *note = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
        [NSEntityDescription entityForName:kNote
                    inManagedObjectContext:context];
    [request setEntity:entity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@==%@", kNoteIdKey, noteID];
    [request setPredicate:predicate];

    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];

    if (!fetchedObjects)
    {
        NSLog(@"ERROR IN FETCHING");
    }

    if ([fetchedObjects count] >= 1)
    {
        note = [fetchedObjects objectAtIndex:0];
    }
    return note;
}
+ (void)deleteNote:(Note *)note inContext:(NSManagedObjectContext *)context
{
    [context deleteObject:note];
   // NSLog(@"delete here");
}

#pragma mark - method for all Entity

/**
 *  generator a unique id ,by add 1 to the lagerst id each time.
 *  //TODO UUID ?
 *
 *  @param entityName entity Name key, reference to ApplicationConstants.h
 *  @param entityId   entity Id key
 *  @param context    context
 *
 *  @return NSNumber
 */
+ (NSNumber *)gernerateUidForEntity:(NSString *)entityName
                           inContex:(NSManagedObjectContext *)context
{
    NSDictionary const *nameIdDic = @{
        @"Note" : @"note_id",
        @"Paint" : @"paint_id",
        @"Photo" : @"photo_id",
        @"Record" : @"record_id"
    };

   // NSLog(@"%@", [nameIdDic valueForKey:entityName]);
    //
    NSString *entityId          = [nameIdDic valueForKey:entityName];

    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    NSFetchRequest *request     = [[NSFetchRequest alloc] init];
    [request setEntity:entity];

    //sorting
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:entityId ascending:NO];
    NSArray *sortDescriptors         = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];

    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];

    if (!fetchedObjects)
    {
        NSLog(@"ERROR IN FETCHING");
    }

    //return id by add 1;
    if ([fetchedObjects count] == 0)
    {
        return [NSNumber numberWithInt:0];
    }
    else
    {
        NSManagedObject *latest = [fetchedObjects objectAtIndex:0];
        NSNumber *latestID      = [latest valueForKey:entityId];
        return [NSNumber numberWithInt:[latestID intValue] + 1];
    }
}

/**
 *  return a registed entity using entityKey name
 *
 *  @param entityName entity name ,reference to ApplicationConstants.h
 *  @param context    context
 *
 *  @return NSManagefObject
 */
+ (NSManagedObject *)CreateEntityFactory:(NSString *)entityName
                               inContext:(NSManagedObjectContext *)context
{
    NSDictionary const *nameIdDic = @{
        @"Note" : @"note_id",
        @"Paint" : @"paint_id",
        @"Photo" : @"photo_id",
        @"Record" : @"record_id"
    };

    NSManagedObject *entityObject;

    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];

    entityObject       = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    NSString *entityId = [nameIdDic valueForKey:entityName];

    NSNumber *uId      = [self gernerateUidForEntity:entityName
                                       inContex:context];
    if ([entityName isEqualToString:kNote]) {
        NSDate* date = [NSDate date];
        [entityObject setValue:date forKey:@"lastModifyTime"];
    }
    [entityObject setValue:uId forKey:entityId];

    return entityObject;
}

@end
