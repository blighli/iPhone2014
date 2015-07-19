//
//  SQLiteConnection.m
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/15.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "SQLiteHelper.h"

static sqlite3 *dbHandle = nil;

@implementation SQLiteHelper

+ (sqlite3 *) getDBHandle {
    if(dbHandle == nil) {
        NSString *dbPath=[NSString stringWithFormat:@"%@/Documents/note_book.db",NSHomeDirectory()];
        if(sqlite3_open([dbPath UTF8String], &dbHandle)==SQLITE_OK) {
            NSLog(@"打开数据库成功!");
        }
    }
    return dbHandle;
}

+ (void) relaseDBHandle{
    NSLog(@"关闭数据库中!");
    int closeResult = sqlite3_close(dbHandle);
    if(closeResult==SQLITE_OK){
        NSLog(@"关闭数据库成功!");
        dbHandle = nil;
    }
    else if(closeResult == SQLITE_BUSY)
    {
        // shouldn't happen in a good written application but let's handle it
        NSLog(@"sqlite is busy, try to finalize some stmts");
        sqlite3_stmt *stmt;
        while ((stmt = sqlite3_next_stmt(dbHandle, NULL)) != NULL) {
            sqlite3_finalize(stmt);
        }
        closeResult = sqlite3_close(dbHandle);
        if (closeResult == SQLITE_OK) {
            NSLog(@"close db success");
            dbHandle = nil;
        }
        else {
            NSLog(@"close db failed, colse result is %d", closeResult);
        }
    }
    else {
        NSLog(@"close db failed, colse result is %d", closeResult);
    }
}

@end
