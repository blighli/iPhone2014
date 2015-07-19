//
//  sqlite3DB.m
//  Project3
//
//  Created by jingcheng407 on 14-11-15.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import "sqlite3DB.h"

@implementation sqlite3DB
- (NSString *)filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"Contacts.sqlite"];
}
////打开数据库的方法
//
//- (void)openDB{
//    if (sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK) {
//        sqlite3_close(db);
//        NSAssert(0, @"数据库打开失败。");
//    }
//}
////插入数据方法
//- (void)insertRecordIntoTableName:(NSString *)tableName
//                       withField1:(NSString *)field1 field1Value:(NSString *)field1Value
//                        andField2:(NSString *)field2 field2Value:(NSString *)field2Value
//                        andField3:(NSString *)field3 field3Value:(NSString *)field3Value {
//    
//    NSString *sql = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@') VALUES (?, ?, ?)",tableName, field1, field2, field3];
//    
//    sqlite3_stmt *statement;
//    
//    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
//        sqlite3_bind_text(statement, 1, [field1Value UTF8String], -1,NULL);
//        sqlite3_bind_text(statement, 2, [field2Value UTF8String], -1,NULL);
//        sqlite3_bind_text(statement, 3, [field3Value UTF8String], -1,NULL);
//    }
//    if (sqlite3_step(statement) != SQLITE_DONE) {
//        NSAssert(0, @"插入数据失败！");
//        sqlite3_finalize(statement);
//    }
//    
//}
//
//
////查询数据
//- (void)getAllContacts{
//    NSString *sql = @"SELECT * FROM members";
//    sqlite3_stmt *statement;
//    
//    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
//        while (sqlite3_step(statement) == SQLITE_ROW) {
//            
//            char *name = (char *)sqlite3_column_text(statement, 0);
//            NSString *nameStr = [[NSString alloc] initWithUTF8String:name];
//            
//            char *email = (char *)sqlite3_column_text(statement, 1);
//            NSString *emailStr = [[NSString alloc] initWithUTF8String:email];
//            
//            char *birthday = (char *)sqlite3_column_text(statement, 2);
//            NSString *birthdayStr = [[NSString alloc] initWithUTF8String:birthday];
//            
//            NSString *info = [[NSString alloc] initWithFormat:@"%@ - %@ - %@",
//                              nameStr, emailStr, birthdayStr];
//            
//        }
//        sqlite3_finalize(statement);
//    }
//}
@end
