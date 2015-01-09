//
//  DBHelper.m
//  FinalProject
//
//  Created by 李丛笑 on 15/1/4.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBHelper.h"
#import "CourseData.h"
#define kFilename @"coursesdata.sqlite3"
@interface DBHelper()
@end

@implementation DBHelper
-(NSString*)dataFilePath
{
    NSArray *DirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* DocuMentDir = [DirPath objectAtIndex:0];
    
    return [DocuMentDir stringByAppendingPathComponent:kFilename];
}

-(NSString *)CreateDB
{
    NSString *result;
    if (sqlite3_open([[self dataFilePath]UTF8String], &coursedb)!=SQLITE_OK) {
        sqlite3_close(coursedb);
        return @"Failed to Create The Memo Database !";
        
    }
    char *ErrorMessage;
    NSString * create = @"CREATE TABLE IF NOT EXISTS Courses (Classno TEXT PRIMARY KEY DEFAULT NULL,Classname TEXT, Classtime TEXT);";
    if (sqlite3_exec(coursedb,[create UTF8String],NULL,NULL,&ErrorMessage)== SQLITE_OK) {
        return @"Success to Create The Database and table Course !";
    }else
    {
        sqlite3_close(coursedb);
        return @"Failed to Create The table Course !";
    }

    return result;
}
-(NSString *)InsertDB:(NSString *)classid Classname:(NSString *)classname Classtime:(NSString *)classtime
{
    NSString *result;
    NSString *sql_insert = @"INSERT OR REPLACE INTO Courses(Classno,Classname,Classtime) VALUES(?,?,?); ";
    sqlite3_stmt *statment;
    if (sqlite3_prepare_v2(coursedb, [sql_insert UTF8String], -1, &statment, nil)==SQLITE_OK)
    {
        sqlite3_bind_text(statment, 1, [classid UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 2, [classname UTF8String], -1, NULL);
        sqlite3_bind_text(statment, 3, [classtime UTF8String], -1, NULL);
        
    }
    
    if (sqlite3_step(statment)!=SQLITE_DONE) {
        sqlite3_close(coursedb);
        result = @"insert error!";
    }else
    {
        sqlite3_finalize(statment);
        sqlite3_close(coursedb);
        result = @"insert successfully!";
    }

    return result;
}
-(NSString *)QueryDB:(NSString *)classno IfByClassid:(BOOL)ifbyclassid
{
    NSString *result;
    NSMutableArray *coursedatas = [NSMutableArray arrayWithCapacity:50];
    if (sqlite3_open([[self dataFilePath]UTF8String], &coursedb)!=SQLITE_OK) {
        sqlite3_close(coursedb);
        return @"Failed to Create The Memo Database !";
    }
    NSMutableString *sql_select = [[NSMutableString alloc]init];
    if (!ifbyclassid) {
        [sql_select appendString:@"SELECT * FROM Courses;"] ;
    }
    else{
        [sql_select appendString:@"SELECT * FROM Courses WHERE Classno = "];
        [sql_select appendString:classno];
    }
        sqlite3_stmt *statment;
    if (sqlite3_prepare_v2(coursedb, [sql_select UTF8String], -1, &statment, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statment)==SQLITE_ROW) {
            CourseData *coursedata = [[CourseData alloc]init];
            char * classid = (char *)sqlite3_column_text(statment, 0);
            coursedata.classid = [NSString stringWithFormat:@"%s",classid];
            char * classname = (char *)sqlite3_column_text(statment, 1);
            coursedata.classname = [NSString stringWithFormat:@"%s",classname];
            char * classtime =(char *)sqlite3_column_text(statment, 2);
            coursedata.classtime = [NSString stringWithFormat:@"%s",classtime];
            if (classid!=NULL)
            {
                [coursedatas addObject:coursedata];
            }
            else return @"finish!";
        }
        sqlite3_finalize(statment);
    }
    else
        return @"Failed to query!";

    return coursedatas;
}
-(NSString *)DeleteDB:(NSString *)classid IfByTableid:(BOOL)ifbytableid
{
    NSString *result;
    sqlite3_stmt * statament;
    NSMutableArray *coursedatas = [NSMutableArray arrayWithCapacity:50];
    if (sqlite3_open([[self dataFilePath]UTF8String], &coursedb)!=SQLITE_OK) {
        sqlite3_close(coursedb);
        return @"Failed to Create The Course Database !";
    }
       NSString * sql_delete;
    if (!ifbytableid) {
        sql_delete = @"DELETE FROM Courses WHERE Classno=?";
    }
    else{
        sql_delete = @"DELETE FROM Courses WHERE Classno LIKE ?";
    }

    if (sqlite3_prepare_v2(coursedb, [sql_delete UTF8String], -1, &statament, nil)==SQLITE_OK) {
       // sqlite3_bind_int(statament, 1, NULL);
        sqlite3_bind_text(statament, 1, [classid UTF8String], -1, NULL);
    }
    if (sqlite3_step(statament)!=SQLITE_DONE) {
        NSLog(@"删除失败");
    }else
    {
        NSLog(@"删除成功");
        sqlite3_finalize(statament);
    }
    sqlite3_close(coursedb);
    return coursedatas;
}


