//
//  DatabaseUtil.h
//  MyNotes
//
//  Created by 焦守杰 on 14/11/15.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

//#ifndef MyNotes_DatabaseUtil_h
//#define MyNotes_DatabaseUtil_h
//
//
//#endif
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "NoteData.h"

#define DBNAME    @"db.sqlite"
#define TIME      @"time"
#define TYPE       @"Type"
#define NOTE   @"note"
#define TABLENAME @"NoteInfo"
#define TEXTDATA  @"0"
#define PICDATA  @"0"
//#define TEXTDATA  @"0"

@interface DatabaseUtil:NSObject{
    sqlite3 *db;
}
-(bool)openDatabase:(NSString *)databaseName;
-(BOOL)createTable;
-(void)saveToDatabase:(NSString *)str withType:(NSString*)type;
-(bool)execSql:(NSString *)sql;
-(NSMutableArray*)NoteDataWithType:(NSString*)type;
-(void)deleteNoteWithId:(int)id;
-(void)updateNoteWithID:(int)id note:(NSString *)s;
@end