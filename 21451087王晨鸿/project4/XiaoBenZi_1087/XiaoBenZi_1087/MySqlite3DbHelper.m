//
//  MySqlite3DbHelper.m
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-22.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MySqlite3DbHelper.h"

@implementation MySqlite3DbHelper

///获取数据库路径
+(NSString*)dbPathforDbName :(NSString*)dbName
{
    NSString *docsDir;
    NSArray *dirPaths;
    NSString *databasePath;
    
    @try {
           // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: dbName]];
        return databasePath;
    }
    @catch (NSException *exception) {
        return nil;
    }

}
+(BOOL)createDbbyName:(NSString*)name
{
    @try {
        
        return YES;
    }
    @catch (NSException *exception) {
        return NO;
    }
    return NO;
}

///为数据库建表
+(BOOL)createTablebySql:(NSString*)sql database:(NSString*)databaseName
{
    NSString *databasePath;
    sqlite3 *contactDB;
    @try{
        databasePath =[MySqlite3DbHelper dbPathforDbName:databaseName];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath:databasePath] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &contactDB)==SQLITE_OK)
        {
            char *errMsg;
            const char * sql_stmt = [sql UTF8String];
//            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            if (sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
            {
                //status.text = @"创建表失败\n";
                NSLog(@"创建表失败");
                sqlite3_close(contactDB);
                return NO;
            }
        }
        else
        {
            //status.text = @"创建/打开数据库失败";
            NSLog(@"创建/打开数据库失败");
            sqlite3_close(contactDB);
            return NO;
        }
    }
        return YES;
    }
    @catch (NSException *ex)
    {
        NSLog(@"create exception");
        sqlite3_close(contactDB);
        return NO;
    }
}

///可以用来插入数据
+(BOOL)execSql:(NSString *)sql database:(NSString *)databaseName
{
    sqlite3* contactDB;
    sqlite3_stmt *statement;
    @try {
        
        
        
        NSString* databasePath =[self dbPathforDbName:databaseName];
        
           const char *dbpath = [databasePath UTF8String];
        
            if (sqlite3_open(dbpath, &contactDB)==SQLITE_OK) {
                NSString * execSql = sql;
                NSLog(@"sql:%@",sql);
//                NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO CONTACTS (name,address,phone) VALUES(\"%@\",\"%@\",\"%@\")",name.text,address.text,phone.text];
                const char *insert_stmt = [execSql UTF8String];
                sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
                if (sqlite3_step(statement)==SQLITE_DONE) {
                //status.text = @"已存储到数据库";
                }
                else
                {
                    //status.text = @"保存失败";
                    sqlite3_finalize(statement);
                    const char*count="select count(*) from content";
                    sqlite3_close(contactDB);
                    NSLog(@"exec fail");
                    return NO;
                }
                sqlite3_finalize(statement);
                sqlite3_close(contactDB);
            }
        
        return YES;
    }
    @catch (NSException *exception)
    {
        NSLog(@"exec exception");
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
        return NO;
    }

}

///查询只有一个nsinteger值结果的sql语句
+(NSInteger)queryOneNSIntegerSql:(NSString*)sql database:(NSString*)databaseName
{
    sqlite3 * contactDB;
    sqlite3_stmt *statement;
    NSInteger res;
    @try {
        NSString * databasePath = [self dbPathforDbName:databaseName];
        const char *dbpath = [databasePath UTF8String];
        
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            NSString *querySQL = sql;
            const char *query_stmt = [querySQL UTF8String];//char数组型sql语句
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)//由于只需要一个值,所以是if
                {
                    NSString *result = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    res=[result integerValue];
                }
                
                sqlite3_finalize(statement);
            }
            
            sqlite3_close(contactDB);
        }
        
        return res;
    }
    @catch( NSException* ex)
    {
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
        return NO;
    }

    return -1;
}
///范例程序，不可用，可参考
+(BOOL)querySql:(NSString *)sql database:(NSString *)databaseName
{
    sqlite3 * contactDB;
    sqlite3_stmt *statement;
    NSMutableArray * array =[[NSMutableArray alloc] init ];
    @try {
    NSString * databasePath = [self dbPathforDbName:databaseName];
    const char *dbpath = [databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = sql;
        const char *query_stmt = [querySQL UTF8String];//char数组型sql语句
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                //address.text = addressField;
                
                NSString *phoneField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1    )];
            }

            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    
        return YES;
    }
    @catch( NSException* ex)
    {
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
        return -1;
    }
}
@end