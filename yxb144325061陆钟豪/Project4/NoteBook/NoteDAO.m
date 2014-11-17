//
//  NoteDAO.m
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/15.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <sqlite3.h>
#import "NoteDAO.h"
#import "SQLiteHelper.h"

@implementation NoteDAO

-(instancetype)init {
    self = [super init];
    [self createTable];
    return self;
}

-(void) createTable {
    char *errorMsg;
    if (sqlite3_exec([SQLiteHelper getDBHandle], "create table if not exists tb_note (id integer primary key autoincrement,type integer, content text not null);", NULL, NULL, &errorMsg)!=SQLITE_OK) {
        NSLog(@"create table error:%s", errorMsg);
    }
    else{
        NSLog(@"create table success");
    }
    sqlite3_free(errorMsg);
}

-(void) insertNote:(NoteEntity*) noteEntity {
    char *sql = "insert into tb_note(type, content) values(?, ?);";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2([SQLiteHelper getDBHandle], sql, -1, &statement, NULL)!=SQLITE_OK) {
        NSLog(@"insert sql step failed");
        return;
    }
    sqlite3_bind_int(statement, 1, noteEntity.type);
    const char *content = [noteEntity.content cStringUsingEncoding:NSUTF8StringEncoding];
    sqlite3_bind_text(statement, 2, content, (int)strlen(content), SQLITE_STATIC);
    int stepResult = sqlite3_step(statement);
    if (stepResult!=SQLITE_DONE) {
        NSLog(@"insert sql step failed, step result is %d", stepResult);
    }
    else {
        NSLog(@"insert sql step success");
    }
    sqlite3_finalize(statement);
}

-(void) deleteNoteById:(NSInteger) id {
    char *sql = "delete from tb_note where id = ?";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2([SQLiteHelper getDBHandle], sql, -1, &statement, NULL)!=SQLITE_OK) {
        NSLog(@"delete sql prepare failed");
        return;
    }
    sqlite3_bind_int(statement, 1, (int)id);
    if (sqlite3_step(statement)!=SQLITE_DONE) {
        sqlite3_finalize(statement);
        NSLog(@"delete sql step failed");
        return;
    }
    sqlite3_finalize(statement);
}

-(void) updateNote:(NoteEntity*) noteEntity {
    char *sql = "update tb_note set content = ? where id = ?";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2([SQLiteHelper getDBHandle], sql, -1, &statement, NULL)!=SQLITE_OK) {
        NSLog(@"update sql prepare failed");
        return;
    }
    const char *content = [noteEntity.content cStringUsingEncoding:NSUTF8StringEncoding];
    sqlite3_bind_text(statement, 1, content, (int)strlen(content), SQLITE_STATIC);
    sqlite3_bind_int(statement, 2, (int)noteEntity.id);
    if (sqlite3_step(statement)!=SQLITE_DONE) {
        sqlite3_finalize(statement);
        NSLog(@"update sql step failed");
        return;
    }
    sqlite3_finalize(statement);
}

-(NSMutableArray*) queryNoteByOffset:(NSInteger) offset andLength:(NSInteger) length {
    char *sql = "select id, type, content from tb_note order by id limit ?, ?";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2([SQLiteHelper getDBHandle], sql, -1, &statement, NULL)!=SQLITE_OK) {
        NSLog(@"query sql prepare failed");
        return nil;
    }
    sqlite3_bind_int(statement, 1, (int)offset);
    sqlite3_bind_int(statement, 2, (int)length);
    NSMutableArray *result = [NSMutableArray new];
    while(sqlite3_step(statement) == SQLITE_ROW) {
        NoteEntity *note = [NoteEntity new];
        note.id = sqlite3_column_int(statement, 0);
        note.type = sqlite3_column_int(statement, 1);
        note.content = [[NSString alloc] initWithCString:(const char*)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
        [result addObject:note];
    }
    sqlite3_finalize(statement);
    return result;
}

-(NoteEntity*) loadNoteByOffset:(NSInteger) offset {
    char *sql = "select id, type, content from tb_note order by id limit 1 offset ?";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2([SQLiteHelper getDBHandle], sql, -1, &statement, NULL)!=SQLITE_OK) {
        NSLog(@"query sql prepare failed");
        return nil;
    }
    sqlite3_bind_int(statement, 1, (int)offset);
    NoteEntity *note = nil;
    int stepResult = sqlite3_step(statement);
    if(stepResult == SQLITE_ROW) {
        note = [NoteEntity new];
        note.id = sqlite3_column_int(statement, 0);
        note.type = sqlite3_column_int(statement, 1);
        note.content = [[NSString alloc] initWithCString:(const char*)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
    }
    else {
        NSLog(@"load note by offset not found, step result is %d", stepResult);
    }
    sqlite3_finalize(statement);
    return note;
}

-(NoteEntity*) loadNoteById:(NSInteger) id {
    char *sql = "select id, type, content from tb_note where id = ?";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2([SQLiteHelper getDBHandle], sql, -1, &statement, NULL)!=SQLITE_OK) {
        NSLog(@"load sql prepare failed");
        return nil;
    }
    sqlite3_bind_int(statement, 0, (int)id);
    if(sqlite3_step(statement) == SQLITE_ROW) {
        NoteEntity *note = [NoteEntity new];
        note.id = sqlite3_column_int(statement, 0);
        note.type = sqlite3_column_int(statement, 1);
        note.content = [[NSString alloc] initWithCString:(const char*)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
        return note;
    }
    return nil;
}

-(NSInteger) getAllCount {
    char *sql = "select count(*) from tb_note";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2([SQLiteHelper getDBHandle], sql, -1, &statement, NULL)!=SQLITE_OK) {
        NSLog(@"get all count sql prepare failed");
        return 0;
    }
    NSInteger allCount = 0;
    if(sqlite3_step(statement) == SQLITE_ROW) {
        allCount = sqlite3_column_int(statement, 0);
    }
    sqlite3_finalize(statement);
    return allCount;

}

-(void) dealloc {
    [SQLiteHelper relaseDBHandle];
}

@end
