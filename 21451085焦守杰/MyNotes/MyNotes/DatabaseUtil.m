//
//  DatabaseUtil.m
//  MyNotes
//
//  Created by 焦守杰 on 14/11/15.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "DatabaseUtil.h"
@implementation DatabaseUtil
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

-(void)saveToDatabase:(NSString*)s withType:(NSString*)type {
    NSString* time=[self currentTime];
    // NSString *t=[NSString stringWithFormat:@"%f",time];
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO '%@' ('%@','%@','%@') VALUES('%@','%@','%@')",TABLENAME,TYPE,NOTE,TIME,type,s,time];
    if([self openDatabase]){
        [self createTable];
        [self execSql:sql];
        sqlite3_close(db);
    }
    //  NSLog(@"SUCCESS");
    
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
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSLog(@"locationString:%@",locationString);
    
    return locationString;
}
-(BOOL)createTable{
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS NoteInfo (ID INTEGER PRIMARY KEY AUTOINCREMENT, Type INT, note TEXT,time TEXT)";
    return [self execSql:sqlCreateTable];
}

-(NSMutableArray*)NoteDataWithType:(NSString*)type{
    
    NSMutableArray *result=[[NSMutableArray alloc]init];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM NoteInfo WHERE Type='%@'",type];
   
    sqlite3_stmt * statement;
    [self openDatabase];
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *note = (char*)sqlite3_column_text(statement, 2);
            char *time=(char*)sqlite3_column_text(statement,3);
            NSString *n = [[NSString alloc]initWithUTF8String:note];
            NSString *t = [[NSString alloc]initWithUTF8String:time];
            int id=sqlite3_column_int(statement, 0);
            NoteData *textNote=[[NoteData alloc]initWithNote:n andTime:t andID:id];
            [result addObject:textNote];
           
            
 //           NSLog(@"%@    %@   %d",n,t,id);
        }
    }
 //   NSLog(@"===================");
    return result;
}
-(void)deleteNoteWithId:(int)id{
    NSString *sql=[NSString stringWithFormat:@"DELETE  FROM NoteInfo WHERE ID='%d'",id];
    [self openDatabase];
    [self execSql:sql];
    sqlite3_close(db);
}

-(void)updateNoteWithID:(int)id note:(NSString *)s{
    NSString *sql=[NSString stringWithFormat:@"UPDATE NoteInfo SET note='%@',time='%@' WHERE ID='%d'",s,[self currentTime],id];
    [self openDatabase];
    [self execSql:sql];
    sqlite3_close(db);
//    NSLog(@"SUCCESS")   ;
    
}

@end
