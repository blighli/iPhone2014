//
//  DB.m
//  project4
//
//  Created by xuyouyang on 14/11/23.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "DB.h"
#import "Note.h"
#import <sqlite3.h>

@implementation DB

sqlite3 *database;

+ (BOOL)openDataBase{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"database.sqlite"];//database.sqlite为自己定义数据库名称
    NSLog(path);
    if(sqlite3_open([path UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Error: open database file.");
        return NO;
    } else {
        NSLog(@"open database file.");
        // 建表
        char *errorMsg;
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS NOTES "
                                "(title VARCHAR(100),"
                                "content VARCHAR(100),"
                                "imagePath VARCHAR(100),"
                                "type VARCHAR(100))";
        if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0, @"Error creating table: &s", errorMsg);
            return  NO;
        } else {
            NSLog(@"create database successfully!");
            return YES;
        }
    }
}

+ (sqlite3_stmt *)exectueQuery:(NSString *)query{
    if ([self openDataBase]) {
        // 打开数据库成功
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) != SQLITE_OK) {
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
        return statement;
    }
    return nil;
}

@end
