//
//  AppDelegate.h
//  MySecretDiary
//
//  Created by icy on 14-12-19.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class RootContainerViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootContainerViewController *rootContainerViewController;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)firstStartAfterFreshInstall;
- (void)firstStartAfterUpgradeDowngrade;

@end

