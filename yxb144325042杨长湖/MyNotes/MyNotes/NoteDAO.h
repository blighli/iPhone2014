//
//  NoteDAO.h
//  MyNotes
//
//  Created by 杨长湖 on 14/11/23.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "sqlite3.h"

/*
#define DBNAME    @"db.sqlite"
#define TIME      @"time"
#define TYPE       @"Type"
#define NOTE   @"note"
#define TABLENAME @"NoteInfo"
#define TEXTDATA  @"0"
#define PICDATA  @"0"*/

@interface NoteDAO : NSObject
{
    sqlite3 *db;
}
-(bool)openDatabase:(NSString *)databaseName;
-(BOOL)createTable;
-(bool)execSql:(NSString *)sql;
-(NSMutableArray*)SelectNoteData;
-(Note*)SelectNoteDataByTime:(NSString *)time;
-(void)saveToDatabase:(NSString *)str;
-(void)deleteNoteWithId:(int)ids;
-(void)updateNoteWithTime:(int)ids note:(NSString *)s;

@end
