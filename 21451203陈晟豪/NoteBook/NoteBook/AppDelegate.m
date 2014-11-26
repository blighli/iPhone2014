//
//  AppDelegate.m
//  NoteBook
//
//  Created by 陈晟豪 on 14/11/21.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import "AppDelegate.h"
#import "SecondViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

@synthesize contentArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.contentArray = [[NSMutableArray alloc] init];
    self.numberArray = [[NSMutableArray alloc] init];
    self.titleArray = [[NSMutableArray alloc] init];

    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingString:@"/diaryDatabase.sqlite"];
//    NSLog(@"%@",database_path);
    //尝试打开数据库
    sqlite3_open([database_path UTF8String], &_database);
    
    //两个字符串会被连接到一起
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FILEDS "
    "(ID INTEGER PRIMARY KEY AUTOINCREMENT, FILED_TITLE TEXT, FILED_DATA TEXT, PICTURE_PATH TEXT);";
    
    char *errorMsg;
    if (sqlite3_exec (_database, [createSQL UTF8String],
                      NULL, NULL, &errorMsg) != SQLITE_OK)
    {
        NSLog(@"数据库操作数据失败!");
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    sqlite3_close(_database);

}

@end