-(NSString *)CreateTableDB{
    NSString *result;
    if (sqlite3_open([[self dataFilePath]UTF8String], &coursedb)!=SQLITE_OK) {
        sqlite3_close(coursedb);
        return @"Failed to Create The Memo Database !";
        
    }
    char *ErrorMessage;
    NSString * create = @"CREATE TABLE IF NOT EXISTS Tables (Tableid TEXT PRIMARY KEY DEFAULT NULL,Tablename TEXT, Tabletheme TEXT);";
    if (sqlite3_exec(coursedb,[create UTF8String],NULL,NULL,&ErrorMessage)== SQLITE_OK) {
        return @"Success to Create The Database and table Course !";
    }else
    {
        sqlite3_close(coursedb);
        return @"Failed to Create The table Course !";
    }
    
    return result;
}

-(NSString *)InsertTableDB:(NSString *)tableid Tablename:(NSString *)tablename Tabletheme:(NSString *)tabletheme{
    NSString *result;
    NSString *sql_insert = @"INSERT OR REPLACE INTO Tables(Tableid,Tablename,Tabletheme) VALUES(?,?,?); ";
    sqlite3_stmt *statment;
    if (sqlite3_prepare_v2(coursedb, [sql_insert UTF8String], -1, &statment, nil)==SQLITE_OK)
    {
        sqlite3_bind_text(statment, 1, [tableid UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 2, [tablename UTF8String], -1, NULL);
        sqlite3_bind_text(statment, 3, [tabletheme UTF8String], -1, NULL);
        
    }
    
    if (sqlite3_step(statment)!=SQLITE_DONE) {
        sqlite3_close(coursedb);
        result = @"insert error!";
    }else
    {
        sqlite3_finalize(statment);
        sqlite3_close(coursedb);
        result = @"insert successfully!";
    }
    
    return result;

}

-(NSString *)QueryTableDB{
    NSString *result;
    NSMutableArray *coursedatas = [NSMutableArray arrayWithCapacity:50];
    if (sqlite3_open([[self dataFilePath]UTF8String], &coursedb)!=SQLITE_OK) {
        sqlite3_close(coursedb);
        return @"Failed to Create The Memo Database !";
    }
    NSString *sql_select = @"SELECT * FROM Tables;";
  
   
    sqlite3_stmt *statment;
    if (sqlite3_prepare_v2(coursedb, [sql_select UTF8String], -1, &statment, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statment)==SQLITE_ROW) {
            CourseData *coursedata = [[CourseData alloc]init];
            char * tableid = (char *)sqlite3_column_text(statment, 0);
            coursedata.classid = [NSString stringWithFormat:@"%s",tableid];
            char * tablename = (char *)sqlite3_column_text(statment, 1);
            coursedata.classname = [NSString stringWithFormat:@"%s",tablename];
            char * tabletheme =(char *)sqlite3_column_text(statment, 2);
            coursedata.classtime = [NSString stringWithFormat:@"%s",tabletheme];
            if (tableid!=NULL)
            {
                [coursedatas addObject:coursedata];
            }
            else return @"finish!";
        }
        sqlite3_finalize(statment);
    }
    else
        return @"Failed to query!";
    
    return coursedatas;

}

-(NSString *)DeleteTableDB:(NSString *)tableid{
    NSString *result;
    sqlite3_stmt * statament;
    NSMutableArray *coursedatas = [NSMutableArray arrayWithCapacity:50];
    if (sqlite3_open([[self dataFilePath]UTF8String], &coursedb)!=SQLITE_OK) {
        sqlite3_close(coursedb);
        return @"Failed to Create The Course Database !";
    }
    NSString * sql_delete = @"DELETE FROM Courses WHERE Classno=?";
    
    if (sqlite3_prepare_v2(coursedb, [sql_delete UTF8String], -1, &statament, nil)==SQLITE_OK) {
        sqlite3_bind_text(statament, 1, [tableid UTF8String], -1, NULL);
    }
    if (sqlite3_step(statament)!=SQLITE_DONE) {
        NSLog(@"删除失败");
    }else
    {
        NSLog(@"删除成功");
        sqlite3_finalize(statament);
        sqlite3_close(coursedb);
    }
    sqlite3_close(coursedb);
    return coursedatas;

    
}



@end