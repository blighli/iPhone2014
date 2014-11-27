//
//  NoteDB.m
//  homework4
//
//  Created by yingxl1992 on 14/11/20.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "NoteDB.h"

#define DBNAME @"Notelist.sqlite"
@implementation NoteDB

- (void)executeSQLOper:(NSString *)sql {
    char *error;
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库操作数据失败!+%s",error);
    }
}

-(sqlite3 *)getDB {
    if (database==nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
        if (sqlite3_open([database_path UTF8String], &database) != SQLITE_OK) {
            sqlite3_close(database);
            NSLog(@"数据库打开失败");
        }
        
        NSString *sql=@"CREATE TABLE IF NOT EXISTS NOTELIST(ID INTEGER PRIMARY KEY AUTOINCREMENT,addtime TEXT,title TEXT,content TEXT,image BLOB)";
        [self executeSQLOper:sql];
    }    
    return database;
}

-(sqlite3_stmt *)executeSQLQuery:(NSString *)sql {
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        return statement;
    }
    NSLog(@"数据库获取数据失败!");
    return nil;
}

@end
