//
//  databaseOperation.m
//  Project4
//
//  Created by xvxvxxx on 14/11/21.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "databaseOperation.h"

@implementation databaseOperation
{
    sqlite3 *db;
}

-(void)openDatabse{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingString:@"/myDatabase.sqlite"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败-databaseOperation");
    }
    else
        NSLog(@"数据库打开成功-databaseOperation");
    NSLog(@"%@",database_path);
}

-(void)creatTable{
    char* error;
    NSString *sql = @"create table if not exists notes (id integer primary key autoincrement, title text, content text, photo text, picture text, datetime text)";
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"创建表失败-databaseOperation");
    }
    else
        NSLog(@"创建表成功-databaseOperation");
    
}
@end
