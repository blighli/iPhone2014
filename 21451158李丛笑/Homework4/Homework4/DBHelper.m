//
//  DBHelper.m
//  Homework4
//
//  Created by 李丛笑 on 15/1/8.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBHelper.h"
#import "Data.h"
#import <sqlite3.h>
#define kFilename @"data.sqlite3"

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
    if (sqlite3_open([[self dataFilePath]UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        return @"Failed to Create The Memo Database !";
        
    }
    char *ErrorMessage;
    NSString * create = @"CREATE TABLE IF NOT EXISTS MyNotes (ID Text PRIMARY KEY DEFAULT NULL,Title TEXT, Text TEXT);";
    if (sqlite3_exec(database,[create UTF8String],NULL,NULL,&ErrorMessage)== SQLITE_OK) {
        return @"Success to Create The Database and table Memo !";
    }else
    {
        sqlite3_close(database);
        return @"Failed to Create The table Memo !";
    }
    
}

-(NSString *)InsertDB:(NSString *)contentid Title:(NSString *) title Text:(NSString *)text
{
    NSString *result;
    if ([title length]==0||[text length]==0) {
        result = @"empty";
    }
    else
    {
        NSString *sql_insert = @"INSERT OR REPLACE INTO MyNotes(ID,Title,Text) VALUES(?,?,?); ";
        sqlite3_stmt *statment1;
        
        if (sqlite3_prepare_v2(database, [sql_insert UTF8String], -1, &statment1, nil)==SQLITE_OK)
        {
            sqlite3_bind_text(statment1, 1, [contentid UTF8String],-1,NULL);
            sqlite3_bind_text(statment1, 2, [title UTF8String], -1, NULL);
            sqlite3_bind_text(statment1, 3, [text UTF8String], -1, NULL);
            
        }
        
        if (sqlite3_step(statment1)!=SQLITE_DONE) {
            sqlite3_close(database);
            result = @"insert error!";
        }else
        {
            sqlite3_finalize(statment1);
            sqlite3_close(database);
            result = @"insert successfully!";
        }
        
        
    }
    return result;
    
}

-(NSString *)QueryDB
{
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:50];
    if (sqlite3_open([[self dataFilePath]UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        return @"Failed to Create The Memo Database !";
    }
    NSString *sql_select = @"SELECT ID,Title,Text FROM MyNotes;";
    sqlite3_stmt *statment2;
    if (sqlite3_prepare_v2(database, [sql_select UTF8String], -1, &statment2, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statment2)==SQLITE_ROW) {
            Data *data = [[Data alloc]init];
            char * contentid = (char *)sqlite3_column_text(statment2, 0);
            data.contentid = [NSString stringWithFormat:@"%s",contentid];
            char * title = (char *)sqlite3_column_text(statment2, 1);
            data.title = [NSString stringWithFormat:@"%s",title];
            char * text =(char *)sqlite3_column_text(statment2, 2);
            data.text = [NSString stringWithFormat:@"%s",text];
            if (title!=NULL)
            {
                [datas addObject:data];
                           }
            else return @"finish!";
        }
        sqlite3_finalize(statment2);
    }
    else
        return @"Failed to query!";
    
    return  datas;
    
}



-(NSString *)deleteData:(NSString *)contentid
{
    NSString *result;
    sqlite3_stmt * statament;
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:50];
    if (sqlite3_open([[self dataFilePath]UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        return @"Failed to Create The Memo Database !";
    }
    
    NSString * sql_delete = @"DELETE FROM MyNotes WHERE ID=?";
    if (sqlite3_prepare_v2(database, [sql_delete UTF8String], -1, &statament, nil)==SQLITE_OK) {
        sqlite3_bind_text(statament, 1, [contentid UTF8String], -1, NULL);
    }
    if (sqlite3_step(statament)!=SQLITE_DONE) {
        NSLog(@"删除失败");
    }else
    {
        NSLog(@"删除成功");
        sqlite3_finalize(statament);
        sqlite3_close(database);
    }
    sqlite3_close(database);
    return result;
}




@end
