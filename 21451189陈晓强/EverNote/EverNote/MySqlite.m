//
//  MySqlite.m
//  EverNote
//
//  Created by 陈晓强 on 14/11/29.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "MySqlite.h"
#import <sqlite3.h>
@implementation MySqlite


- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
//    NSLog(@"%@",[documentDirectory stringByAppendingString:@"data.sqlite"]);
    return [documentDirectory stringByAppendingString:@"data.sqlite"];
}

- (void)openDatabase:(sqlite3 **)database
{
    if (sqlite3_open([[self dataFilePath] UTF8String], database) != SQLITE_OK) {
//        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }else
    {
        NSLog(@"database");
    }
}

- (void)createMySqliteTableDatabase:(sqlite3 *)database andSql:(NSString *)sql
{
    char *errorMsg;
    if (sqlite3_exec(database, [sql UTF8String], NULL,NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating tabble : %s", errorMsg);
    }
}


- (void)insertOrUpdateMySqliteDatabase:(sqlite3 *)database andInsertSql:(NSString *)sql
                          andStatement:(sqlite3_stmt *) stmt andTitle:(NSString *) title
                               andData:(NSData *)data
{
    const void *rowData = [data bytes];
    char *errorMsg = NULL;
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [title UTF8String],(int)[title length], NULL);
        sqlite3_bind_blob(stmt, 2, rowData, (int)[data length], NULL);
        NSLog(@"come in update");
    }
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        NSAssert(0, @"Error updating table : %s",errorMsg);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
}

- (void)deleteMySqliteDatabase:(sqlite3 *)database andDeleteSql:(NSString *)sql
{
    
}


- (void)queryMySqliteDatabase:(sqlite3 *)database andQuerySql:(NSString *)sql andStatement:(sqlite3_stmt **) stmt
{
    
}


@end
