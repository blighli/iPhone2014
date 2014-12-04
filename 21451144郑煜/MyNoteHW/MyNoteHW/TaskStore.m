//
//  TaskStore.m
//  TODOListHW
//
//  Created by StarJade on 14-11-10.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import "TaskStore.h"

#import <Foundation/Foundation.h>
#import <CoreData/NSManagedObjectContext.h>
#import <CoreData/NSManagedObjectModel.h>
#import <CoreData/NSPersistentStoreCoordinator.h>
#import <CoreData/NSEntityDescription.h>
#import <CoreData/NSFetchRequest.h>


@implementation TaskStore
{
    NSManagedObjectContext *_context;
    NSManagedObjectModel *_model;
}

@synthesize indexState;
@synthesize isDoop;
@synthesize doop;

// 获取数据所在路径
- (NSString *)modelPath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

//
- (id)init
{
    self = [super init];
    if (self) {
		indexState = -1;
        // Set up our model and context
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        NSURL *storeURL = [NSURL fileURLWithPath:self.modelPath];
        
        NSError *error;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            [NSException raise:@"Open Failed" format:@"Reason: %@", error.localizedDescription];
        }
        
        _context = [[NSManagedObjectContext alloc] init];
        _context.persistentStoreCoordinator = psc;
        _context.undoManager = nil;
    }
    return self;
}

+ (TaskStore *)sharedStore
{
    static TaskStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (Task *)createTask
{
    Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:_context];
    [_allTasks addObject:task];
    return task;
}

- (NSMutableArray *)allTasks
{
    if (!_allTasks) {
        NSFetchRequest *req = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [_model.entitiesByName objectForKey:@"Task"];
        req.entity = e;
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES];
        req.sortDescriptors = @[sd];
        
        // Fetch
        NSError *error;
        NSArray *result = [_context executeFetchRequest:req error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", error.localizedDescription];
        }
        _allTasks = [[NSMutableArray alloc] initWithArray:result];
    }
    return _allTasks;
}

- (void)removeTask:(Task *)task
{
    [_context deleteObject:task];
    [_allTasks removeObjectIdenticalTo:task];
}

- (void)save
{
    [_context save:nil];
}

@end

