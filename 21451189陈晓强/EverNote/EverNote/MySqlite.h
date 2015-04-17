//
//  MySqlite.h
//  EverNote
//
//  Created by 陈晓强 on 14/11/29.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface MySqlite : NSObject
- (NSString *)dataFilePath;
- (void)openDatabase:(sqlite3 **)database;
- (void)createMySqliteTableDatabase:(sqlite3 *)database andSql:(NSString *)sql;
- (void)insertOrUpdateMySqliteDatabase:(sqlite3 *)database andInsertSql:(NSString *)sql
                          andStatement:(sqlite3_stmt *) stmt andTitle:(NSString *) title
                               andData:(NSData *)data;
- (void)deleteMySqliteDatabase:(sqlite3 *)database andDeleteSql:(NSString *)sql;
- (void)queryMySqliteDatabase:(sqlite3 *)database andQuerySql:(NSString *)sql andStatement:(sqlite3_stmt **) stmt;
@end
