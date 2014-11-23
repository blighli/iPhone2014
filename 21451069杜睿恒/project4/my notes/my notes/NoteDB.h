//
//  notedb.h
//  my notes
//
//  Created by shazhouyouren on 14/11/21.
//  Copyright (c) 2014年 shazhouyouren. All rights reserved.
//

#ifndef my_notes_notedb_h
#define my_notes_notedb_h
#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface NoteDB : NSObject
{
    #define DBNAME    @"mynote.sqlite"
    #define ID        @"id"
    #define TIME      @"time"
    #define TYPE      @"type"
    #define TITLE     @"title"
    #define DATA      @"data"
    #define TABLENAME @"MYNOTE"
    #define TEXT 1
    #define PIC 2
    NSString* databasePath;
    sqlite3 *db;
    
}

@property NSString* databasePath;
@property sqlite3 *db;
-(NSArray*) getTitles;
-(NSDictionary*) getOneNote:(int) noteid;
-(bool) insertNote:(NSString*)title withType:(int) type
        withTime:(NSString*) time withText:(NSString*) data;
-(bool) updateNote:(NSNumber*)noteid withTitle:(NSString*)title withType:(int) type
          withTime:(NSString*) time withText:(NSString*) data;
-(void) deleteNote:(int)noteid;
-(void) closeDB;
@end
#endif
