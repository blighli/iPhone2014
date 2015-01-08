//
//  DB.m
//  Homework4
//
//  Created by 李丛笑 on 14/11/27.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DB.h"
#import "CourseData.h"
#import <sqlite3.h>
#define kFilename @"coursedata.sqlite3"

@interface DB()

@end

@implementation DB

-(NSString*)dataFilePath
{
    NSArray *DirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* DocuMentDir = [DirPath objectAtIndex:0];
    
    return [DocuMentDir stringByAppendingPathComponent:kFilename];
    
}

-(NSString *)CreateDB
{
    if (sqlite3_open([[self dataFilePath]UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        return @"Failed to Create The Memo Database !";
        
    }
    char *ErrorMessage;
//    NSString * create = @"CREATE TABLE IF NOT EXISTS Notes (ID INTEGER PRIMARY KEY AUTOINCREMENT,Title TEXT, Text TEXT);";
       NSString * create = @"CREATE TABLE IF NOT EXISTS Courses (ID INTEGER PRIMARY KEY AUTOINCREMENT,Classid TEXT, Classname TEXT);";

//     NSString * create = @"CREATE TABLE IF NOT EXISTS Courses (ID INTEGER PRIMARY KEY AUTOINCREMENT,Tableid TEXT, Dayid TEXT,Classid TEXT,Classname TEXT,Classteacher TEXT,Classtime TEXT Classroom TEXT);";
    if (sqlite3_exec(database,[create UTF8String],NULL,NULL,&ErrorMessage)== SQLITE_OK) {
        return @"Success to Create The Database and table Memo !";
    }else
    {
        sqlite3_close(database);
        return @"Failed to Create The table Memo !";
    }
   
    }

//-(NSString *)InsertDB:(int)number Tableid:(NSString *)tableid DayID:(NSString *)dayid ClassID:(NSString *)classid ClassName:(NSString *)classname ClassTeacher:(NSString *)classteacher ClassTime:(NSString *)classtime ClassRoom:(NSString *)classroom
-(NSString *)InsertDB:(int)number ClassID:(NSString *)classid ClassName:(NSString *)classname
{
    NSString *result;
    if ([classid length]==0) {
        result = @"empty";
    }
    else
    {
//        NSString *sql_insert = @"INSERT OR REPLACE INTO Courses(ID,Tableid,Dayid,Classid,Classname,Classteacher,Classtime,Classroom) VALUES(?,?,?,?,?,?,?,?); ";
       NSString *sql_insert = @"INSERT OR REPLACE INTO Courses(ID,Classid,Classname) VALUES(?,?,?); ";
        sqlite3_stmt *statment;
        
        if (sqlite3_prepare_v2(database, [sql_insert UTF8String], -1, &statment, nil)==SQLITE_OK)
        {
            sqlite3_bind_int(statment, 0, number);
            sqlite3_bind_text(statment, 1, [classid UTF8String], -1, NULL);
            sqlite3_bind_text(statment, 2, [classname UTF8String], -1, NULL);
           
            
            
        }
        
        if (sqlite3_step(statment)!=SQLITE_DONE) {
            sqlite3_close(database);
            result = @"insert error!";
        }else
        {
            sqlite3_finalize(statment);
            sqlite3_close(database);
            result = @"insert successfully!";
        }
        
        
     }
    return result;

}

-(NSString *)QueryDB
{
    NSString *result;
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:50];
    if (sqlite3_open([[self dataFilePath]UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        return @"Failed to Create The Memo Database !";
    }
//    NSString *sql_select = @"SELECT ID,Tableid,Dayid,Classid,Classname,Classteacher,Classtime,Classroom FROM Courses;";
    NSString *sql_select = @"SELECT * FROM Courses;";
    sqlite3_stmt *statment2;
    if (sqlite3_prepare_v2(database, [sql_select UTF8String], -1, &statment2, nil)==SQLITE_OK)
    {
        int i =0;
        while (sqlite3_step(statment2)==SQLITE_ROW) {
            CourseData *data = [[CourseData alloc]init];
            int id = i;
            data.id = id;
            char * classid = (char *)sqlite3_column_text(statment2, 1);
            data.classid = [NSString stringWithFormat:@"%s",classid];
            char * classname =(char *)sqlite3_column_text(statment2, 2);
            data.classname = [NSString stringWithFormat:@"%s",classname];
            if (classid!=NULL)
            {
                [datas addObject:data];
                i++;
            }
            else return @"finish!";
        }
        sqlite3_finalize(statment2);
    }
    else
        result = @"Failed to query!";
    
    return  datas;

}


-(NSString *)updateData:(int)number Newtitle:(NSString *)newtitle Newtext:(NSString *)newtext
{
    NSString *res;
//    if (sqlite3_open([[self dataFilePath]UTF8String], &database)!=SQLITE_OK) {
//        sqlite3_close(database);
//        res = @"Failed to Update The Memo Database !";
//        return @"Failed to Update The Memo Database !";
//    }
//
//    sqlite3_stmt * stmt;
//    NSString *sql_update = @"update Notes set Title=?,Text=? where ID = ?";
//    int result = sqlite3_prepare_v2(database, [sql_update UTF8String], -1, &stmt, Nil);
//    sqlite3_bind_text(stmt, 1, [newtitle UTF8String], -1, nil);
//    sqlite3_bind_text(stmt, 2, [newtext UTF8String], -1, nil);
//    sqlite3_bind_int(stmt, 3, number);
//    if (SQLITE_OK == result) {
//        if (sqlite3_step(stmt) == SQLITE_DONE) {
//            sqlite3_finalize(stmt);
//            res = @"Update successfully!";
//            return @"Update successfully!";
//        }else{
//            sqlite3_finalize(stmt);
//            res= @"Failed to update!";
//            return @"Failed to update!";
//            
//        }
//    }else{
//        sqlite3_finalize(stmt);
//        res  = @"fail!";
//        return @"fail!";
//        
//    }
    return res;
}

-(NSString *)deleteData:(NSString *)number
{
    NSString *result;
//    sqlite3_stmt * statament;
//    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:50];
//    if (sqlite3_open([[self dataFilePath]UTF8String], &database)!=SQLITE_OK) {
//        sqlite3_close(database);
//        return @"Failed to Create The Memo Database !";
//    }
//
//    NSString * sql_delete = @"DELETE FROM Course WHERE ID=?";
//    if (sqlite3_prepare_v2(database, [sql_delete UTF8String], -1, &statament, nil)==SQLITE_OK) {
//        sqlite3_bind_int(statament, 1, [number intValue]);
//    }
//    if (sqlite3_step(statament)!=SQLITE_DONE) {
//        NSLog(@"删除失败");
//    }else
//    {
//        NSLog(@"删除成功");
//       sqlite3_finalize(statament);
//        NSString * sql_select = @"SELECT ID,Title,Text FROM Notes;";
//        sqlite3_stmt * stats ;
//        int i = 0;
//        if (sqlite3_prepare_v2(database, [sql_select UTF8String], -1, &stats, nil)==SQLITE_OK)
//        {
//            while (sqlite3_step(stats)==SQLITE_ROW) {
//                int id = i;
//                char * title = (char *)sqlite3_column_text(stats, 1);
//                char * text =(char *)sqlite3_column_text(stats, 2);
//                if (title!=NULL) {
//                    Data * data = [[Data alloc] init];
//                    data.id = id;
//                    data.title= [NSString stringWithFormat:@"%s",title];
//                    data.text = [NSString stringWithFormat:@"%s",text];
//                    [datas addObject:data];
//                }
//                i++;
//            }
//            sqlite3_finalize(stats);
//        }
//        sqlite3_close(database);
//        }
//    sqlite3_close(database);
    return result;
}
-(NSString *)clearUp
{
    NSString *result;
//    sqlite3_stmt * statament;
//    if (sqlite3_open([[self dataFilePath]UTF8String], &database)!=SQLITE_OK)
//    {
//        sqlite3_close(database);
//        return @"Failed to Create The Memo Database !";
//    }
//    NSString * sql_delete = @"DELETE FROM Course";
//    if (sqlite3_prepare_v2(database, [sql_delete UTF8String], -1, &statament, nil)==SQLITE_OK)
//    {
//        
//    }

    return result;
}




@end
