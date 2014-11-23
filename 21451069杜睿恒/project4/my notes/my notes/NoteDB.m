//
//  NoteDB.m
//  my notes
//
//  Created by shazhouyouren on 14/11/21.
//  Copyright (c) 2014年 shazhouyouren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteDB.h"
@interface NoteDB()
@end

@implementation NoteDB
@synthesize databasePath;
@synthesize db;

-(id) init
{
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        databasePath = [[NSString alloc] initWithString:[documents stringByAppendingPathComponent:DBNAME]];
        
    }
    if (sqlite3_open([databasePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    const char *createTableSql = "CREATE TABLE IF NOT EXISTS MYNOTE(ID INTEGER PRIMARY KEY AUTOINCREMENT, TIME TEXT, TYPE INTEGER, TITLE TEXT, DATA)";
    char *err;
    if (sqlite3_exec(db, createTableSql, NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库表创建失败!");
    }
    return (self);
}
-(NSArray*) getTitles{
    sqlite3_stmt* stmt;
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:20];
    char *sql = "SELECT ID,TITLE FROM MYNOTE ORDER BY TIME DESC";
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK) {
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            NSString* title = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSNumber* noteid = [[NSNumber alloc] initWithInt:sqlite3_column_int(stmt, 0)];
            NSMutableDictionary* dic = [NSMutableDictionary dictionary];
            [dic setObject:noteid forKey:@"id"];
            [dic setObject:title forKey:@"title"];
            [titles addObject:dic];
        }
        sqlite3_finalize(stmt);
        return titles;
    }
    else{
        return nil;
    }
}
-(NSDictionary*) getOneNote:(int)noteid
{
    NSMutableDictionary *note = [NSMutableDictionary dictionary];
    NSString* sql = [NSString stringWithFormat: @"SELECT ID,TIME, TYPE, TITLE, DATA FROM MYNOTE WHERE ID = %d ORDER BY TIME DESC" ,noteid];
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSNumber* noteid =[[NSNumber alloc] initWithInt:sqlite3_column_int(stmt, 0)];
            NSString* time = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSNumber* type =[[NSNumber alloc] initWithInt:sqlite3_column_int(stmt, 2)];
            NSString* title = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSString* data = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            [note setObject:noteid forKey:@"id"];
            [note setObject:time forKey:@"time"];
            [note setObject:type forKey:@"type"];
            [note setObject:title forKey:@"title"];
            [note setObject:data forKey:@"data"];
        }
    }
    else{
        NSLog(@"no found");
    }
    return note;
}

-(bool) insertNote:(NSString *)title withType:(int)type withTime:(NSString*) time withText:(NSString *)data{
    bool result = false;
    sqlite3_stmt *stmt;
    if(type == TEXT){
        NSString* sql = [NSString stringWithFormat:@"INSERT INTO MYNOTE (time,type,title,data) VALUES(\"%@\",%d,\"%@\",\"%@\")",time,type,title,data];
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK)
            result = true;
        sqlite3_finalize(stmt);
    }
    [self getTitles];
    return result;
}
-(bool) updateNote:(NSNumber*)noteid withTitle:(NSString*)title withType:(int) type
          withTime:(NSString*) time withText:(NSString*) data
{
    bool result = false;
    sqlite3_stmt *stmt;
    if(type == TEXT){
        NSString*sql = [NSString stringWithFormat:@"REPLACE INTO MYNOTE (id,time,type,title,data) VALUES(%d,\"%@\",%d,\"%@\",\"%@\")",noteid.intValue,time,type,title,data];
        if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK)
            result = true;
        sqlite3_finalize(stmt);
    }
    return result;
}
-(void) deleteNote:(int)noteid{
    NSString* sql = [NSString stringWithFormat:@"DELETE FROM MYNOTE WHERE ID = %d",noteid];
    if (sqlite3_exec(db, [sql UTF8String], nil, nil, NULL)==SQLITE_OK) {
        //
    }
}
-(void) closeDB
{
    sqlite3_close(db);
    
}
@end

