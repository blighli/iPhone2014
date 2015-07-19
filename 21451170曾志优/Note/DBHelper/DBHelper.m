//
//  DBHelper.m
//  Note
//
//  Created by Mac on 14-11-21.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "DBHelper.h"

@implementation DBHelper

+(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDir=[paths objectAtIndex:0];
    return [documentsDir stringByAppendingString:@"data.sqlite"];
}

+(sqlite3 *)getDatabase
{
    sqlite3 *database;
    if(sqlite3_open([[self dataFilePath]UTF8String],&database)!=SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0, @"Fail to opnen database");
    }
    
    return database;
}

+(void) prepareTable
{
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS notes (row INTEGER PRIMAY KEY,topic  TEXT, content TEXT);";
    [self updateDatabase:createSQL];
    
    createSQL = @"CREATE TABLE IF NOT EXISTS scrawl (row INTEGER PRIMAY KEY,topic  TEXT,  binScrawl BLOB);";
    [self updateDatabase:createSQL];
    
    createSQL = @"CREATE TABLE IF NOT EXISTS image (row INTEGER PRIMAY KEY,topic  TEXT,  binImage BLOB);";
    [self updateDatabase:createSQL];
}

+(void)updateDatabase:(NSString *)sql
{
    sqlite3 *database = [self getDatabase];
   
    char *errorMsg;
    
    if(sqlite3_exec(database,[sql UTF8String],NULL,NULL,&errorMsg)!=SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0,@"Error delete table record:%s",errorMsg);
    }
}

+(void) closeDatabase:(sqlite3 *)database
{
    sqlite3_close(database);
}


@end
