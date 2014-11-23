//
//  DBUtilis.m
//  MyNotes
//
//  Created by chencheng on 14/11/21.
//  Copyright (c) 2014年 jikexueyuan. All rights reserved.
//

#import "DBUtilis.h"
#import <sqlite3.h>

@interface DBUtilis ()

@property (nonatomic)  sqlite3 *database;

@end

@implementation DBUtilis
- (NSString *)docPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"data.sqlite"];
    return path;
}

//数据库初始化
- (sqlite3 *)database{
    if (_database == NULL) {
        if (sqlite3_open([[self docPath] UTF8String], &_database) != SQLITE_OK ) {
            sqlite3_close(_database);
            NSAssert(0, @"Failed to open database");
        }
        
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS MYNOTE "
        "(ID INTEGER PRIMARY KEY, NOTE_TEXT TEXT, NOTE_IMAGE BLOB, "
        "NOTE_TITLE TEXT, NOTE_TYPE TEXT);";
        char *errorMsg;
        if (sqlite3_exec(_database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(_database);
            NSAssert(0, @"Error creating table:%s", errorMsg);
        }
    }
    return _database;
}

//数据库的插入操作
- (void)insertText:(NSString *)text OrImage:(NSData *)imageData WithTitle:(NSString *)title ofType:(NSString *)type{
    char *insertSQL = NULL;
    //判断插入的类型
    if ([type isEqual:@"text"]) {
        insertSQL = "INSERT OR REPLACE INTO MYNOTE (NOTE_TEXT, NOTE_TITLE, NOTE_TYPE) VALUES (?, ?, ?);";
    }else{
        insertSQL = "INSERT OR REPLACE INTO MYNOTE (NOTE_IMAGE, NOTE_TITLE, NOTE_TYPE) VALUES (?, ?, ?);";
    }
    const char *errorMsg;
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2([self database], insertSQL, -1, &stmt, &errorMsg) == SQLITE_OK) {
        if ([type isEqual:@"text"]) {
            sqlite3_bind_text(stmt, 1, [text UTF8String], -1, NULL);
            
        }else{
            sqlite3_bind_blob(stmt, 1, [imageData bytes], [imageData length], NULL);
        }
        sqlite3_bind_text(stmt, 2, [title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [type UTF8String], -1, NULL);
        
    }
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        NSAssert(0, @"Error inserting table: %s", errorMsg);
        sqlite3_finalize(stmt);
    }
    [self releaseDB];
}
//释放数据库
- (void)releaseDB{
    sqlite3_close([self database]);
    _database = NULL;
}
//根据标题来删除数据库中的数据
- (void)deleteWithTitle:(NSString *)title{
    char *deleteSQL = "delete from MYNOTE where NOTE_TITLE = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2([self database], deleteSQL, -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [title UTF8String], -1, NULL);
        char *errorMsg = NULL;
        if (sqlite3_exec([self database], deleteSQL, NULL, NULL, &errorMsg) != SQLITE_OK) {
            NSAssert(0, @"Error deleteing table: %s", errorMsg);
        }
    }
    sqlite3_finalize(stmt);
    [self releaseDB];
}
//选择数据库中的元素
- (NSMutableArray *)selectDataFromDB{
    char *selectSQL = "select ID, NOTE_TEXT, NOTE_IMAGE, NOTE_TITLE, NOTE_TYPE from MYNOTE order by ID desc";
    sqlite3_stmt *stmt;
    NSMutableArray *data = [[NSMutableArray alloc] init];
    if (sqlite3_prepare_v2([self database], selectSQL, -1, &stmt, NULL) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            NSString *type = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 4)];
            [dic setObject:type forKey:@"type"];
            NSString *text = nil;
            if ([type isEqual:@"text"]) {
               text  = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            }else{
                text = @"";
            }
            
            [dic setObject:text forKey:@"text"];
            NSData *image = [NSData dataWithBytes:sqlite3_column_blob(stmt, 2) length:sqlite3_column_bytes(stmt, 2)];
            [dic setObject:image forKey:@"image"];
            NSString *tilte = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 3)];
            [dic setObject:tilte forKey:@"title"];
            
            
            [data addObject:dic];
        }
    }
    sqlite3_finalize(stmt);
    [self releaseDB];
    return data;
}
@end
