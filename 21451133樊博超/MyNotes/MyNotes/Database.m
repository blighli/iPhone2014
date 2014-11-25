//
//  Database.m
//  MyNotes
//
//  Created by 樊博超 on 14-11-24.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Database.h"
#import "NoteData.h"
@implementation Database : NSObject 

-(instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void) openDatabase{
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *databaseFilePath = [[documentsPaths objectAtIndex:0] stringByAppendingString:@"db.sql"];
    if (sqlite3_open([databaseFilePath UTF8String], &database) == SQLITE_OK) {
        NSLog(@"open db is ok");
    }else{
        NSLog(@"can not open sqlite db");
        sqlite3_close(database);
    }
}

-(void)createTable{
    char * errMsg;
    const char *createSql="create table if not exists note(id integer primary key autoincrement,type text,name text,content text,pic blob)";
    if (sqlite3_exec(database, createSql, NULL, NULL, &errMsg) == SQLITE_OK) {
        NSLog(@"create is ok");
    }else{
        NSLog(@"can not create table");
        [self ErrorReport:[NSString stringWithUTF8String:createSql]];
    }
}


-(void)insertTable:(NSString*)name withtext:(NSString*)text{

    const char *insertSql = "insert into note (type, name, content) values(?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare(database, insertSql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, "text", -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(statement);
        NSLog(@"insert is ok");
    }else{
        NSLog(@"insert is failed");
    }
    sqlite3_finalize(statement);

}

-(void)insertTable:(NSString*)name withdata:(NSData*)data{
    NSLog(@"ddddddddddaaaaaaaaaaatttttttttt||||||||");
    const char *insertSql = "insert into note (type, name, pic) values(?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare(database, insertSql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, "pic", -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_blob(statement, 3, [data bytes], (int)[data length], SQLITE_TRANSIENT);
        sqlite3_step(statement);
        NSLog(@"insert is ok");
    }else{
        NSLog(@"insert is failed");
    }
    sqlite3_finalize(statement);
    
}

- (void)ErrorReport: (NSString *)item
{
    char *errorMsg;
    if (sqlite3_exec(database, [item cStringUsingEncoding:NSASCIIStringEncoding], NULL, NULL, &errorMsg)==SQLITE_OK)
    {
        NSLog(@"%@ ok.",item);
    }
    else
    {
        NSLog(@"error: %s",errorMsg);
        sqlite3_free(errorMsg); 
    }
}


//query table
- (NSMutableArray*)queryTable
{
    NSMutableArray *nameArray = [[NSMutableArray alloc] init];
    const char *selectSql="select * from note";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, selectSql, -1, &statement, nil)==SQLITE_OK)
    {
        NSLog(@"select ok.");
        while (sqlite3_step(statement)==SQLITE_ROW)//SQLITE_OK SQLITE_ROW
        {
            //int _id=sqlite3_column_int(statement, 0);
            NSString *type = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
            NSString *name=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
            NoteData * data = [[NoteData alloc] init];
            [data setType:type];
            [data setName:name];
            [nameArray addObject:data];
            NSLog(@"row>>id %@, name>> %@",type,name);
        }
        
    }
    else
    {
        //error
        [self ErrorReport: [NSString stringWithUTF8String:selectSql]];
    }
    
    sqlite3_finalize(statement);
    return nameArray;
}




- (NSMutableArray*)queryLine : (NSString*)type withname:(NSString*)name
{
    NSMutableArray *nameArray = [[NSMutableArray alloc] init];
    const char *selectSql="select * from note where type = ? and name = ?";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, selectSql, -1, &statement, nil)==SQLITE_OK)
    {
        NSLog(@"select ok.");
        
        sqlite3_bind_text(statement, 1, [type UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [name UTF8String], -1, SQLITE_TRANSIENT);
        
        while (sqlite3_step(statement)==SQLITE_ROW)//SQLITE_OK SQLITE_ROW
        {
            NSString *content;
            NSData * pic;
            NoteData * data = [[NoteData alloc] init];
            if ([type isEqualToString:@"text"]) {
               content=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
                [data setContent:content];
            }else if ([type isEqualToString:@"pic"]){
                int length = sqlite3_column_bytes(statement, 4);
                pic = [NSData dataWithBytes:sqlite3_column_blob(statement, 4) length:length];
               
                
                [data setPic:pic];
            }
            
            //[data setName:name];
            [nameArray addObject:data];
           // NSLog(@"row>>content %@",content);
        }
        
    }
    else
    {
        //error
        [self ErrorReport: [NSString stringWithUTF8String:selectSql]];
    }
    
    sqlite3_finalize(statement);
    return nameArray;
}


-(void)closeDatabase{
    sqlite3_close(database);
}

//delete table
- (void)deleteTable
{
    char *errorMsg;
    [self openDatabase];
    
    const char *sql = "DELETE FROM persons where id=24";
    if (sqlite3_exec(database, sql, NULL, NULL, &errorMsg)==SQLITE_OK)
    {
        NSLog(@"delete ok.");
    }
    else 
    {
        NSLog( @"can not delete it" );
        [self ErrorReport: [NSString stringWithUTF8String:sql]];
    }
    
}

@end