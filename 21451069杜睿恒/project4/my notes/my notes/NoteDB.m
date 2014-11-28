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
static NoteDB* sharedNoteDB = nil;
+(NoteDB*) sharedNoteDB{
    @synchronized(self) {
        if (sharedNoteDB == nil) {
            sharedNoteDB = [[self alloc] init]; // assignment not done here
        }
    }
    return sharedNoteDB;
}
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
-(NSArray*) getTitles:(int) type{
    sqlite3_stmt* stmt;
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:20];
    NSString *sql = [NSString stringWithFormat: @"SELECT ID,TITLE FROM MYNOTE WHERE TYPE = %d ORDER BY TIME DESC",type];
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
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
            if([type intValue] == TEXT){
                NSString* data = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
                [note setObject:data forKey:@"data"];
            }
            else if([type intValue] == PIC || [type intValue] == PAINTING){
                int length = sqlite3_column_bytes(stmt, 4);
                NSData *data= [NSData dataWithBytes:sqlite3_column_blob(stmt, 4) length:length];
                [note setObject:data forKey:@"data"];
            }
            else{
            }
            [note setObject:noteid forKey:@"id"];
            [note setObject:time forKey:@"time"];
            [note setObject:type forKey:@"type"];
            [note setObject:title forKey:@"title"];
            
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
    NSString* sql = [NSString stringWithFormat:@"INSERT INTO MYNOTE (time,type,title,data) VALUES(\"%@\",%d,\"%@\",\"%@\")",time,type,title,data];
    //char* msg;
    //sqlite3_p
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        sqlite3_step(stmt);
    sqlite3_finalize(stmt);
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
            sqlite3_step(stmt);
        sqlite3_finalize(stmt);
    }
    return result;
}
-(void) updatePainting:(NSNumber*)noteid withTitle:(NSString*)title withType:(int) type
              withTime:(NSString*) time withDate:(NSData*) data
{
    sqlite3_stmt *stmt;
    char *sql = "REPLACE INTO MYNOTE (id,time,type,title,data) VALUES(?,?,?,?,?)";
    if(sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK){
        sqlite3_bind_int(stmt, 1, [noteid intValue]);
        sqlite3_bind_text(stmt, 2, [time UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(stmt, 3, type);
        sqlite3_bind_text(stmt, 4, [title UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_blob(stmt, 5, [data bytes], [data length], SQLITE_TRANSIENT);
    }
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
}
-(void) deleteNote:(int)noteid{
    NSString* sql = [NSString stringWithFormat:@"DELETE FROM MYNOTE WHERE ID = %d",noteid];
    if (sqlite3_exec(db, [sql UTF8String], nil, nil, NULL)==SQLITE_OK) {
        //
    }
}
-(void) savePic:(NSString*)title withType:(int) type
       withTime:(NSString*) time withData:(NSData*) data{
    sqlite3_stmt *stmt;
    char* sql = "INSERT INTO MYNOTE (time,type,title,data) VALUES(?,?,?,?)";
    if(sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK){
        sqlite3_bind_text(stmt, 1, [time UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(stmt, 2, type);
        sqlite3_bind_text(stmt, 3, [title UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_blob(stmt, 4, [data bytes], [data length], SQLITE_TRANSIENT);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
    }
}
-(void) closeDB
{
    sqlite3_close(db);
    
}
@end

