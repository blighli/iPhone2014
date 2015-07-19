//
//  NoteDAO.m
//  MyNotes
//
//  Created by 杨长湖 on 14/11/23.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "NoteDAO.h"
#import "sqlite3.h"

@implementation NoteDAO

-(BOOL)openDatabase{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"db"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
        return NO;
    }else{
        return YES;
    }
}

-(BOOL)createTable{
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS Note (ID INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT,time TEXT)";
    return [self execSql:sqlCreateTable];
}

-(bool)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
        return NO;
    }
    return YES;
}

-(NSString*)currentTime{
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY/MM/dd/HH:mm"];
    NSString *  locationString = [dateformatter stringFromDate:senddate];
    NSLog(@"locationString:%@",locationString);
    
    return locationString;
}
//查找所有
-(NSMutableArray*)SelectNoteData{
    
    NSMutableArray *result = [[NSMutableArray alloc]init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Note"];
    
    sqlite3_stmt * statement;
    [self openDatabase];
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *note = (char*)sqlite3_column_text(statement, 1);
            char *time=(char*)sqlite3_column_text(statement,2);
            NSString *n = [[NSString alloc]initWithUTF8String:note];
            NSString *t = [[NSString alloc]initWithUTF8String:time];
            int ids=sqlite3_column_int(statement, 0);
            Note *textNote=[[Note alloc]initWithNote:n andTime:t andID:ids];
            [result addObject:textNote];
        }
    }
    return result;
}

//按时间查找
/*
-(Note*)SelectNoteDataById:(int)ids{
    NSLog(@"按id查找");
    Note *result  = [[Note alloc]init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Note where time = '%d'",ids];
    sqlite3_stmt * statement;
    [self openDatabase];
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        char *note = (char*)sqlite3_column_text(statement, 1);
        char *time = (char*)sqlite3_column_text(statement,2);
        NSString *n = [[NSString alloc]initWithUTF8String:note];
        NSString *t = [[NSString alloc]initWithUTF8String:time];
        int ids = sqlite3_column_int(statement, 0);
        result = [[Note alloc]initWithNote:n andTime:t andID:ids];
    }
    
    return result;
}
*/
//插入
-(void)saveToDatabase:(NSString*)s{
    NSLog(@"插入成功");
    NSString* time=[self currentTime];
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO Note (content,time) VALUES('%@','%@')",s,time];
    if([self openDatabase]){
        [self createTable];
        [self execSql:sql];
        sqlite3_close(db);
    }
}
//删除
-(void)deleteNoteWithId:(int)ids{
    NSString *sql=[NSString stringWithFormat:@"DELETE  FROM Note WHERE ID='%d'",ids];
    [self openDatabase];
    [self execSql:sql];
    sqlite3_close(db);
}
//修改
-(void)updateNoteWithTime:(int)ids note:(NSString *)s{
    NSLog(@"%d--%@",ids,s);
    NSString* time=[self currentTime];
    NSString *sql=[NSString stringWithFormat:@"UPDATE Note SET content='%@',time='%@' WHERE id='%d'",s,time,ids];
    [self openDatabase];
    [self execSql:sql];
    sqlite3_close(db);
    
}

@end
