//
//  User.m
//  MySecretDiary
//
//  Created by icy on 14-12-19.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import "User.h"
#import "Diary.h"
#import "AppDelegate.h"
@implementation User



+(NSArray *)allDiariesSortedBy:(NSString *)sortDescriptor{
    if(!sortDescriptor)
        sortDescriptor = @"date";
    
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    
    
    NSSortDescriptor *sortBy= [[NSSortDescriptor alloc] initWithKey:sortDescriptor ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortBy]];
    
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    if(error)
    {   NSLog(@"%@\n", [error  description]);   }
    
    return array;

    

}

+(void)deleteAll{
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSError *error = nil;
    
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    if(error)
    {   NSLog(@"%@\n", [error  description]);   }
    
    
    for (NSManagedObject *opp in array)
    {
        [context deleteObject:opp ];
    }
    
    [context save:nil];


}


+(bool)deleteUser:(User *)user{
    
    
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    [context deleteObject:user];
    
    NSError *error = nil;
    [context save:&error];
    if(error)
    {
        NSLog(@"%@\n", [error  description]);
        return NO;
    }
    return YES;


}

//-(bool)save{
//    
//    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
//    
//    NSError *error = nil;
//    [context save:&error];
//    if(error)
//    {
//        NSLog(@"%@\n", [error  description]);
//        return NO;
//    }
//    
//    return YES;
//
//}

- (void)addDiaries:(NSSet *)values{

}
- (void)removeDiaries:(NSSet *)values{

}
@end