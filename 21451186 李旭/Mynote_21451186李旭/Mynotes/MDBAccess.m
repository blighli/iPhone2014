//
//  MDBAccess.m
//  Mynotes
//
//  Created by lixu on 14/11/15.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import "MDBAccess.h"
#define DBNAME    @"noteDatas.sqlite"

@implementation MDBAccess

//-(id) init{
//    if ((self =[super init])) {
//        [self initializeDatabase];
//    }
//    return self;
//}

-(void) initializeDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
//    NSString *path=[[NSBundle mainBundle] pathForResource:@"noteDatas" ofType:@"db"];
//    if (sqlite3_open([path UTF8String], &database)==SQLITE_OK) {
//        NSLog(@"opening Database");
//    }else{
//        sqlite3_close(database);
//        NSAssert1(0, @"Failed to open Database: '%s'.", sqlite3_errmsg(database));
//    }
}

-(void) closeDatabase
{
    sqlite3_close(db);
//    if ((sqlite3_close(db))!=SQLITE_OK) {
//        NSAssert1(0, @"Error: Failed to close database:'%s'.", sqlite3_errmsg(db));
//    }
//    NSLog(@"关闭数据库");
}

-(NSMutableArray*) getAllDatas
{
    NSMutableArray *datasArray=[[NSMutableArray alloc] init];
    const char *sql="SELECT * FROM Data";
    sqlite3_stmt *statement;
    NSLog(@"==================================");
    int sqlResult=sqlite3_prepare_v2(db, sql, -1, &statement, NULL);
    if (sqlResult==SQLITE_OK) {
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            Datas *datas=[[Datas alloc] init];
            char *Note=(char *) sqlite3_column_text(statement, 2);
            char *Time=(char *) sqlite3_column_text(statement, 3);
            char *Name=(char *) sqlite3_column_text(statement, 4);
            
            datas.ID=sqlite3_column_int(statement, 0);
            datas.Type=sqlite3_column_int(statement, 1);
            datas.Note=(Note)? [NSString stringWithUTF8String:Note]:@"";
            datas.Time=(Time) ? [NSString stringWithUTF8String:Time] : @"";
            datas.Name=(Name) ? [NSString stringWithUTF8String:Name] : @"";
            
            [datasArray addObject:datas];
            }
        }else
        {
            NSLog(@"Problem with the database:");
            NSLog(@"%d",sqlResult);
    }
    
    return datasArray;
}

-(void)createTable{
//    NSLog(@"创建biao");
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS Data (ID INTEGER PRIMARY KEY AUTOINCREMENT, Type INT, Note TEXT,Time TEXT,Name TEXT)";
   [self execSql:sqlCreateTable];
}

//执行SQL语句
-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
}

-(void) saveDatas:(NSString *)content Type:(int)type NibName:(NSString *)nibName
{
//    NSLog(@"++++++++++++++++++保存数据");
    NSString *insertSQL=[NSString stringWithFormat:@"INSERT INTO Data ('Type','Note','Time','Name') VALUES('%d','%@','%@','%@');",type,content,[self currentTime],nibName];
    [self execSql:insertSQL];
}

-(void) deleteDatas:(int)id{
//    NSLog(@"-----------删除数据库-------------");
    NSString *deleteSQL=[NSString stringWithFormat:@"DELETE FROM Data WHERE ID='%d'",id];
    [self execSql:deleteSQL];
}

-( NSString*)currentTime{
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY/MM/dd/HH:mm"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSLog(@"locationString:%@",locationString);
    
    return locationString;
}


@end
