//
//  AppDelegate.m
//  noteprotype
//
//  Created by zhou on 14/11/17.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "AppDelegate.h"

//TODO delete the test code and date
#import "ApplicationConstants.h"
#import "Note.h"
#import "CoreDataHelper.h"
#import "Photo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
//    Note *note = [NSEntityDescription
//        insertNewObjectForEntityForName:kNote
//                 inManagedObjectContext:context];
//
//    note.title   = @"this is a test note ,remeber to delete it";
//    note.content = @"this is the content test ften fffffffff ngdsgaslghaflksfsj";
//
//    note.note_id = [CoreDataHelper gernerateUidForEntity:kNote inContex:context];
//    note.lastModifyTime = [NSDate date];
//
//    Photo *photo = (Photo *)[CoreDataHelper CreateEntityFactory:kPhoto inContext:context];
//    photo.photo_id   = [CoreDataHelper gernerateUidForEntity:kPhoto inContex:context];
//    photo.photoName  = @"ahhahah";
//    photo.photoUrl   = [[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"photo.png"] path];
//    photo.photoOwner = note;
//    [note addPhotoContainerObject:photo];
//
//    NSError *error = nil;
//    if (![context save:&error])
//    {
//        NSLog(@"couldn't save: %@", [error localizedDescription]);
//    }
//
//    //    NSURL* docPath = [self applicationDocumentsDirectory];
//    //    NSLog(@"%@",docPath);
//    {
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//        NSEntityDescription *entity = [NSEntityDescription
//                     entityForName:kNote
//            inManagedObjectContext:context];
//        [fetchRequest setEntity:entity];
//        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//        for (Note *note in fetchedObjects)
//        {
//            NSLog(@"id: %@", note.note_id);
//            NSLog(@"title: %@", note.title);
//            NSLog(@"content: %@", note.content);
//            NSLog(@"set count: %lu", (unsigned long)[note.photoContainer count]);
//        }
//    }
//    {
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//        NSEntityDescription *entity  = [NSEntityDescription
//                     entityForName:kPhoto
//            inManagedObjectContext:context];
//        [fetchRequest setEntity:entity];
//        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//        for (Photo *photo in fetchedObjects)
//        {
//            NSLog(@"id: %@", photo.photo_id);
//            NSLog(@"photo name: %@", photo.photoName);
//            NSLog(@"photo url: %@", photo.photoUrl);
//         //   NSLog(@"owner: %@", photo.photoOwner);
//        }
//    }
    
    
    // regist the observer when context changed(update,delete,insert)
    //auto save the data
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(contextChanged:)
     name:NSManagedObjectContextObjectsDidChangeNotification
     object:context];

    
    // Override point for customization after application launch.
    return YES;
}

-(void) contextChanged:(NSNotification* )notification
{
    //NSLog(@"context changed%@",[notification userInfo]);
   
    [self saveContext];
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Core Data stack

@synthesize managedObjectContext       = _managedObjectContext;
@synthesize managedObjectModel         = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory
{
    // The directory the application uses to store the Core Data store file. This code uses a directory named "nullptr.TodoListWithCoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel
{
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NoteItem" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }

    // Create the coordinator and store

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NoteItem.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator)
    {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
