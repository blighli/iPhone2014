//
//  AppDelegate.m
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-20.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import "AppDelegate.h"
#import <sqlite3.h>
#import "MySqlite3DbHelper.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)clearPath
{
    NSString *docsDir;
    NSArray *dirPaths;
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        docsDir = [dirPaths objectAtIndex:0];
    
    NSFileManager* fileManager=[NSFileManager defaultManager];
    //文件名
    arrayOnePiece = [[NSMutableArray alloc] init ];
    //读取XiaoBenZi.db中contents表的内容
    [self querySql:@"select id,title,type,info from contents where type =\"2\"" database:@"XiaoBenZi_1087.db"];
    int flag=0;
    for (int i =0; i<[arrayOnePiece count]; i++) {
        OnePiece*current=[arrayOnePiece objectAtIndex:i];
        BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:current.info];
        if( blHave == NO)
        {
            NSString* sql=[NSString stringWithFormat:@"delete from contents where id=\"%d\"",current.iD];
            [MySqlite3DbHelper execSql:sql database:@"XiaoBenZi_1087.db"];
        }
    }


}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //建表语句
    NSString* createTableSql=
    @"CREATE TABLE IF NOT EXISTS CONTENTS(ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT, TYPE TEXT,INFO TEXT)";
    
    //建表
    BOOL res=[MySqlite3DbHelper createTablebySql:createTableSql database:@"XiaoBenZi_1087.db"];
    if(res == NO)
    {
    }
    
    [self clearPath];
   
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
}
-(BOOL)querySql:(NSString *)sql database:(NSString *)databaseName
{
    sqlite3 * contactDB;
    sqlite3_stmt *statement;
    @try {
        NSString * databasePath = [MySqlite3DbHelper dbPathforDbName:databaseName];
        const char *dbpath = [databasePath UTF8String];
        
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            NSString *querySQL = sql;//[NSString stringWithFormat:@"SELECT address,phone from contacts where name=\"%@\"",name.text];
            const char *query_stmt = [querySQL UTF8String];
            NSLog(@"sql:%s",query_stmt);
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, nil) == SQLITE_OK)
            {
                NSLog(@"ok");
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    OnePiece * one = [[OnePiece alloc] init];
                    
                    //获取id，title，type，info
                    NSString* temp =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    [one setValue:temp forKey:@"iD"];
                    
                    temp =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    [one setValue:temp forKey:@"title"];
                    temp =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    [one setValue:temp forKey:@"type"];
                    temp =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                    [one setValue:temp forKey:@"info"];
                    
                    [arrayOnePiece addObject:one];
                }
                
                sqlite3_finalize(statement);
            }
            
            sqlite3_close(contactDB);
        }
        
        return YES;
    }
    @catch( NSException* ex)
    {
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
        return NO;
    }
}

@end
